const admin = require("firebase-admin");
const { Timestamp } = require('firebase-admin/firestore');
const functions = require("firebase-functions");

const local_db = admin.firestore(admin.app('evac-drill-console'));
const remote_db = admin.firestore(admin.app('evac-drill-app'));

const drillPlanCollection = local_db.collection('DrillPlan');
const drillDetailsCollection = remote_db.collection('DrillDetails');

/// "De"-Publishes (look it up) a DrillDetails object from the App's Firestore, 
/// revoking it from drill participants. The matching DrillPlan survives if it 
/// still exists, and as a safety measure is rewritten if not found.

exports.depublishDrill = functions
    .runWith({ maxInstances: 18 })
    .https.onCall(depublishDrill);

async function depublishDrill(data, context) {
    if (!context.auth) {
        console.error('no auth???');
        return {
            error: 'noAuth',
            errorText: 'Not authorized to access this resource',
        };
    }

    const drillDetailsDocRef = drillDetailsCollection.doc(data.drillID);
    const drillDetails = await drillDetailsDocRef.get();

    if (!drillDetails.exists) {
        return {
            error: 'nonExistantDrillDetails',
            errorText: `No DrillDetails with id: ${data.drillID} exists`,
        };
    }
    if (drillDetails.data().creatorID != context.auth.uid) {
        return {
            error: 'wrongUserDrillDetails',
            errorText: `DrillDetails with id: ${data.drillID} does not belong to current user!`,
        };
    }

    const drillPlanDocRef = drillPlanCollection.doc(data.drillID);
    const drillPlan = await drillPlanDocRef.get();

    if (!drillPlan.exists) {
        /// shouldn't ever get here as the Console will be 
        /// referencing the DrillPlan document. But just in case:

        // recreate the DrillPlanbased on DrillDetails
        drillPlanDocRef.create(drillDetails.data());
    } else if (drillPlan.data().creatorID != context.auth.uid) {
        /// shouldn't ever get here either, for the same reason
        /// and because we check the DrillDetails document's creatorID
        /// first, which should always match. But just in case:

        // correct the discrepency
        await drillDetailsDocRef.update({
            creatorID: drillPlan.data().creatorID,
        })
        // return error (the current user cannot do anything to this plan)
        return {
            error: 'wrongUserDrillPlan',
            errorText: `DrillPlan with id: ${data.drillID} does not belong to current user! Corrected DrillDetails creatorID.`,
        };
    }

    await drillDetailsDocRef.delete();

    console.log(`Depublished DrillDetails with id: ${data.drillID}`);

    await drillPlanDocRef.update({
        published: false,
        publishDateTime: null,
        depublishDateTime: Timestamp.now(),
    });

    return {
        success: `Depublished DrillDetails with id: ${data.drillID}`,
    };
}
