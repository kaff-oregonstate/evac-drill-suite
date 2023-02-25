import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_util.dart';
import 'package:evac_drill_console/models/drill_task_plan.dart';
import 'package:evac_drill_console/models/evac_action_plans/evac_action_plan.dart';
import 'package:evac_drill_console/models/task_details_plans/task_details_plan.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'survey_step_plans/survey_step_plan.dart';

enum DrillType { tsunami }

const emulating = false;

/// The top-level model which holds all information about an upcoming (planned)
/// Evacuation Drill Event.

class DrillPlan {
  final String drillID; // fill in when parsing from Firestore
  String? currentlyPlanningID;
  String? currentlyPlanningEmail;
  String creatorID;
  String creatorEmail;
  DateTime creationDate;
  DateTime lastEdit;
  int lastEditHash;
  String? title;
  DrillType type;
  String? blurb;
  String? description;
  String? meetingLocationPlainText;
  DateTime? meetingDateTime;
  List<DrillTaskPlan> tasks;
  String? inviteCode; // (it could have one if it was DePublished)
  bool encryptResults;
  String? publicKey;
  bool published;

  DrillPlan({
    required this.drillID,
    this.currentlyPlanningID,
    this.currentlyPlanningEmail,
    required this.creatorID,
    required this.creatorEmail,
    required this.creationDate,
    required this.lastEdit,
    this.lastEditHash = -1,
    this.title,
    this.type = DrillType.tsunami,
    this.blurb,
    this.description,
    this.meetingLocationPlainText,
    this.meetingDateTime,
    tasks,
    this.inviteCode,
    this.encryptResults = true,
    this.publicKey,
    this.published = false,
  }) : tasks = tasks ?? const <DrillTaskPlan>[];

  /// Constructs a new DrillPlan object from the Firestore DocumentSnapshot
  factory DrillPlan.fromDoc(DocumentSnapshot snap) {
    final docData = snap.data() as Map<String, dynamic>;

    List<DrillTaskPlan> tasks = [];
    for (Map<String, dynamic> taskPlan in docData['tasks']) {
      tasks.add(DrillTaskPlan.fromJson(taskPlan));
    }

    DrillType thisType;
    if (docData['type'] == 'tsunami') {
      thisType = DrillType.tsunami;
    } else {
      thisType = DrillType.tsunami;
    }

    DateTime? meetingDateTime;
    if (docData['meetingDateTime'] != null) {
      meetingDateTime =
          DateTime.tryParse(docData['meetingDateTime'].toDate().toString());
    }

    return DrillPlan(
      drillID: snap.id,
      currentlyPlanningID: docData['currentlyPlanningID'],
      currentlyPlanningEmail: docData['currentlyPlanningEmail'],
      creatorID: docData['creatorID'],
      creatorEmail: docData['creatorEmail'],
      creationDate: DateTime.parse(docData['creationDate'].toDate().toString()),
      lastEdit: DateTime.parse(docData['lastEdit'].toDate().toString()),
      lastEditHash: docData['lastEditHash'] ?? -1,
      title: docData['title'],
      type: thisType,
      blurb: docData['blurb'],
      description: docData['description'],
      meetingLocationPlainText: docData['meetingLocationPlainText'],
      meetingDateTime: meetingDateTime,
      tasks: tasks,
      inviteCode: docData['inviteCode'],
      encryptResults: docData['encryptResults'],
      publicKey: docData['publicKey'],
      published: docData['published'] ?? false,
    );
  }

  /// Gets the DrillPlan JSON with matching ID from Firestore, and returns
  /// it as a DrillPlan object
  static Future<DrillPlan?> fromDrillID(String drillID) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference drillPlans = firestore.collection('DrillPlan');

    try {
      DocumentSnapshot docSnap = await drillPlans.doc(drillID).get();
      return DrillPlan.fromDoc(docSnap);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
      // FIXME: Implement `DrillPlan.fromDrillID` exception handling
      return null;
    }
  }

  /// Constructs a new DrillPlan object from a user input JSON string
  factory DrillPlan._fromUserInputJson(Map<String, dynamic> json) {
    List<DrillTaskPlan> tasks = [];
    for (Map<String, dynamic> taskPlan in json['tasks']) {
      tasks.add(DrillTaskPlan.fromJson(taskPlan));
    }

    DrillType thisType;
    if (json['type'] == 'tsunami') {
      thisType = DrillType.tsunami;
    } else {
      thisType = DrillType.tsunami;
    }

    return DrillPlan(
      drillID: json['drillID'],
      currentlyPlanningID: json['currentlyPlanningID'],
      currentlyPlanningEmail: json['currentlyPlanningEmail'],
      creatorID: json['creatorID'],
      creatorEmail: json['creatorEmail'],
      creationDate: DateTime.parse(json['creationDate']),
      lastEdit: DateTime.parse(json['lastEdit']),
      lastEditHash: json['lastEditHash'] ?? -1,
      title: json['title'],
      type: thisType,
      blurb: json['blurb'],
      description: json['description'],
      meetingLocationPlainText: json['meetingLocationPlainText'],
      meetingDateTime: DateTime.tryParse(json['meetingDateTime']),
      tasks: tasks,
      inviteCode: json['inviteCode'],
      encryptResults: json['encryptResults'],
      publicKey: json['publicKey'],
      published: json['published'] ?? false,
    );
  }

  static Future<DrillPlan?> fromUserInputJson(
    Map<String, dynamic> json,
    String drillID,
    String userID,
    String userEmail,
  ) async {
    // get the data from firestore
    final oldData = await DrillPlan.fromDrillID(drillID);
    if (oldData == null) {
      throw Exception('INTERNAL: bad drill id on DrillPlan.fromUserInputJson');
    }
    if (oldData.creatorID != userID) {
      throw Exception(
          'Forbidden: Attempting to edit DrillPlan created by a different user. Duplicate the DrillPlan, then make changes to the duplicate.');
    }
    json['creatorID'] = userID;
    json['creatorEmail'] = userEmail;

    bool foundDrillType = false;
    for (final value in DrillType.values) {
      if (json['type'] == value.name) foundDrillType = true;
    }
    if (!foundDrillType) {
      // could throw a format exception here, but just paste in tsunami for now
      json['type'] = 'tsunami';
    }

    json['creationDate'] = oldData.creationDate.toIso8601String();
    json['lastEdit'] = DateTime.now().toIso8601String();
    json['lastEditHash'] = oldData.lastEditHash + 1;

    /// instead of the below logic for the publicKey, just don't let them edit via
    /// json at all…
    // if (json['publicKey'] != null && json['publicKey'] != oldData.publicKey) {
    //   throw const FormatException('publicKey data does not match previous');

    //   /// put this wherever is interpreting these exceptions:
    //   /// 'Attempting to change public key using Edit Json page: please instead copy the public key from the Encryption Manager and use the menu option titled `Change public key` on the Drill Plan\'s Card on the Dashboard. (You can simply remove the entire `publicKey` field to save other changes to the json)'
    // }
    // if (json['publicKey'] == null) {
    //   json['publicKey'] = oldData.publicKey;
    // }
    if (json['publicKey'] != null) {
      throw const FormatException(
          'Cannot change publicKey via JSON input. Use the `change public key` menu item on the drill plan card.');
    }
    json['publicKey'] = oldData.publicKey;
    json['inviteCode'] = oldData.inviteCode;
    json['published'] = oldData.published;

    /// we are not going to type check everything, only 5 days left!
    if (json['encryptResults'].runtimeType != bool) {
      if (json['encryptResults'] == 'true') {
        json['encryptResults'] = true;
      } else if (json['encryptResults'] == 'false') {
        json['encryptResults'] = false;
      } else {
        throw const FormatException(
            '`encryptResults` field must be bool: `true` or `false` without quotes ');
      }
    }

    List<DrillTaskPlan> tasks = [];
    for (Map<String, dynamic> taskPlan in json['tasks']) {
      try {
        tasks.add(DrillTaskPlan.fromJson(taskPlan));
      } catch (e) {
        throw FormatException(
            'A task in the tasks list is improperly formatted: $e');
      }
    }

    json['drillID'] = drillID;

    return DrillPlan._fromUserInputJson(json);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> tasksJson = [];
    for (final task in tasks) {
      tasksJson.add(task.toJson());
    }
    return {
      'currentlyPlanningID': currentlyPlanningID,
      'currentlyPlanningEmail': currentlyPlanningEmail,
      'creatorID': creatorID,
      'creatorEmail': creatorEmail,
      'creationDate': creationDate,
      'lastEdit': DateTime.now(),
      'lastEditHash': hashCode,
      'title': title,
      'type': type.name,
      'blurb': blurb,
      'description': description,
      'meetingLocationPlainText': meetingLocationPlainText,
      'meetingDateTime': meetingDateTime,
      'tasks': tasksJson,
      'inviteCode': inviteCode,
      'encryptResults': encryptResults,
      'publicKey': publicKey,
      'published': published,
    };
  }

  String copyJson() {
    Map<String, dynamic> thisJson = toJson();
    thisJson['creationDate'] =
        (thisJson['creationDate'] as DateTime).toIso8601String();
    thisJson['lastEdit'] = (thisJson['lastEdit'] as DateTime).toIso8601String();
    thisJson['meetingDateTime'] =
        (thisJson['meetingDateTime'] as DateTime).toIso8601String();
    // thisJson['publicKey'] = null;
    thisJson.remove('publicKey');
    // thisJson['lastEditHash'] = null;
    return const JsonEncoder.withIndent('\t').convert(thisJson);
    // return jsonEncode(thisJson);
  }

  /// Checks if any required parameters or sub-parameters are missing
  List<MissingPlanParam> paramsMissing() {
    List<MissingPlanParam> missingParams = [];

    if (title == null || title!.isEmpty) {
      missingParams.add(MissingPlanParam('title'));
    }
    if (meetingLocationPlainText == null || meetingLocationPlainText!.isEmpty) {
      missingParams.add(MissingPlanParam('meetingLocationPlainText'));
    }
    if (meetingDateTime == null) {
      missingParams.add(MissingPlanParam('meetingDateTime'));
    }
    if (encryptResults && (publicKey == null || publicKey!.isEmpty)) {
      missingParams.add(MissingPlanParam('publicKey'));
    }
    if (tasks.isEmpty) {
      missingParams.add(MissingPlanParam('tasks'));
    }

    for (var i = 0; i < tasks.length; i++) {
      final stepMissingParams = tasks[i].paramsMissing();
      for (final missingParam in stepMissingParams) {
        missingParams.add(MissingPlanParam('tasks[$i].${missingParam.field}'));
      }
    }

    return missingParams;
  }

  /// validates that the DrillPlan is ready for publishing
  /// IMPORTANT: only call after missingParams() is confirmed to return empty
  void validate() {
    // for now, not much to do here
    if (meetingDateTime!.difference(DateTime.now()).inDays < -1) {
      throw const FormatException(
          'The meeting date/time is before today. Please set a meeting date/time that is in the future');
    }

    // TODO: validate: each survey has intro, outro

    // just want to ensure that if there is a practice evac task with location
    // tracking, that there is an req loc perms task before it
    bool foundReqLocPerms = false;
    int evacIndex = 1;
    int surveyIndex = 1;
    for (int taskIndex = 0; taskIndex < tasks.length; taskIndex++) {
      final task = tasks[taskIndex];
      if (task.taskType == DrillTaskType.reqLocPerms) {
        foundReqLocPerms = true;
      }
      if (task.taskType == DrillTaskType.practiceEvac) {
        final details = task.details as PracticeEvacDetailsPlan;
        if (details.trackingLocation! && !foundReqLocPerms) {
          throw FormatException(
              'There is a Practice Evacuation Task with location tracking enabled, but it happens before any Request Location Permission Task. Please put a Request Location Permission Task before the Practice Evacuation Task.\n[Practice Evac #$evacIndex, task #${taskIndex + 1}]');
        }
        if (details.trackingLocation! &&
            details.actions[0].actionType != EvacActionType.waitForStart) {
          throw FormatException(
              'The first Action in a Practice Evacuation Task (with location tracking enabled) must be a "Wait For Start". Please add one, or move an existing "Wait For Start" to the beginning of the list of actions.\n[Practice Evac #$evacIndex, task #${taskIndex + 1}]');
        }
        evacIndex++;
      }
      if (task.taskType == DrillTaskType.survey) {
        final details = task.details as SurveyDetailsPlan;
        if (details.surveySteps.first.type != SurveyStepType.introduction) {
          throw FormatException(
              'The first SurveyStep in a Survey Task must be an "Introduction Step". Please add one, or move an existing "Introduction Step" to the beginning of the list of survey steps.\n[Survey #$surveyIndex, task #${taskIndex + 1}]');
        }
        if (details.surveySteps.last.type != SurveyStepType.completion) {
          throw FormatException(
              'The last SurveyStep in a Survey Task must be a "Completion Step". Please add one, or move an existing "Completion Step" to the end of the list of survey steps.\n[Survey #$surveyIndex, task #${taskIndex + 1}]');
        }
        surveyIndex++;
      }
    }
  }

  /// Sends the entire DrillPlan as a JSON to Firestore via the `update` method
  Future<int?> updateDoc() async {
    final drillPlanJson = toJson();
    if (drillPlanJson['published']) {
      throw Exception(
          'Forbidden: Attempting to update Firestore doc for drill which has already been published.');
    }
    // print(drillPlanJson.hashCode);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference drillPlans = firestore.collection('DrillPlan');
    try {
      await drillPlans.doc(drillID).update(drillPlanJson);
    } on Exception catch (e) {
      // FIXME: implement updateDoc exception handling
      // ignore: avoid_print
      print(e);
      return null;
    }
    return drillPlanJson['lastEditHash'];
  }

  /// functions below here maybe shouldn't be in the data model definition,
  /// but here we are (6 days left)

  /// creates a duplicate (cleaned) DrillPlan document in Firestore, and returns
  /// the new docID (drillID)
  Future<String?> duplicate(String userID, String userEmail) async {
    Map<String, dynamic> drillPlanJson = toJson();
    drillPlanJson['creatorID'] = userID;
    drillPlanJson['creatorEmail'] = userEmail;
    drillPlanJson['creationDate'] = drillPlanJson['lastEdit'];
    drillPlanJson['inviteCode'] = null;
    drillPlanJson['currentlyPlanningID'] = null;
    drillPlanJson['currentlyPlanningEmail'] = null;
    drillPlanJson['published'] = false;
    drillPlanJson['title'] = 'Copy of ${drillPlanJson['title']}';
    drillPlanJson['publicKey'] = null;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference drillPlans = firestore.collection('DrillPlan');
    DocumentReference newDrillPlan;

    try {
      // const overwriteDocID = '9KBGSyiZV3TUjUXOFkhr';
      // await drillPlans.doc(overwriteDocID).set(drillPlanJson);
      // return overwriteDocID;
      newDrillPlan = await drillPlans.add(drillPlanJson);
      return newDrillPlan.id;
    } on Exception catch (e) {
      // FIXME: implement duplicate exception handling
      // ignore: avoid_print
      print(e);
      return null;
    }
  }

  static Future<String> newDrillPlan(String userID, String userEmail) async {
    // final newDrillPlanSkeleton = {
    //   'creatorID': userID,
    //   'creatorEmail': userEmail,
    //   'creationDate': DateTime.now(),
    //   'lastEdit': DateTime.now(),
    //   'tasks': [],
    // };

    final newDrillPlanSkeleton = DrillPlan(
      drillID: 'fakeDrillID',
      creatorID: userID,
      creatorEmail: userEmail,
      creationDate: DateTime.now(),
      lastEdit: DateTime.now(),
      // inviteCode: '876542',
      // published: true,
    );

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference drillPlans = firestore.collection('DrillPlan');
    DocumentReference newDrillPlanDoc;
    // DocumentReference newDrillPlan = drillPlans.doc('VdEmrlBxQTC3lVSCS8bN');
    newDrillPlanDoc = await drillPlans.add(newDrillPlanSkeleton.toJson());
    // await newDrillPlan.set(newDrillPlanSkeleton.toJson());
    return newDrillPlanDoc.id;
    // return newDrillPlan.id;
  }

  /// Deletes the DrillPlan doc from Firestore
  Future<bool> delete(String userID) async {
    if (userID != creatorID) {
      throw Exception('Forbidden: Cannot delete another user\'s DrillPlan');
    }
    Map<String, dynamic> drillPlanJson = toJson();
    drillPlanJson['deletedDateTime'] = DateTime.now();
    drillPlanJson['originalDrillID'] = drillID;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference deletedDrillPlans =
        firestore.collection('DeletedDrillPlan');
    DocumentReference deletedDrillPlan;

    try {
      deletedDrillPlan = await deletedDrillPlans.add(drillPlanJson);
      if ((await deletedDrillPlan.get()).exists) {
        CollectionReference drillPlans = firestore.collection('DrillPlan');
        try {
          drillPlans.doc(drillID).delete();
          deletedDrillPlan.update({'deleteSuccess': true});
          return true;
        } catch (e) {
          // ignore: avoid_print
          print(e);
          deletedDrillPlan.update({'deleteSuccess': false});
        }
      }
    } on Exception catch (e) {
      // FIXME: implement delete exception handling
      // ignore: avoid_print
      print(e);
    }
    return false;
  }

  /// Calls the Cloud Function to package up any results, gets the zip download
  /// location, and returns it as a String
  Future<String?> accessResults(String userID) async {
    // if (userID != creatorID) {
    //   throw Exception(
    //       'Forbidden: Cannot access results for another user\'s DrillPlan');
    // }

    try {
      final functionsInstance = FirebaseFunctions.instance;

      final debug = FFAppState().debug && emulating;
      if (debug) {
        const host = '127.0.0.1';
        const port = 5001;
        functionsInstance.useFunctionsEmulator(host, port);
      }

      final result =
          await functionsInstance.httpsCallable('accessResults').call({
        'drillID': drillID,
        // 'enforeDuplicateResultsZip': true,
      });

      if (result.data['error'] != null) {
        // ignore: avoid_print
        print('Error:');
        // ignore: avoid_print
        print(result.data?['error'] ?? 'no data');
        // ignore: avoid_print
        print(result.data?['errorText'] ?? 'no data');
        return null;
      } else {
        // print(result.data?.toString() ?? 'no data');
        // print(result.data?['success'] ?? 'no data');
        final zipDestination = result.data?['zipDestination'];
        final storageRef = FirebaseStorage.instance.ref();
        final zipRef = storageRef.child(zipDestination);

        final zipURL = await zipRef.getDownloadURL();
        return zipURL;
      }
    } on FirebaseFunctionsException catch (error) {
      // ignore: avoid_print
      print('Error: ${error.code}');
      // ignore: avoid_print
      print('Error: ${error.details ?? 'no details'}');
      // ignore: avoid_print
      print('Error: ${error.message ?? 'no message'}');
      return null;
    }
  }

  Future<bool> publish(String userID) async {
    if (userID != creatorID) {
      throw Exception('Forbidden: Cannot publish another user\'s DrillPlan');
    }

    try {
      final functionsInstance = FirebaseFunctions.instance;

      // // FIXME: remove for prod!!
      // if (false) {
      //   const host = '127.0.0.1';
      //   const port = 5001;
      //   functionsInstance.useFunctionsEmulator(host, port);
      // }

      final result = await functionsInstance
          .httpsCallable('publishDrill')
          .call({'drillID': drillID});

      if (result.data['error'] != null) {
        // ignore: avoid_print
        print('Error:');
        // ignore: avoid_print
        print(result.data?['errorText'] ?? 'no data');
        return false;
      } else {
        return true;
      }
    } on FirebaseFunctionsException catch (error) {
      // ignore: avoid_print
      print('Error: ${error.code}');
      // ignore: avoid_print
      print('Error: ${error.details ?? 'no details'}');
      // ignore: avoid_print
      print('Error: ${error.message ?? 'no message'}');
    }
    return false;
  }

  Future<bool> depublish(String userID) async {
    if (userID != creatorID) {
      throw Exception('Forbidden: Cannot depublish another user\'s DrillPlan');
    }

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
        // ignore: avoid_print
        print('Error:');
        // ignore: avoid_print
        print(result.data?['errorText'] ?? 'no data');
        return false;
      } else {
        // print(result.data?.toString() ?? 'no data');
        // print(result.data?['success'] ?? 'no data');
        return true;
        // print(result.data?['inviteCode'] ?? 'no data');
      }
    } on FirebaseFunctionsException catch (error) {
      // ignore: avoid_print
      print('Error: ${error.code}');
      // ignore: avoid_print
      print('Error: ${error.details ?? 'no details'}');
      // ignore: avoid_print
      print('Error: ${error.message ?? 'no message'}');
    }
    return false;
  }

  // @override
  // int get hashCode => Object.hashAll([
  //       drillID,
  // currentlyPlanningID,
  //       creatorID,
  //       creationDate,
  //       lastEdit,
  //       title,
  //       type,
  //       blurb,
  //       description,
  //       meetingLocationPlainText,
  //       meetingDateTime,
  //       tasks,
  //       inviteCode,
  //     ]);

  // @override
  // bool operator ==(Object other) {
  //   if (other.runtimeType != DrillPlan) {
  //     print('other.runtimeType');
  //     return false;
  //   }
  //   other as DrillPlan;
  //   // drillID
  //   if (drillID != other.drillID) {
  //     print('drillID');
  //     return false;
  //   }
  // currentlyPlanningID
  // if (currentlyPlanningID != other.currentlyPlanningID) {
  //   print('currentlyPlanningID');
  //     return false;
  //   }
  //   // creatorID
  //   if (creatorID != other.creatorID) {
  //     print('creatorID');
  //     return false;
  //   }
  //   // creationDate
  //   if (creationDate != other.creationDate) {
  //     print('creationDate');
  //     return false;
  //   }
  //   // lastEdit
  //   if (lastEdit != other.lastEdit) {
  //     print('lastEdit');
  //     return false;
  //   }
  //   // title
  //   if (title != other.title) {
  //     print('title');
  //     return false;
  //   }
  //   // type
  //   if (type != other.type) {
  //     print('type');
  //     return false;
  //   }
  //   // blurb
  //   if (blurb != other.blurb) {
  //     print('blurb');
  //     return false;
  //   }
  //   // description
  //   if (description != other.description) {
  //     print('description');
  //     return false;
  //   }
  //   // meetingLocationPlainText
  //   if (meetingLocationPlainText != other.meetingLocationPlainText) {
  //     print('meetingLocationPlainText');
  //     return false;
  //   }
  //   // meetingDateTime
  //   if (meetingDateTime != other.meetingDateTime) {
  //     print('meetingDateTime');
  //     return false;
  //   }
  //   // tasks
  //   if (tasks.length != other.tasks.length) {
  //     print('tasks.length');
  //     return false;
  //   }
  //   for (var i = 0; i < tasks.length; i++) {
  //     if (tasks[i] != other.tasks[i]) {
  //       print('tasks[$i]');
  //       return false;
  //     }
  //   }
  //   // inviteCode
  //   if (inviteCode != other.inviteCode) {
  //     print('inviteCode');
  //     return false;
  //   }

  //   return true;
  // }
}
