const path = require('path');
const os = require('os');
const fs = require('fs');
const archiver = require('archiver');

async function getResults(req, res) {
    // grab the drillDocID and authorization header value
    const drillDocID = req.query.docID;
    // const drillDocID = exampleDrillDocID;
    const signature = req.headers['authorization'];

    // functions.logger.log(`qry.docID: ${drillDocID}`);
    // functions.logger.log(`signature: ${signature}`);

    // check signature
    const verified = verifySignature(
        drillDocID,
        signature,
        getResultsPublicKey,
        'getResults',
    );

    if (verified) {
        // get the resulting files and directories
        const filesResponse = await gatherRelevantFiles(drillDocID)
        var files = [];
        const [filesAndDirectories] = filesResponse;

        // filter directories out of results, resulting in only files
        filesAndDirectories.forEach(file => {
            if (!(file.name.slice(-1) == '/')) {
                files.push(file);
            }
        });

        // error check for non existent DrillEvent document, or no results
        if (files.length == 0) {
            // no files to download, maybe requested before drill ran?
            functions.logger.error(`attempted to download results, but nothing here: ${files}`);
            res.json({ result: `nothing here! please contact admin.` });
        } else {
            // define the location of the output stream
            const outputFileName = `results-${drillDocID}.zip`;
            const tempFilePath = path.join(os.tmpdir(), outputFileName);

            // make sure a previously uncleaned export gets cleant
            if (fs.existsSync(tempFilePath)) fs.unlinkSync(tempFilePath);
            // functions.logger.log(tempFilePath);

            // zip the files up 
            zipFiles(files, tempFilePath).then(() => {
                // respond to the request with a download of the zip
                //
                //  having to stutter step the download to ensure zip is 
                //  actually finalized for some reason… was getting a zip
                //  w/out the "central directory file header" which should 
                //  be at the end. so that's what zzz(500) does, it waits
                //  500 milliseconds
                zzz(500).then(() => res.download(tempFilePath), (err) => {
                    if (err) functions.logger.err(err);
                    fs.unlinkSync(tempFilePath);
                });
            });
        }

    } else {
        // unauthorized download attempt
        functions.logger.warn('unauthorized attempt to download results.');
        res.json({ result: `sorry pal, nothing there. contact admin.` });
    }
}


// this function accepts a list of files and an output file path, and populates 
// the file at that path with a zip archive of the listed files.
async function zipFiles(files, outputFilePath) {
    // functions.logger.log('made it into zip');
    const storage = new Storage();

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

    // for each files, download, add to archive
    // https://github.com/googleapis/nodejs-storage/issues/676
    for (let i = 0; i < files.length; i++) {
        const file = files[i];
        // functions.logger.log(`attempting to append ${file.name}`);
        await storage.bucket(bucketName)
            .file(file.name)
            // not checking validation, giving weird errors...
            // revisit?
            // https://github.com/googleapis/google-cloud-node/issues/654#issuecomment-122614144
            .download({ validation: false })
            .then((data) => {
                // don't have to save file to temp according to this:
                // https://stackoverflow.com/questions/37576685/
                const contents = data[0]; // contents is the file as Buffer
                archive.append(contents, { name: file.name });
            })
            .catch((err) => {
                var name = '';
                if (file.name != null) name = file.name;
                functions.logger.error(`attempt to download file '${name}' for zipping failed:\n ${err}`);
            });
    }

    // finalize archive
    await archive.finalize();
}


// This function gathers all of the participant data for a given drill event
//  sources linked at bottom of function.
function gatherRelevantFiles(drillEventDocID) {
    const storage = new Storage();
    return storage.bucket(bucketName).getFiles({ prefix: 'DrillResults/' + drillEventDocID + '/' });

    // question regarding how to use Storage API
    // https://stackoverflow.com/questions/54736744/

    // reference functions for Storage API
    // https://cloud.google.com/nodejs/docs/reference/storage/latest

    // specific example for listing files under prefix, not referenced in
    //  creation but what I ended up doing as an experiment when it finally 
    //  listed files instead of '[ [] ]'
    // https://github.com/googleapis/nodejs-storage/blob/main/samples/listFilesByPrefix.js
}


// This function accepts a [drillDocID] as a string and a [signature] as a 
//  string representation in base64 (which is how the dart signing utility 
//  outputs signatures), along with the relevant public key in string format.
// It will return true only if the drillDocID was signed by the researchers.
// Need to re-roll the keys involved at some point…
// 
// This is vulnerable to repeat message attacks, so if someone is sniffing
//  researcher traffic they will also be able to repeat any actions taken.
//  However, any results which they will download will still be encrypted.
//  And, we can design 'start signal' to only accept one query.
// 
// Need to determine how to validate DrillEvent pulldown to researcher console…
function verifySignature(drillDocID, signature, publicKey, reqtype) {
    const isVerified = crypto.verify(
        "sha256",
        Buffer.from(drillDocID),
        {
            key: publicKey,
            padding: crypto.constants.RSA_PKCS1_PADDING,
        },
        Buffer.from(signature, 'base64')
    );

    functions.logger.log(`${reqtype} signature verified: `, isVerified);

    return isVerified;
}

function testCrypt(drillDocID, signature) {
    // https://www.sohamkamani.com/nodejs/rsa-encryption/

    // // The signature method takes the data we want to sign, the
    // // hashing algorithm, and the padding scheme, and generates
    // // a signature in the form of bytes
    // //
    // // changed RSA_PKCS1_PSS_PADDING to RSA_PKCS1_PADDING to match
    // // signature generated in dart lang
    //
    // const signature = crypto.sign("sha256", Buffer.from(verifiableData), {
    //     key: privateKey,
    //     padding: crypto.constants.RSA_PKCS1_PADDING,
    // });

    // functions.logger.log(signature.toString("base64"));

    // To verify the data, we provide the same hashing algorithm and
    // padding scheme we provided to generate the signature, along
    // with the signature itself, the data that we want to
    // verify against the signature, and the public key
    const isVerified = crypto.verify(
        "sha256",
        Buffer.from(drillDocID),
        {
            key: getResultsPublicKey,
            padding: crypto.constants.RSA_PKCS1_PADDING,
        },
        Buffer.from(signature, 'base64')
    );

    // isVerified should be `true` if the signature is valid
    // functions.logger.log("$reqtype signature verified: ", isVerified);

    return isVerified;
}

function zzz(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}
