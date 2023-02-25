// const functions = require("firebase-functions");
// const admin = require("firebase-admin");


// exports.getUserEmail = functions
//     .runWith({ maxInstances: 18 })
//     .https.onCall(getUserEmail);

// async function getUserEmail(data, context) {
//     if (!context.auth) {
//         console.error('no auth???')
//         return { text: 'nooooo ' }
//     }
//     if (data.currentEditorID) {
//         const userRecord = await admin.app('evac-drill-console').auth().getUser(data.currentEditorID);
//         if (userRecord) {
//             return { email: userRecord.email }
//         } else {
//             return { error: 'no user with that ID' }
//         }

//     } else {
//         return { error: 'no currentEditorID provided' }
//     }
//     console.log(context.auth)
//     return { text: 'broooo ' }
// }
