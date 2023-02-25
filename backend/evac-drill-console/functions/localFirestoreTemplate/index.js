const admin = require("firebase-admin");
const functions = require("firebase-functions");

const db = admin.firestore(admin.app('evac-drill-console'));

exports.localFirestoreTemplate = functions
    .runWith({
        // limit instances that can be spun up
        maxInstances: 18,
    })
    .https.onCall((data, context) => {
        db.collection('TestCollection').add({'testField': 42})
    });
exports.localFirestoreTemplate2 = functions
    .runWith({
        // limit instances that can be spun up
        maxInstances: 18,
    })
    .https.onRequest((req, res) => {
        db.collection('TestCollection').add({'testField': 42})
        res.send({success: 'added doc to collection'})
    });
