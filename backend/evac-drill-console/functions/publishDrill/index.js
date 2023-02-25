const admin = require("firebase-admin");
const { Timestamp } = require('firebase-admin/firestore');
const functions = require("firebase-functions");

const local_db = admin.firestore(admin.app('evac-drill-console'));
const remote_db = admin.firestore(admin.app('evac-drill-app'));

const drillPlanCollection = local_db.collection('DrillPlan');
const drillDetailsCollection = remote_db.collection('DrillDetails');

exports.publishDrill = functions
    .runWith({ maxInstances: 18 })
    .https.onCall(publishDrill);

/// Publishes a DrillPlan from Console's Firestore to a new DrillDetails in the
/// App's Firestore, making it accessible to drill participants with valid
/// invite code (which is also returned from this function to the Console).

async function publishDrill(data, context) {
    if (!context.auth) {
        console.error('no auth???');
        return {
            error: 'noAuth',
            errorText: 'Not authorized to access this resource',
        };
    }

    const drillDetailsDocRef = drillDetailsCollection.doc(data.drillID);

    // verify no DrillDetails with `data.drillID`
    const drillDetailsAlreadyExists = (await drillDetailsDocRef.get()).exists;
    if (drillDetailsAlreadyExists) {
        return {
            error: 'drillDetailsAlreadyExists',
            errorText: `DrillDetails with id: ${data.drillID} already exists`,
        };
    }

    const drillPlanDocRef = drillPlanCollection.doc(data.drillID);

    const drillPlan = await drillPlanDocRef.get();

    if (!drillPlan.exists) {
        return {
            error: 'nonExistantDrillPlan',
            errorText: `No DrillPlan with id: ${data.drillID} exists!`,
        };
    }

    // console.log(drillPlan.data());

    if (drillPlan.data().creatorID != context.auth.uid) {
        return {
            error: 'wrongUser',
            errorText: `DrillPlan with id: ${data.drillID} does not belong to current user!`,
        };
    }

    /// not currently filtering any data out here, may want to in future…
    let drillDetailsData = drillPlan.data();
    drillDetailsData.published = true;
    drillDetailsData.publishDateTime = Timestamp.now();
    drillDetailsData.depublishDateTime = null;

    if (!drillDetailsData.inviteCode) {
        let inviteCode = genInviteCode();
        const inviteCodeQuery = (inviteCode) => drillDetailsCollection.where('inviteCode', '==', inviteCode);
        let querySnapshot = await inviteCodeQuery(inviteCode).get();
        // check invite code until unique
        while (querySnapshot.size >= 1) {
            console.log(`found duplicate invite code!!: ${inviteCode}`);
            inviteCode = genInviteCode();
            querySnapshot = await inviteCodeQuery(inviteCode).get();
        }
        console.log(`generated unique invite code: ${inviteCode}`);
        drillDetailsData.inviteCode = inviteCode;
    }
    // console.log(drillDetailsData['tasks'])

    // parse EvacActions into WaitForStart task evac task instructions
    // legacy compatability
    for (let i = 0; i < drillDetailsData['tasks'].length; i++) {
        let task = drillDetailsData['tasks'][i];
        if (task['taskType'] == 'upload') { 
            drillDetailsData['tasks'].splice(i, 1);
            continue;
        }
        if (task['taskType'] == 'practiceEvac') {
            drillDetailsData['tasks'].splice(i, 0, {
                taskType: 'waitForStart',
                title: 'Wait For Start',
                taskID: 'aVeryUniqueWaitStartTaskID',
                details: {
                    taskID: 'aVeryUniqueWaitStartTaskID',
                    practiceEvacTaskID: task['taskID'],
                    typeOfWait: 'self',
                    content: null
                }
            });
            i++;
            drillDetailsData['tasks'][i]['details'].instructionsJson = {
                instructions: []
            }
            let actions = drillDetailsData['tasks'][i]['details'].actions;
            for (let j=1; j < actions.length; j++) {
                if (actions[j].actionType == 'instruction') {
                    // console.log(actions[j].text);
                    drillDetailsData['tasks'][i]['details'].instructionsJson.instructions.push(actions[j].text)
                }
            }
        }
        // console.log(drillDetailsData['tasks'][i]);
    }

    // console.log(drillDetailsData['tasks']);
    


    await drillDetailsDocRef.create(drillDetailsData);

    console.log(`Published DrillPlan with id: ${data.drillID}`);

    await drillPlanDocRef.update({
        published: true,
        publishDateTime: drillDetailsData.publishDateTime,
        depublishDateTime: null,
        inviteCode: drillDetailsData.inviteCode,
    });

    return {
        success: `Published DrillPlan with id: ${data.drillID}`,
        inviteCode: drillDetailsData.inviteCode,
    };
}

function genInviteCode() {
    let inviteCode = genRandomSixDigitString();
    // no naughty numbers please
    while (inviteCode.includes('666') || inviteCode.includes('69') || inviteCode.includes('420')) {
        console.log(`found naughty invite code!!: ${inviteCode}`);
        inviteCode = genRandomSixDigitString();
    }
    return inviteCode;
}

// https://stackoverflow.com/a/21816636/14962174
const genRandomSixDigitString = () =>
    Math.floor(100000 + Math.random() * 900000).toString();
