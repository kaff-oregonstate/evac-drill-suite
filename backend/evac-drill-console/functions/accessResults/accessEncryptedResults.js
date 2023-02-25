const path = require('path');
const os = require('os');
const fs = require('fs');
const archiver = require('archiver');
const hash = require('object-hash');

const admin = require("firebase-admin");
const { Timestamp } = require('firebase-admin/firestore');
const functions = require("firebase-functions");

const localDB = admin.firestore(admin.app('evac-drill-console'));
const rARCollection = localDB.collection('ResultsAccessRecord');
const drillPlanCollection = localDB.collection('DrillPlan');

const localBucketName = 'evac-drill-console.appspot.com';
const localStore = admin.storage(admin.app('evac-drill-console')).bucket(localBucketName);

const remoteBucketName = 'evacuation-drill-app-osu.appspot.com'
const remoteStore = admin.storage(admin.app('evac-drill-app')).bucket(remoteBucketName);

exports.accessEncryptedResults = functions
    .runWith({ maxInstances: 18 })
    .https.onCall(accessEncryptedResults);

async function accessEncryptedResults(data, context) {
    if (!context.auth) {
        console.error('no auth???')
        return {
            error: 'noAuth',
            errorText: 'nooooo',
        }
    }

    /// get the public key that these results were encrypted with:
    const publicKey = (await drillPlanCollection.doc(data.drillID).get()).get('publicKey');
    // const publicKey = (await drillPlanCollection.doc('4VJVpHgx958TzuAy0nwm').get()).get('publicKey');

    /// FUTURE:
    /// this endpoint is not currently protected by DrillPlan.creatorID, but could 
    /// in the future: if so, add `authorized` bool field to ResultsAccessRecord

    /// make a new AccessRecord in firestore
    const nowTime = Timestamp.now();
    let accessRecord = {
        debug: true,
        uid: context.auth.uid,
        drillID: data.drillID,
        accessed: nowTime,
        publicKey: publicKey ?? null,
    }
    const thisRARDocRef = await rARCollection.add(accessRecord)

    /// get the list of relevant files for the drill's results
    const files = await gatherRelevantFiles(data.drillID);

    /// digest the results for the access record
    accessRecord.resultsDigest = digestResults(files)
    accessRecord.resultsHash = hash(accessRecord.resultsDigest)

    /// check if a different zip will do:
    if (!data.enforeDuplicateResultsZip) {
        const checkRARsQuery = (resultsHash) => rARCollection.where('resultsHash', '==', resultsHash);
        const querySnapshot = await checkRARsQuery(accessRecord.resultsHash).get();
        if (querySnapshot.size >= 1) {
            console.log(`found duplicate result set, checking if in existence…: ${accessRecord.resultsHash}`);
            for (const doc of querySnapshot.docs) {
                /// get the place where those zipped results were put
                const zipDestination = doc.get('zipDestination');
                if (!zipDestination) break;

                /// query cloud storage and see if anything's still there
                const zipExists = await localStore.file(zipDestination).exists()

                if (zipExists) {
                    /// log
                    accessRecord.redirect = doc.id;
                    thisRARDocRef.update(accessRecord);
                    console.log(`redirecting to existing duplicate result set: ${zipDestination}`)

                    /// link to that zip
                    return {
                        success: 'redirected',
                        resultsAccessRecord: thisRARDocRef.id,
                        zipDestination: zipDestination
                    }
                }
            }
        }
    }

    /// error check no relevant files, return error
    if (files.length === 0) {
        /// log the error
        console.error(`no results? for drillID: ${data.drillID}`)

        /// fire off an update to the access record
        accessRecord.success = false;
        thisRARDocRef.update(accessRecord)

        return {
            error: 'noResults',
            errorText: 'no results for this drillID',
            resultsAccessRecordID: thisRARDocRef.id,
        }
    }

    /// define the location of the output stream
    const outputFileName = `results-${data.drillID}.zip`;
    const tempFilePath = path.join(os.tmpdir(), outputFileName);

    /// ensure sure any previously uncleaned export gets cleant
    if (fs.existsSync(tempFilePath)) fs.unlinkSync(tempFilePath);

    /// zip the files up into memory
    await zipFiles(files, tempFilePath, accessRecord)

    /// write the zip to ``localStorage`` and return dl link to that file
    const zipDestination = `DrillResultZips/${thisRARDocRef.id}/${data.drillID}-${nowTime.toDate().toISOString()}.zip`;
    await localStore.upload(tempFilePath, { destination: zipDestination });

    /// log
    accessRecord.success = true;
    accessRecord.zipDestination = zipDestination;
    console.log('wrote a new results zip to cloud storage:');
    console.log(tempFilePath);
    console.log(zipDestination);

    /// clean up after ourselves in (tmp || memory)
    fs.unlinkSync(tempFilePath);

    /// fire off an async update to the access record with the 
    thisRARDocRef.update(accessRecord)

    return {
        success: 'newResultsZip',
        resultsAccessRecord: thisRARDocRef.id,
        zipDestination: zipDestination
    }
}

/// this function accepts a list of files and an output file path, and populates 
/// the file at that path with a zip archive of the listed files (by downloading 
/// and feeding each file into a write stream).
async function zipFiles(files, outputFilePath, accessRecord) {
    functions.logger.log('made it into `zipFiles`');

    /// setup output stream
    var output = fs.createWriteStream(outputFilePath);

    /// setup archive piped to output path
    var archive = archiver('zip', {
        gzip: true,
        zlib: { level: 6 }
    });
    archive.on('error', function (err) {
        throw err;
    });
    archive.pipe(output);

    /// for each file, download & add to archive
    for (const file of files) {
        console.log(`attempting to append ${file.name}`);
        // https://github.com/googleapis/nodejs-storage/issues/676
        const dLResponse = await remoteStore
            .file(file.name)
            // not checking validation, giving weird errors... revisit?
            // https://github.com/googleapis/google-cloud-node/issues/654#issuecomment-122614144
            .download({ validation: false })
            .catch((err) => {
                let name = '';
                if (file.name != null) name = file.name;
                functions.logger.error(`attempt to download file '${name}' for zipping failed:\n ${err}`);
                return {
                    error: 'downloadFailure',
                    errorText: 'Download of one of the encrypted result files failed',
                }
            });

        // don't have to save file to temp according to this:
        // https://stackoverflow.com/questions/37576685/
        const contents = dLResponse[0]; // contents is the file as Buffer'

        /// post-process the naming scheme from cloud storage
        const oldName = file.name;
        const newNameSplit = oldName.split('/');
        // with 'enc' because we are processing encrypted results
        const newName = [[newNameSplit[0], newNameSplit[1], 'enc'].join('-'), ...newNameSplit.slice(2)].join('/')

        /// actually put the file into the archive
        archive.append(contents, { name: newName });
    }

    /// write metadata to the archive
    let accessRecordString = JSON.stringify(accessRecord)
    archive.append(accessRecordString, { name: 'accessRecord.json' });

    /// zip up
    await archive.finalize();

    // archive._flush() // <--- does that do what I think it might do?
    //                  // i.e. fix the problem below:

    //  yikes:
    //  having to stutter step the download to ensure zip is 
    //  actually finalized for some reason… was getting a zip
    //  w/out the "central directory file header" which should 
    //  be at the end. so that's what zzz(500) does, it waits
    //  500 milliseconds
    await zzz(500);
}

/// This function gathers all of the participant data for a given DrillPlan
async function gatherRelevantFiles(drillID) {
    const [files] = await remoteStore.getFiles({
        prefix: 'DrillResults/' + drillID + '/',
    });
    // console.log('got these files:');
    // for (const file of files) {
    //     // console.log(file);
    //     console.log(file.name);
    // }
    // for (let i = 0; i < files.length; i++) {
    //     if (files[i].name[-1] === '/') 
    // }
    /// if there's only one participant, storage returns all the subdirectories??
    /// so filter for only files (not directories)…
    return files.filter(file => file.name.charAt(file.name.length - 1) !== '/');
}

function zzz(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

exports.resultsDigest = functions
    .runWith({ maxInstances: 18 })
    .https.onCall(resultsDigest);

/// This Cloud Function parses the current status of the results for a given 
/// drillID and returns it to the console on authorized request.

async function resultsDigest(data, context) {
    if (!context.auth) {
        console.error('no auth???')
        return { error: 'Not authorized to access this resource' }
    }

    let options = { prefix: 'DrillResults/' + data.drillID + '/', }
    let [files] = await remoteStore.getFiles(options);

    const resultsDigest = digestResults(files)

    return {
        success: `digested results for ${data.drillID}`,
        resultsDigest: resultsDigest,
    }
}

/// This function is used by the accessResults Cloud Function to perform a similar 
/// operation to the resultsDigest Cloud Function (see above)

function digestResults(files) {
    let resultsDigest = [];
    for (const file of files) {
        const fileNameSplit = file.name.split('/');

        // ['match to', 'create'] the digest based on participantID
        // TODO: when the participants are being logged in the remote_db
        // load the list from there instead to represent those which
        // have confirmed the drill but not yet uploaded results
        const participantID = fileNameSplit[2];
        let thisIndex = resultsDigest.findIndex(
            (digest) => digest.uuid === participantID
        );
        if (thisIndex === -1) {
            resultsDigest.push({ uuid: participantID });
            thisIndex = resultsDigest.length - 1;
        }

        // update the digest for participantID based on file type
        const baseFileName = fileNameSplit[3];
        const fileType = baseFileName.split('.')[1]
        if (fileType === 'json')
            resultsDigest[thisIndex].json = true;
        else if (fileType === 'gpx')
            // TODO: should add some id to the gpx file, maybe taskID of practiceEvac?
            // this would allow multiple gpx files to be included in DrillResults/DrillResultsDigest
            resultsDigest[thisIndex].gpx = true;
    }
    return resultsDigest;
}
