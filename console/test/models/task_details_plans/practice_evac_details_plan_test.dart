import 'package:evac_drill_console/models/task_details_plans/practice_evac_details_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testPracticeEvacDetailsPlan();
}

void testPracticeEvacDetailsPlan() {
  test(
    'PracticeEvacDetailsPlan.fromJson(invalid) throws FormatException',
    () => expect(() => PracticeEvacDetailsPlan.fromJson(PEDX.invalidCase),
        throwsFormatException),
  );

  test(
    'PracticeEvacDetailsPlan.fromJson(null taskID) throws FormatException',
    () => expect(() => PracticeEvacDetailsPlan.fromJson(PEDX.nullID),
        throwsFormatException),
  );

  // test null actions list passed into .fromJson
  //  // also missing `title` and `trackingLocation` params
  group('PracticeEvacDetailsPlan.fromJson(emptyListMissingParams)', () {
    // import from example DrillTaskPlanJson using PracticeEvacDetailsPlan.fromJson
    final pEDP = PracticeEvacDetailsPlan.fromJson(PEDX.emptyListMissingParams);
    test(
      'taskID matches',
      () => expect(pEDP.taskID,
          equals(PEDX.emptyListMissingParams['details']['taskID'])),
    );
    test(
      'title matches',
      () => expect(
          pEDP.title, equals(PEDX.emptyListMissingParams['details']['title'])),
    );
    test(
      'trackingLocation matches',
      () => expect(pEDP.trackingLocation,
          equals(PEDX.emptyListMissingParams['details']['trackingLocation'])),
    );
    test(
      'actions matches',
      () => expect(pEDP.actions,
          equals(PEDX.emptyListMissingParams['details']['actions'])),
    );

    final missingParams = pEDP.paramsMissing();
    test('.paramsMissing() is not empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 3',
        () => expect(missingParams.length, equals(3)));
  });

  group('PracticeEvacDetailsPlan.toJson(emptyListMissingParams)', () {
    // import from example DrillTaskPlanJson using PracticeEvacDetailsPlan.fromJson
    final pEDP = PracticeEvacDetailsPlan.fromJson(PEDX.emptyListMissingParams);
    // Export to TaskDetailsPlanJson using PracticeEvacDetailsPlan.toJson
    final taskDetailsPlanJsonResult = pEDP.toJson();

    test(
      'taskID matches',
      () => expect(taskDetailsPlanJsonResult['taskID'],
          equals(PEDX.emptyListMissingParams['details']['taskID'])),
    );
    test(
      'title matches',
      () => expect(taskDetailsPlanJsonResult['title'],
          equals(PEDX.emptyListMissingParams['details']['title'])),
    );
    test(
      'trackingLocation matches',
      () => expect(taskDetailsPlanJsonResult['trackingLocation'],
          equals(PEDX.emptyListMissingParams['details']['trackingLocation'])),
    );
    test(
      'actions matches',
      () => expect(taskDetailsPlanJsonResult['actions'],
          equals(PEDX.emptyListMissingParams['details']['actions'])),
    );
  });

  // test empty actions list passed into .fromJson
  //  // also empty `title` param
  group('PracticeEvacDetailsPlan.fromJson(actionsAndParamsEmpty)', () {
    // import from example DrillTaskPlanJson using PracticeEvacDetailsPlan.fromJson
    final pEDP = PracticeEvacDetailsPlan.fromJson(PEDX.actionsAndParamsEmpty);
    test(
      'taskID matches',
      () => expect(
          pEDP.taskID, equals(PEDX.actionsAndParamsEmpty['details']['taskID'])),
    );
    test(
      'title matches',
      () => expect(
          pEDP.title, equals(PEDX.actionsAndParamsEmpty['details']['title'])),
    );
    test(
      'trackingLocation matches',
      () => expect(pEDP.trackingLocation,
          equals(PEDX.actionsAndParamsEmpty['details']['trackingLocation'])),
    );

    test(
      'actions length matches',
      () {
        final actions =
            PEDX.actionsAndParamsEmpty['details']['actions'] as List<Map>;
        expect(pEDP.actions.length, equals(actions.length));
      },
    );

    final missingParams = pEDP.paramsMissing();
    test('.paramsMissing() is not empty',
        () => expect(missingParams, isNotEmpty));
    // even though `actions` has a WaitForStartAction, it does not have any
    // InstructionAction, and therefore is a missing parameter
    test('.paramsMissing() returns 2',
        () => expect(missingParams.length, equals(2)));
  });

  group('PracticeEvacDetailsPlan.toJson(actionsAndParamsEmpty)', () {
    // import from example DrillTaskPlanJson using PracticeEvacDetailsPlan.fromJson
    final pEDP = PracticeEvacDetailsPlan.fromJson(PEDX.actionsAndParamsEmpty);
    // Export to TaskDetailsPlanJson using PracticeEvacDetailsPlan.toJson
    final taskDetailsPlanJsonResult = pEDP.toJson();

    test(
      'taskID matches',
      () => expect(taskDetailsPlanJsonResult['taskID'],
          equals(PEDX.actionsAndParamsEmpty['details']['taskID'])),
    );
    test(
      'title matches',
      () => expect(taskDetailsPlanJsonResult['title'],
          equals(PEDX.actionsAndParamsEmpty['details']['title'])),
    );
    test(
      'trackingLocation matches',
      () => expect(taskDetailsPlanJsonResult['trackingLocation'],
          equals(PEDX.actionsAndParamsEmpty['details']['trackingLocation'])),
    );
    test(
      'actions matches',
      () => expect(taskDetailsPlanJsonResult['actions'],
          equals(PEDX.actionsAndParamsEmpty['details']['actions'])),
    );
  });

  // test invalid actions list passed into .fromJson
  test(
    'PracticeEvacDetailsPlan.fromJson(invalid actions) throws FormatException',
    () => expect(() => PracticeEvacDetailsPlan.fromJson(PEDX.invalidActions),
        throwsFormatException),
  );

  // test actions having missingParams case .paramsMissing()
  group('PracticeEvacDetailsPlan.fromJson(actionsMissingParams)', () {
    // import from example DrillTaskPlanJson using PracticeEvacDetailsPlan.fromJson
    final pEDP = PracticeEvacDetailsPlan.fromJson(PEDX.actionsMissingParams);
    test(
      'taskID matches',
      () => expect(
          pEDP.taskID, equals(PEDX.actionsMissingParams['details']['taskID'])),
    );
    test(
      'title matches',
      () => expect(
          pEDP.title, equals(PEDX.actionsMissingParams['details']['title'])),
    );
    test(
      'trackingLocation matches',
      () => expect(pEDP.trackingLocation,
          equals(PEDX.actionsMissingParams['details']['trackingLocation'])),
    );
    test(
      'actions length matches',
      () {
        final actions =
            PEDX.actionsMissingParams['details']['actions'] as List<Map>;
        expect(pEDP.actions.length, equals(actions.length));
      },
    );

    final missingParams = pEDP.paramsMissing();
    test('.paramsMissing() is not empty',
        () => expect(missingParams, isNotEmpty));
    // 2 actions have 1 missing/empty param each
    test('.paramsMissing() returns 2',
        () => expect(missingParams.length, equals(2)));
  });

  group('PracticeEvacDetailsPlan.toJson(actionsMissingParams)', () {
    // import from example DrillTaskPlanJson using PracticeEvacDetailsPlan.fromJson
    final pEDP = PracticeEvacDetailsPlan.fromJson(PEDX.actionsMissingParams);
    // Export to TaskDetailsPlanJson using PracticeEvacDetailsPlan.toJson
    final taskDetailsPlanJsonResult = pEDP.toJson();

    test(
      'taskID matches',
      () => expect(taskDetailsPlanJsonResult['taskID'],
          equals(PEDX.actionsMissingParams['details']['taskID'])),
    );
    test(
      'title matches',
      () => expect(taskDetailsPlanJsonResult['title'],
          equals(PEDX.actionsMissingParams['details']['title'])),
    );
    test(
      'trackingLocation matches',
      () => expect(taskDetailsPlanJsonResult['trackingLocation'],
          equals(PEDX.actionsMissingParams['details']['trackingLocation'])),
    );
    test(
      'actions matches',
      () => expect(taskDetailsPlanJsonResult['actions'],
          equals(PEDX.actionsMissingParams['details']['actions'])),
    );
  });

  // test full actions list passed into .fromJson
  group('PracticeEvacDetailsPlan.fromJson(happyCase)', () {
    // import from example DrillTaskPlanJson using PracticeEvacDetailsPlan.fromJson
    final pEDP = PracticeEvacDetailsPlan.fromJson(PEDX.happyCase);
    test(
      'taskID matches',
      () => expect(pEDP.taskID, equals(PEDX.happyCase['details']['taskID'])),
    );
    test(
      'title matches',
      () => expect(pEDP.title, equals(PEDX.happyCase['details']['title'])),
    );
    test(
      'trackingLocation matches',
      () => expect(pEDP.trackingLocation,
          equals(PEDX.happyCase['details']['trackingLocation'])),
    );
    test(
      'actions length matches',
      () {
        final actions = PEDX.happyCase['details']['actions'] as List<Map>;
        expect(pEDP.actions.length, equals(actions.length));
      },
    );

    final missingParams = pEDP.paramsMissing();
    test('.paramsMissing() is empty', () => expect(missingParams, isEmpty));
  });

  group('PracticeEvacDetailsPlan.toJson(happyCase)', () {
    // import from example DrillTaskPlanJson using PracticeEvacDetailsPlan.fromJson
    final pEDP = PracticeEvacDetailsPlan.fromJson(PEDX.happyCase);
    // Export to TaskDetailsPlanJson using PracticeEvacDetailsPlan.toJson
    final taskDetailsPlanJsonResult = pEDP.toJson();

    test(
      'taskID matches',
      () => expect(taskDetailsPlanJsonResult['taskID'],
          equals(PEDX.happyCase['details']['taskID'])),
    );
    test(
      'title matches',
      () => expect(taskDetailsPlanJsonResult['title'],
          equals(PEDX.happyCase['details']['title'])),
    );
    test(
      'trackingLocation matches',
      () => expect(taskDetailsPlanJsonResult['trackingLocation'],
          equals(PEDX.happyCase['details']['trackingLocation'])),
    );
    test(
      'actions matches',
      () => expect(taskDetailsPlanJsonResult['actions'],
          equals(PEDX.happyCase['details']['actions'])),
    );
  });
}

/// Example JSON inputs for PracticeEvacDetailsPlan
class PEDX {
  // invalidCase
  static const Map<String, dynamic> invalidCase = {
    'taskID': 'exampleID-abc',
    'taskType': 'survey',
    'title': 'A survey which will never be taken 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
    },
  };
  // nullID
  static const Map<String, dynamic> nullID = {
    'taskID': 'exampleID-abc',
    'taskType': 'practiceEvac',
    'title': 'A practice evacuation which will never be taken 🤷‍♂️',
    'details': {
      'taskID': null,
    },
  };
  // emptyListMissingParams
  static const Map<String, dynamic> emptyListMissingParams = {
    'taskID': 'exampleID-abc',
    'taskType': 'practiceEvac',
    'title': 'A practice evacuation which will never be taken 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
      // 'title': null,
      // 'trackingLocation': null,
      'actions': [],
    },
  };
  // actionsAndParamsEmpty
  static const Map<String, dynamic> actionsAndParamsEmpty = {
    'taskID': 'exampleID-abc',
    'taskType': 'practiceEvac',
    // 'title': 'A practice evacuation which will never be taken 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
      'title': '',
      'trackingLocation': true,
      'actions': [
        {
          'actionType': 'waitForStart',
          'actionID': 'exampleID-abc',
          'waitType': 'self',
        }
      ],
    },
  };
  // invalidActions
  static const Map<String, dynamic> invalidActions = {
    'taskID': 'exampleID-abc',
    'taskType': 'practiceEvac',
    'title': 'A practice evacuation which will never be taken 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
      'title': 'An Example Practice Evacuation Title',
      'trackingLocation': true,
      'actions': [
        {
          'actionType': 'instruction',
          'actionID': 'exampleID-abc',
          'text': 'An evacuation instruction which will never be given 🤷‍♂️',
        },
      ],
    },
  };
  // actionsMissingParams
  static const Map<String, dynamic> actionsMissingParams = {
    'taskID': 'exampleID-abc',
    'taskType': 'practiceEvac',
    'title': 'A practice evacuation which will never be taken 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
      'title': 'An Example Practice Evacuation Title',
      'trackingLocation': true,
      'actions': [
        {
          'actionType': 'waitForStart',
          'actionID': 'exampleID-abc',
          'waitType': 'self',
        },
        {
          'actionType': 'instruction',
          'actionID': 'exampleID-abc',
          'text': null,
        },
        {
          'actionType': 'instruction',
          'actionID': 'exampleID-abc',
          'text': '',
        }
      ],
    },
  };
  // happyCase
  static const Map<String, dynamic> happyCase = {
    'taskID': 'exampleID-abc',
    'taskType': 'practiceEvac',
    'title': 'A practice evacuation which will never be taken 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
      'title': 'An Example Practice Evacuation Title',
      'trackingLocation': true,
      'actions': [
        {
          'actionType': 'waitForStart',
          'actionID': 'exampleID-abc',
          'waitType': 'self',
        },
        {
          'actionType': 'instruction',
          'actionID': 'exampleID-abc',
          'text': 'An example evacuation instruction.',
        },
      ],
    },
  };
}
