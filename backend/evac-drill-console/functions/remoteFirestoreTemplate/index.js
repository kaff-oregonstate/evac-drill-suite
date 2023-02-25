// const admin = require("firebase-admin");
// const functions = require("firebase-functions");

// const local_db = admin.firestore(admin.app('evac-drill-console'));
// const remote_db = admin.firestore(admin.app('evac-drill-app'));

// exports.remoteFirestoreTemplate = functions
//     .runWith({
//         // limit instances that can be spun up
//         maxInstances: 18,
//         // TODO: which service account will we use?
//         // serviceAccount: 'evac-firestores-user@evac-drill-console.iam.gserviceaccount.com',
//         serviceAccount: 'evac-drill-console@appspot.gserviceaccount.com',
//     })
//     // .https.onCall((data, context) => {
//     .https.onRequest(async (req, res) => {
//         await local_db.collection('TestCollection').add({'testField': 42})
//         await remote_db.collection('TestCollection').add({'testField': 42})

//         res.send('added documents to both Firestore\'s `TestCollection`s')
//     });
