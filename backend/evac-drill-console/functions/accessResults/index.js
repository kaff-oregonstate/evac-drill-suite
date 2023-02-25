const path = require('path');
const os = require('os');
const fs = require('fs');
const archiver = require('archiver');
const admin = require("firebase-admin");
const { Timestamp } = require('firebase-admin/firestore');
const functions = require("firebase-functions");

const localDB = admin.firestore(admin.app('evac-drill-console'));
const rARCollection = localDB.collection('ResultsAccessRecord');

const localBucketName = 'evac-drill-console.appspot.com';
const localStore = admin.storage(admin.app('evac-drill-console')).bucket(localBucketName);

const remoteBucketName = 'evacuation-drill-app-osu.appspot.com'
const remoteStore = admin.storage(admin.app('evac-drill-app')).bucket(remoteBucketName);

exports.accessResults = functions
    .runWith({ maxInstances: 18 })
    .https.onCall(accessResults);

async function accessResults(data, context) {
    if (!context.auth) {
        console.error('no auth???')
        return {
            error: 'noAuth',
            errorText: 'nooooo',
        }
    }

    /// not currently protected by DrillPlan.creatorID, but could in the future
    /// if so, add `authorized` field to ResultsAccessRecord

    /// if we end up writing the compiled zip to localStorage we should
    /// check here if that zip is still valid somehow? maybe based on:

    /// need to create ResultsAccessRecord
    const nowTime = Timestamp.now();
    const thisRARDocRef = await rARCollection.add({
        debug: true,
        uid: context.auth.uid,
        drillID: data.drillID,
        accessed: nowTime,
    })
    
    const files = await gatherRelevantFiles(data.drillID);
    
    // digest the results, then fire off an sync update to the access record
    thisRARDocRef.update({ resultsDigest: digestResults(files) })

    if (files.length === 0) {
        console.error(`no results? for drillID: ${data.drillID}`)
        return {
            error: 'noResults',
            errorText: 'no results for this drillID',
            resultsAccessRecord: thisRARDocRef.id,
        }
    }

    // define the location of the output stream
    const outputFileName = `results-${data.drillID}.zip`;
    const tempFilePath = path.join(os.tmpdir(), outputFileName);

    // make sure a previously uncleaned export gets cleant
    if (fs.existsSync(tempFilePath)) fs.unlinkSync(tempFilePath);
    // functions.logger.log(tempFilePath);

    // zip the files up 
    await zipFiles(files, tempFilePath)

    /// either need to figure out how to respond to `onCall` with download
    /// or validate an `onRequest` using auth
    /// *or write the zip to localStorage and return dl link to that file*

    const zipDestination = `DrillResultZips/${thisRARDocRef.id}/${data.drillID}-${nowTime.toDate().toISOString()}.zip`;
    await localStore.upload(tempFilePath, {destination: zipDestination});

    console.log(tempFilePath);

    // // clean up after ourselves in tmp
    fs.unlinkSync(tempFilePath);

    return {
        success: 'yoooo',
        resultsAccessRecord: thisRARDocRef.id,
        zipDestination: zipDestination
    }
}

/// this function accepts a list of files and an output file path, and populates 
/// the file at that path with a zip archive of the listed files.
async function zipFiles(files, outputFilePath) {
    functions.logger.log('made it into `zipFiles`');

    // setup output stream
    var output = fs.createWriteStream(outputFilePath);

    // setup archive
    var archive = archiver('zip', {
        gzip: true,
        zlib: { level: 6 }
    });
    archive.on('error', function (err) {
        throw err;
    });
    archive.pipe(output);

    // for each file, download & add to archive
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

        const oldName = file.name;
        const newNameSplit = oldName.split('/');
        const newName = [[newNameSplit[0], newNameSplit[1]].join('-'), ...newNameSplit.slice(2)].join('/')

        archive.append(contents, { name: newName });
    }

    await archive.finalize();
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
    return files.filter(file => file.name.charAt(file.name.length -1) !== '/');
}

function zzz(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

exports.resultsDigest = functions
    .runWith({ maxInstances: 18 })
    .https.onCall(resultsDigest);

/// This function parses the current status of the results for a given drillID and 
/// returns it to the console on authorized request.

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
