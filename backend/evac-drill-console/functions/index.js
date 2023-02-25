// https://stackoverflow.com/a/52743902
const admin = require("firebase-admin");
admin.initializeApp({projectId: `evac-drill-console`}, 'evac-drill-console');
admin.initializeApp({projectId: `evacuation-drill-app-osu`}, 'evac-drill-app');

const localFirestoreTemplate = require('./localFirestoreTemplate/index')
// const remoteFirestoreTemplate = require('./remoteFirestoreTemplate/index')
const authOnCallTemplate = require('./authOnCallTemplate/index')
const numOfParticipants = require('./numOfParticipants/index')
const publishDrill = require('./publishDrill/index')
const depublishDrill = require('./depublishDrill/index')
// const accessResults = require('./accessResults/index')
const accessResults = require('./accessResults/accessEncryptedResults')
// const getUserEmail = require('./getUserEmail/index')
const newUserOnCreate = require('./newUserOnCreate/index')

// exports.localFirestoreTemplate = localFirestoreTemplate.localFirestoreTemplate
exports.localFirestoreTemplate2 = localFirestoreTemplate.localFirestoreTemplate2
// exports.remoteFirestoreTemplate = remoteFirestoreTemplate.remoteFirestoreTemplate
exports.authOnCallTemplate = authOnCallTemplate.authOnCallTemplate
exports.numOfParticipantResults = numOfParticipants.numOfParticipantResults
exports.publishDrill = publishDrill.publishDrill
exports.depublishDrill = depublishDrill.depublishDrill
exports.resultsDigest = accessResults.resultsDigest
// exports.accessResults = accessResults.accessResults
exports.accessResults = accessResults.accessEncryptedResults
exports.newUserOnCreate = newUserOnCreate.newUserOnCreate
// exports.getUserEmail = getUserEmail.getUserEmail
