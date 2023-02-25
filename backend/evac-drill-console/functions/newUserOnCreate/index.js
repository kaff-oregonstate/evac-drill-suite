const admin = require("firebase-admin");
const functions = require("firebase-functions");

const db = admin.firestore(admin.app('evac-drill-console'));

exports.newUserOnCreate = functions
    .runWith({
        // limit instances that can be spun up
        maxInstances: 18,
    })
    .auth.user().onCreate(newUserOnCreate);

async function newUserOnCreate(user) {
    db.collection('User').add({ 
        'userID': user.uid,
        'email': user.email
    })
}