// import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
// import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_widgets.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_util.dart';
import 'package:evac_drill_console/models/drill_plan.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

const emulating = false;

class HoverTestingMenu extends StatelessWidget {
  const HoverTestingMenu({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (FFAppState().debug) const TestingMenu(),
      ],
    );
  }
}

class TestingMenu extends StatefulWidget {
  const TestingMenu({Key? key}) : super(key: key);

  @override
  State<TestingMenu> createState() => _TestingMenuState();
}

class _TestingMenuState extends State<TestingMenu> {
  List<String> testingOutputs = [];
  TextEditingController drillPlanJsonController = TextEditingController();
  String jsonError = '';
  bool jsonIsLoading = false;

  @override
  void initState() {
    testingOutputs.add('Beginning test output at ${timestamp()}…');
    super.initState();
  }

  void setJSONIsLoading() {
    setState(() {
      jsonIsLoading = !jsonIsLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    void goToEditDrillPlanJsonRoute(String drillID) {
      // context.pushNamed('editDrillPlanJson/$drillID');
      context.pushNamed('editDrillPlanJson', params: {'drillID': drillID});
    }

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: FFTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: FFTheme.of(context).tertiaryColor,
              width: 2,
            ),
          ),
          // constraints: const BoxConstraints(maxHeight: 650),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 280,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: FFTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: FFTheme.of(context).tertiaryColor,
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              testingOutputs = [
                                'Test outputs reset at ${timestamp()}…'
                              ];
                            });
                          },
                          icon: const Icon(Icons.refresh_rounded))
                    ]),
                    SizedBox(
                      height: 360,
                      child: SelectionArea(
                        child: ListView.builder(
                          reverse: true,
                          itemCount: testingOutputs.length,
                          itemBuilder: (context, i) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              testingOutputs[i],
                              style: FFTheme.of(context).bodyText2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Testing Menu',
                    style: FFTheme.of(context).title1,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$width x $height',
                    style: FFTheme.of(context).title3.override(
                          fontFamily: 'Outfit',
                          color: FFTheme.of(context).secondaryText,
                        ),
                  ),
                  const SizedBox(height: 8),
                  // TestButton(
                  //     'showASnackbar',
                  //     () => ScaffoldMessenger.of(context).showSnackBar(
                  //         const SnackBar(content: Text('did a thing')))),
                  // const SizedBox(height: 8),
                  // TestButton('showADialog', () => showADialog()),
                  // const SizedBox(height: 8),
                  TestButton('emitATestOutput', () => emitATestOutput()),
                  const SizedBox(height: 8),
                  // TestButton(
                  //     'unprotectedHttpsOnReq', () => unprotectedHttpsOnReq()),
                  // const SizedBox(height: 8),
                  TestButton(
                    'authOnCallTemplate',
                    () => authOnCallTemplate(),
                  ),
                  const SizedBox(height: 8),
                  // TestButton(
                  //   'getDrillPlanAndShow',
                  //   () => getDrillPlanAndShow(),
                  // ),
                  // const SizedBox(height: 8),
                  // TestButton(
                  //   'changeDrillPlanSnapshot',
                  //   () => changeDrillPlanSnapshot(),
                  // ),
                  // const SizedBox(height: 8),
                  // TestButton(
                  //   'reuploadedDrillStillEqual',
                  //   () => reuploadedDrillStillEqual(),
                  // ),
                  // const SizedBox(height: 8),
                  TestButton(
                    'numOfParticipantResults',
                    () => numOfParticipantResults(),
                  ),
                  const SizedBox(height: 8),
                  TestButton(
                    'resultsDigest',
                    () => resultsDigest(),
                  ),
                  const SizedBox(height: 8),
                  TestButton(
                    'accessResults',
                    () => accessResults(),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 8),
                  TestButton(
                    'downloadResults',
                    () => downloadResults(),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 8),
                  TestButton(
                    'setPublicKeyFromClipboard',
                    () => setPublicKeyFromClipboard(),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 8),
                  TestButton(
                    'duplicateDrillPlan',
                    () => duplicateDrillPlan(),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 8),
                  TestButton(
                    'getDrillPlanJSON',
                    () => copyDrillPlanJSONtoClip(),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 8),
                  TestButton(
                    'drillPlanJSONTextBox',
                    () => drillPlanJSONTextBox(context),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 8),
                  TestButton(
                    'goToEditDrillPlanJsonPage',
                    () => goToEditDrillPlanJsonPage(goToEditDrillPlanJsonRoute),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 8),
                  TestButton(
                    'publishDrill',
                    () => publishDrill(),
                  ),
                  const SizedBox(height: 8),
                  TestButton(
                    'depublishDrill',
                    () => depublishDrill(),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 8),
                  TestButton(
                    'rawDuplicateFirestoreDoc',
                    () => rawDuplicateFirestoreDoc(),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addTestOutput(String output) {
    setState(() {
      testingOutputs.insert(0, output);
    });
  }

  String timestamp() {
    final now = DateTime.now();
    final hour = now.hour;
    final min = now.minute;
    final sec = now.second;
    return '${(hour / 10 >= 1) ? hour.toString() : '0${hour.toString()}'}:${(min / 10 >= 1) ? min.toString() : '0${min.toString()}'};${(sec / 10 >= 1) ? sec.toString() : '0${sec.toString()}'}';
  }

  Future<void> emitATestOutput() async {
    await Future.delayed(const Duration(milliseconds: 40));
    addTestOutput('this is a new test output');
  }

  Future<void> authOnCallTemplate() async {
    addTestOutput('authOnCallTemplate() @ ${timestamp()}');
    try {
      final functionsInstance = FirebaseFunctions.instance;

      final debug = FFAppState().debug && emulating;
      const host = '127.0.0.1';
      const port = 5001;
      if (debug) {
        functionsInstance.useFunctionsEmulator(host, port);
      }

      final result =
          await functionsInstance.httpsCallable('authOnCallTemplate').call();

      addTestOutput(result.data.toString());
      addTestOutput(result.data['text']);
    } on FirebaseFunctionsException catch (error) {
      addTestOutput('Error occurred at ${timestamp()}…');
      addTestOutput('Error: ${error.code}');
      addTestOutput('Error: ${error.details}');
      addTestOutput('Error: ${error.message ?? 'no message'}');
    } catch (e) {
      addTestOutput('Error: ${e.toString()}');
      // addTestOutput('Error: ${e.toString()}');
    }
  }

  void numOfParticipantResults() async {
    addTestOutput('numOfParticipantResults() @ ${timestamp()}');
    try {
      final functionsInstance = FirebaseFunctions.instance;

      final debug = FFAppState().debug && emulating;
      const host = '127.0.0.1';
      const port = 5001;
      if (debug) {
        functionsInstance.useFunctionsEmulator(host, port);
      }

      final result = await functionsInstance
          .httpsCallable('numOfParticipantResults')
          .call({'drillID': 'spSzoPVnBksQ3hm8XnOH'});

      addTestOutput(result.data?.toString() ?? 'no data');
      addTestOutput(
          result.data?['numOfParticipantResults'].toString() ?? 'no data');
    } on FirebaseFunctionsException catch (error) {
      addTestOutput('Error occurred at ${timestamp()}…');
      addTestOutput('Error: ${error.code}');
      addTestOutput('Error: ${error.details ?? 'no details'}');
      addTestOutput('Error: ${error.message ?? 'no message'}');
    }
  }

  void publishDrill() async {
    // const drillID = '4VJVpHgx958TzuAy0nwm';
    // const drillID = 'UCb3gmtkxSlzlCzPowMr';
    const drillID = 'i7RTd7u7vIh8nIdkcCM2';
    addTestOutput('publishDrill() @ ${timestamp()}');
    try {
      final functionsInstance = FirebaseFunctions.instance;

      final debug = FFAppState().debug && emulating;
      if (debug) {
        const host = '127.0.0.1';
        const port = 5001;
        functionsInstance.useFunctionsEmulator(host, port);
      }

      final result = await functionsInstance
          .httpsCallable('publishDrill')
          .call({'drillID': drillID});

      if (result.data['error'] != null) {
        addTestOutput('Error:');
        addTestOutput(result.data?['errorText'] ?? 'no data');
      } else {
        addTestOutput(result.data?['success'] ?? 'no data');
        addTestOutput(result.data?['inviteCode'] ?? 'no data');
      }
    } on FirebaseFunctionsException catch (error) {
      addTestOutput('Error occurred at ${timestamp()}…');
      addTestOutput('Error: ${error.code}');
      addTestOutput('Error: ${error.details ?? 'no details'}');
      addTestOutput('Error: ${error.message ?? 'no message'}');
    }
  }

  void depublishDrill() async {
    // const drillID = '4VJVpHgx958TzuAy0nwm';
    const drillID = 'UCb3gmtkxSlzlCzPowMr';
    addTestOutput('depublishDrill() @ ${timestamp()}');
    try {
      final functionsInstance = FirebaseFunctions.instance;

      final debug = FFAppState().debug && emulating;
      if (debug) {
        const host = '127.0.0.1';
        const port = 5001;
        functionsInstance.useFunctionsEmulator(host, port);
      }

      final result = await functionsInstance
          .httpsCallable('depublishDrill')
          .call({'drillID': drillID});

      if (result.data['error'] != null) {
        addTestOutput('Error:');
        addTestOutput(result.data?['errorText'] ?? 'no data');
      } else {
        addTestOutput(result.data?.toString() ?? 'no data');
        addTestOutput(result.data?['success'] ?? 'no data');
        // addTestOutput(result.data?['inviteCode'] ?? 'no data');
      }
    } on FirebaseFunctionsException catch (error) {
      addTestOutput('Error occurred at ${timestamp()}…');
      addTestOutput('Error: ${error.code}');
      addTestOutput('Error: ${error.details ?? 'no details'}');
      addTestOutput('Error: ${error.message ?? 'no message'}');
    }
  }

  void resultsDigest() async {
    addTestOutput('resultsDigest() @ ${timestamp()}');
    try {
      final functionsInstance = FirebaseFunctions.instance;

      final debug = FFAppState().debug && emulating;
      if (debug) {
        const host = '127.0.0.1';
        const port = 5001;
        functionsInstance.useFunctionsEmulator(host, port);
      }

      final result = await functionsInstance
          .httpsCallable('resultsDigest')
          .call({'drillID': 'spSzoPVnBksQ3hm8XnOH'});

      if (result.data['error'] != null) {
        addTestOutput('Error:');
        addTestOutput(result.data?['error'] ?? 'no data');
        addTestOutput(result.data?['errorText'] ?? 'no data');
      } else {
        addTestOutput(result.data?.toString() ?? 'no data');
        addTestOutput(result.data?['success'] ?? 'no data');
        addTestOutput(result.data?['resultsDigest'].toString() ?? 'no data');
      }
    } on FirebaseFunctionsException catch (error) {
      addTestOutput('Error occurred at ${timestamp()}…');
      addTestOutput('Error: ${error.code}');
      addTestOutput('Error: ${error.details ?? 'no details'}');
      addTestOutput('Error: ${error.message ?? 'no message'}');
    }
  }

  void accessResults() async {
    addTestOutput('accessResults() @ ${timestamp()}');
    try {
      final functionsInstance = FirebaseFunctions.instance;
      // const drillID = 'spSzoPVnBksQ3hm8XnOH';
      // const drillID = 'spSzoPVnBksQ3hm8XnO2';
      const drillID = '9KBGSyiZV3TUjUXOFkhr';

      final debug = FFAppState().debug && emulating;
      if (debug) {
        const host = '127.0.0.1';
        const port = 5001;
        functionsInstance.useFunctionsEmulator(host, port);
      }

      final result =
          await functionsInstance.httpsCallable('accessResults').call({
        'drillID': drillID,
        'enforeDuplicateResultsZip': true,
      });

      // print(result.toString());

      if (result.data['error'] != null) {
        addTestOutput('Error:');
        addTestOutput(result.data?['error'] ?? 'no data');
        addTestOutput(result.data?['errorText'] ?? 'no data');
      } else {
        addTestOutput(result.data?.toString() ?? 'no data');
        addTestOutput(result.data?['success'] ?? 'no data');
      }
    } on FirebaseFunctionsException catch (error) {
      addTestOutput('Error occurred at ${timestamp()}…');
      addTestOutput('Error: ${error.code}');
      addTestOutput('Error: ${error.details ?? 'no details'}');
      addTestOutput('Error: ${error.message ?? 'no message'}');
    }
  }

  /// No longer decrypting, as this will be done locally
  void downloadResults() async {
    addTestOutput('downloadResults() @ ${timestamp()}');
    const drillID = '9KBGSyiZV3TUjUXOFkhr';
    const zipDestination =
        'DrillResultZips/VJPRgZgzEAlAXA4nwGo0/9KBGSyiZV3TUjUXOFkhr-2023-02-14T21:27:12.816Z.zip';
    final storageRef = FirebaseStorage.instance.ref();
    final zipRef = storageRef.child(zipDestination);

    final zipURL = await zipRef.getDownloadURL();
    html.AnchorElement(href: zipURL)
      ..setAttribute('download', 'DrillResults-$drillID.zip')
      ..click();
    addTestOutput('download prompted?');
  }

  void setPublicKeyFromClipboard() async {
    final pubKey = (await Clipboard.getData('text/plain'))?.text;
    addTestOutput('got clipboard: $pubKey');

    if (pubKey != null) {
      if (!pubKey.startsWith('-----')) {
        throw const FormatException(
            'Invalid PEM key format on Public Key paste from clipboard');
      }
      if (pubKey.startsWith('-----BEGIN PRIVATE KEY-----')) {
        throw const FormatException(
            'Attempting to input Private Key when Public Key required');
      }
      if (!pubKey.startsWith('-----BEGIN PUBLIC KEY-----')) {
        throw const FormatException('Invlaid PEM Public Key format');
      }
      addTestOutput('made it past pubkey formatting checks');
      DrillPlan? drillPlan =
          // await DrillPlan.fromDrillID('spSzoPVnBksQ3hm8XnO2');
          // await DrillPlan.fromDrillID('4VJVpHgx958TzuAy0nwm');
          await DrillPlan.fromDrillID('9KBGSyiZV3TUjUXOFkhr');

      if (drillPlan != null) {
        drillPlan.publicKey = pubKey;
        await drillPlan.updateDoc();
        addTestOutput('updated doc: ${drillPlan.drillID}');
        DrillPlan? drillPlan2 = await DrillPlan.fromDrillID(drillPlan.drillID);
        addTestOutput('newly gotten drillPlan.publicKey:');
        addTestOutput(drillPlan2!.publicKey ?? 'no public key');
      }
    }
  }

  void duplicateDrillPlan() async {
    addTestOutput('duplicateDrillPlan() @ ${timestamp()}');
    const oldDrillID = '4VJVpHgx958TzuAy0nwm';
    DrillPlan? drillPlan = await DrillPlan.fromDrillID(oldDrillID);
    if (drillPlan != null) {
      final auth = FirebaseAuth.instanceFor(
        app: Firebase.app(),
        persistence: Persistence.INDEXED_DB,
      );
      String? newDocID = await drillPlan.duplicate(
          auth.currentUser!.uid, auth.currentUser!.email!);
      addTestOutput('Duplicated drill, new drill ID: $newDocID');
    } else {
      addTestOutput('could not get drill with ID $oldDrillID');
    }
  }

  Future<String?> getDrillPlanJSON(String drillID) async {
    // should we be giving them the full json contents?
    // or: abbreviate the metadata?
    addTestOutput('getDrillPlanJSON() @ ${timestamp()}');
    // const drillID = '4VJVpHgx958TzuAy0nwm';
    DrillPlan? drillPlan = await DrillPlan.fromDrillID(drillID);
    if (drillPlan != null) {
      final text = drillPlan.copyJson();
      return text;
    } else {
      addTestOutput('could not get drill with ID $drillID');
    }
    return null;
  }

  void copyDrillPlanJSONtoClip() async {
    const drillID = '9KBGSyiZV3TUjUXOFkhr';
    final text = await getDrillPlanJSON(drillID);
    if (text != null) {
      Clipboard.setData(ClipboardData(text: text));
    }
  }

  void updateDrillPlanDoc(DrillPlan d) async {
    addTestOutput('updateDrillPlanDoc @ ${timestamp()} on ${d.drillID}');
    final res = await d.updateDoc();
    if (res != null) {
      addTestOutput('successfully updated Drill Plan: ${d.drillID}');
    } else {
      addTestOutput('failed to update DrillPlan ${d.drillID}');
    }
  }

  void importDrillPlanFromJSON(String text, String drillID) async {
    addTestOutput('importDrillPlanFromJSON @ ${timestamp()}');
    final auth = FirebaseAuth.instanceFor(
      app: Firebase.app(),
      persistence: Persistence.INDEXED_DB,
    );
    final updatedDrillPlan = await _handleDrillPlanJSONException(
        DrillPlan.fromUserInputJson,
        jsonDecode(text),
        drillID,
        auth.currentUser!.uid,
        auth.currentUser!.email!);
    if (updatedDrillPlan != null) {
      addTestOutput(updatedDrillPlan.copyJson());
      updateDrillPlanDoc(updatedDrillPlan);
    } else {
      addTestOutput('null output from DrillPlan.fromUserInputJson');
    }
  }

  Future<DrillPlan?> _handleDrillPlanJSONException(
    Future<DrillPlan?> Function(
      Map<String, dynamic> json,
      String drillID,
      String userID,
      String userEmail,
    )
        function,
    Map<String, dynamic> json,
    String drillID,
    String userID,
    String userEmail,
  ) async {
    setJSONIsLoading();
    try {
      final result = await function(json, drillID, userID, userEmail);
      return result;
    } on FormatException catch (e) {
      // log += 'FirebaseAuthException e: ${e.toString()}' + '\n';
      addTestOutput(e.message);
      setState(() {
        jsonError = e.message;
      });
    } catch (e) {
      // log += 'regular e: ${e.toString()}' + '\n';
      addTestOutput('$e');
      setState(() {
        jsonError = '$e';
      });
    } finally {
      setJSONIsLoading();
    }
    return null;
  }

  void drillPlanJSONTextBox(context) async {
    const drillID = '9KBGSyiZV3TUjUXOFkhr';
    // show a dialog immediately that has big ass text field
    showDialog(
      context: context,
      builder: ((context) {
        return Dialog(
          child: Column(children: [
            // error banner
            Visibility(
                visible: jsonError.isNotEmpty,
                child: MaterialBanner(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  content: Text(jsonError),
                  actions: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            jsonError = '';
                          });
                        },
                        child: const Text(
                          'dismiss',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                  contentTextStyle: const TextStyle(color: Colors.white),
                  padding: const EdgeInsets.all(10),
                )),
            Row(children: [
              TestButton(
                'get json',
                () async => jsonIsLoading
                    ? null
                    : drillPlanJsonController.text =
                        await getDrillPlanJSON(drillID) ?? '',
              ),
              TestButton(
                  'save changes',
                  () => jsonIsLoading
                      ? null
                      : importDrillPlanFromJSON(
                          drillPlanJsonController.text,
                          drillID,
                        ) // change here
                  ),
            ]),
            TextField(
              autocorrect: false,
              maxLines: 30,
              controller: drillPlanJsonController,
            ),
          ]),
        );
      }),
    );

    // NO: give paste button (and copy button?)
    // // WE WILL GET THERE
    // // For now we are just importing to see what error handling we need for that
    // // We will get to the full text editing situation

    // we know the drillID anytime they're trying to do this
    // (or they need to use a separate menu "New DrillPlan from JSON")
  }

  void goToEditDrillPlanJsonPage(goToFunction) {
    const drillID = '9KBGSyiZV3TUjUXOFkhr';
    addTestOutput('goToEditDrillPlanJsonPage() @ ${timestamp()}');
    // context.pushNamed('planDrill-Info', params: {'test: '});
    goToFunction(drillID);
  }

  void rawDuplicateFirestoreDoc() async {
    const drillID = '4VJVpHgx958TzuAy0nwm';
    const newInviteCode = '394710';
    addTestOutput('rawDuplicateFirestoreDoc() @ ${timestamp()}');
    final firestore = FirebaseFirestore.instance;
    final drillPlanCol = firestore.collection('DrillPlan');
    final drillPlanDoc = drillPlanCol.doc(drillID);
    final drillPlanData = (await drillPlanDoc.get()).data();
    if (drillPlanData != null) {
      drillPlanData['inviteCode'] = newInviteCode;
      final newDrillID = (await drillPlanCol.add(drillPlanData)).id;
      addTestOutput('new drillID: "$newDrillID"');
    } else {
      addTestOutput('raw duplicate failed at ${timestamp()}');
    }
  }

  void getDrillPlanAndShow() async {
    addTestOutput('getDrillPlanAndShow() @ ${timestamp()}');
    // DrillPlan? drillPlan = await DrillPlan.fromDrillID('4VJVpHgx958TzuAy0nwm');
    DrillPlan? drillPlan = await DrillPlan.fromDrillID('bingbongwowowow');
    if (drillPlan == null) {
      addTestOutput('no drill plan for that ID');
    } else {
      addTestOutput('no drill plan for that ID');
      addTestOutput('blurb: ${drillPlan.blurb}');
      addTestOutput('creationDate: ${drillPlan.creationDate}');
      addTestOutput('creatorID: ${drillPlan.creatorID}');
      // addTestOutput('currentlyPlanningID: ${drillPlan.currentlyPlanningID}');
      addTestOutput('description: ${drillPlan.description}');
      addTestOutput('inviteCode: ${drillPlan.inviteCode}');
      addTestOutput('lastEdit: ${drillPlan.lastEdit}');
      addTestOutput('lastEditHash: ${drillPlan.lastEditHash}');
      addTestOutput('meetingDateTime: ${drillPlan.meetingDateTime}');
      addTestOutput(
          'meetingLocationPlainText: ${drillPlan.meetingLocationPlainText}');
      addTestOutput('tasks: ${drillPlan.tasks}');
      addTestOutput('title: ${drillPlan.title}');
      addTestOutput('type: ${drillPlan.type.name}');
      addTestOutput('');
      addTestOutput('type: ${drillPlan.toJson().toString()}');
      addTestOutput('');
    }
  }

  void changeDrillPlanSnapshot(context) async {
    addTestOutput('changeDrillPlanSnapshot() @ ${timestamp()}');
    DrillPlan? drillPlan = await DrillPlan.fromDrillID('4VJVpHgx958TzuAy0nwm');
    if (drillPlan == null) return;

    // print(drillPlan.toJson().hashCode);
    drillPlan.title = 'hehehe';

    int? result = await drillPlan.updateDoc();

    // could store int reult here if not null, to check stream of doc snapshots for this.

    addTestOutput('result: $result');
  }

  void reuploadedDrillStillEqual(context) async {
    addTestOutput('reuploadedDrillStillEqual() @ ${timestamp()}');
    DrillPlan? drillPlan1 = await DrillPlan.fromDrillID('4VJVpHgx958TzuAy0nwm');
    if (drillPlan1 == null) return;

    await drillPlan1.updateDoc();
    DrillPlan? drillPlan2 = await DrillPlan.fromDrillID('4VJVpHgx958TzuAy0nwm');
    if (drillPlan2 == null) return;

    addTestOutput('result: ${drillPlan1 == drillPlan2}');
    addTestOutput(
        'lastEditHashes:: ${drillPlan1.lastEditHash}, ${drillPlan2.lastEditHash}');
    addTestOutput('hashCodes:: ${drillPlan1.hashCode}, ${drillPlan2.hashCode}');
  }

  // Future<void> unprotectedHttpsOnReq() async {
  //   addTestOutput('unprotectedHttpsOnReq() @ ${timestamp()}');
  //   try {
  //     // final functionsInstance = FirebaseFunctions.instance;

  //     // final debug = FFAppState().debug && emulating;
  //     // const host = '127.0.0.1';
  //     // const port = 5001;
  //     // if (debug) {
  //     //   functionsInstance.useFunctionsEmulator(host, port);
  //     // }

  //     // need to make https req
  //     Future<http.Response> addDocToFirestore() {
  //       return http.get(Uri.parse(
  //           'https://us-central1-evac-drill-console.cloudfunctions.net/localFirestoreTemplate2'));
  //     }

  //     final result = await addDocToFirestore();

  //     addTestOutput(result.toString());
  //     addTestOutput(
  //         jsonDecode(result.body)?['success'] ?? 'can\'t decode body as json');
  //   } on FirebaseFunctionsException catch (error) {
  //     addTestOutput('Error occurred at ${timestamp()}…');
  //     addTestOutput('Error: ${error.code}');
  //     addTestOutput('Error: ${error.details}');
  //     addTestOutput('Error: ${error.message ?? 'no message'}');
  //   } catch (e) {
  //     addTestOutput('Error: ${e.toString()}');
  //     // addTestOutput('Error: ${e.toString()}');
  //   }
  // }
}

class TestButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const TestButton(this.text, this.onPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      onPressed: onPressed,
      text: text,
      // icon: Icon(
      //   Icons.cloud_download_rounded,
      //   color: FFTheme.of(context).primaryBtnText,
      //   size: 15,
      // ),
      options: FFButtonOptions(
        width: 296,
        height: 40,
        color: FFTheme.of(context).primaryColor,
        textStyle: FFTheme.of(context).subtitle2.override(
              fontFamily: 'Space Grotesk',
              color: FFTheme.of(context).primaryBtnText,
            ),
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
