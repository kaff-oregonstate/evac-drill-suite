const admin = require("firebase-admin");
const functions = require("firebase-functions");

// const remote_db = admin.firestore(admin.app('evac-drill-app'));

// const localBucketName = 'evac-drill-console.appspot.com';
// const localStore = admin.storage(admin.app('evac-drill-console')).bucket(localBucketName);

const remoteBucketName = 'evacuation-drill-app-osu.appspot.com'
const remoteStore = admin.storage(admin.app('evac-drill-app')).bucket(remoteBucketName);

exports.numOfParticipantResults = functions
    .runWith({ maxInstances: 18 })
    .https.onCall(numOfParticipantResults);

/// This function counts the number of unique subdirectories for a given
/// drill's DrillResults directory within the Evac Drill App's Cloud Storage
/// to determine the number of participants for the given drill.
///
/// This may not be the final version that this function will take on:
/// Previously we had been having participants that confirmed participation
/// in a given drill to add their uuid as a new Firestore doc to a collection 
/// of `participants` docs which are included underneath the DrillDetails (at
/// that time DrillEvent) document.
///
/// If we return to that method, it would be better to query `remote_db` and
/// count the number of docs in the `participants` collection of the 
/// DrillDetails doc with id `drillID`

async function numOfParticipantResults(data, context) {
    if (!context.auth) {
        console.error('no auth???')
        return { error: 'Not authorized to access this resource' }
    }
    const options = {
        autoPaginate: false,
        prefix: 'DrillResults/' + data.drillID + '/',
        delimiter: `/`,
    }
    let [_, __, apiResponse] = await remoteStore.getFiles(options);
    return { numOfParticipantResults: apiResponse.prefixes?.length ?? 0 };
}
