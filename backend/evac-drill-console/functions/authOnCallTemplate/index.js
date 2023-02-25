const functions = require("firebase-functions");

exports.authOnCallTemplate = functions
    .runWith({ maxInstances: 18 })
    .https.onCall(authOnCallTemplate);

function authOnCallTemplate(data, context) {
    if (!context.auth) {
        console.error('no auth???')
        return { text: 'nooooo ' }
    }
    console.log(context.auth)
    return { text: 'broooo ' }
}
