import 'package:evac_drill_console/models/task_details_plans/wait_for_start_details_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWaitForStartDetailsPlan();
}

void testWaitForStartDetailsPlan() {
  test(
    'WaitForStartDetailsPlan.fromJson(invalid) throws FormatException',
    () => expect(() => WaitForStartDetailsPlan.fromJson(WFSDX.invalidCase),
        throwsFormatException),
  );

  test(
    'WaitForStartDetailsPlan.fromJson(null taskID) throws FormatException',
    () => expect(() => WaitForStartDetailsPlan.fromJson(WFSDX.nullID),
        throwsFormatException),
  );

  test(
    'WaitForStartDetailsPlan.fromJson(null practiceEvacTaskID) throws FormatException',
    () => expect(() => WaitForStartDetailsPlan.fromJson(WFSDX.nullPETid),
        throwsFormatException),
  );

  group('WaitForStartDetailsPlan.fromJson(noWaitType)', () {
    // import from example DrillTaskPlanJson using WaitForStartDetailsPlan.fromJson
    final wFSDP = WaitForStartDetailsPlan.fromJson(WFSDX.noWaitType);
    test(
      'taskID matches',
      () => expect(wFSDP.taskID, equals(WFSDX.noWaitType['details']['taskID'])),
    );
    test(
      'practiceEvacTaskID matches',
      () => expect(wFSDP.practiceEvacTaskID,
          equals(WFSDX.noWaitType['details']['practiceEvacTaskID'])),
    );
    test('typeOfWait is default (self)',
        () => expect(wFSDP.typeOfWait.name, equals('self')));
    test('.paramsMissing() returns empty',
        () => expect(wFSDP.paramsMissing(), isEmpty));
  });

  group('WaitForStartDetailsPlan.toJson(noWaitType)', () {
    // import from example DrillTaskPlanJson using WaitForStartDetailsPlan.fromJson
    final wFSDP = WaitForStartDetailsPlan.fromJson(WFSDX.noWaitType);
    // Export to TaskDetailsPlanJson using WaitForStartDetailsPlan.toJson
    final taskDetailsPlanJsonResult = wFSDP.toJson();

    test(
      'taskID matches',
      () => expect(taskDetailsPlanJsonResult['taskID'],
          equals(WFSDX.noWaitType['details']['taskID'])),
    );
    test(
      'practiceEvacTaskID matches',
      () => expect(taskDetailsPlanJsonResult['practiceEvacTaskID'],
          equals(WFSDX.noWaitType['details']['practiceEvacTaskID'])),
    );
    test('typeOfWait is now default (self)',
        () => expect(taskDetailsPlanJsonResult['typeOfWait'], equals('self')));
  });

  group('WaitForStartDetailsPlan.fromJson(happyCase)', () {
    // import from example DrillTaskPlanJson using WaitForStartDetailsPlan.fromJson
    final wFSDP = WaitForStartDetailsPlan.fromJson(WFSDX.happyCase);
    test(
      'taskID matches',
      () => expect(wFSDP.taskID, equals(WFSDX.happyCase['details']['taskID'])),
    );
    test(
      'practiceEvacTaskID matches',
      () => expect(wFSDP.practiceEvacTaskID,
          equals(WFSDX.happyCase['details']['practiceEvacTaskID'])),
    );
    test(
      'typeOfWait matches',
      () => expect(wFSDP.typeOfWait.name,
          equals(WFSDX.happyCase['details']['typeOfWait'])),
    );
    test('.paramsMissing() returns empty',
        () => expect(wFSDP.paramsMissing(), isEmpty));
  });

  group('WaitForStartDetailsPlan.toJson(happyCase)', () {
    // import from example DrillTaskPlanJson using WaitForStartDetailsPlan.fromJson
    final wFSDP = WaitForStartDetailsPlan.fromJson(WFSDX.happyCase);
    // Export to TaskDetailsPlanJson using WaitForStartDetailsPlan.toJson
    final taskDetailsPlanJsonResult = wFSDP.toJson();

    test(
      'taskID matches',
      () => expect(taskDetailsPlanJsonResult['taskID'],
          equals(WFSDX.happyCase['details']['taskID'])),
    );
    test(
      'practiceEvacTaskID matches',
      () => expect(taskDetailsPlanJsonResult['practiceEvacTaskID'],
          equals(WFSDX.happyCase['details']['practiceEvacTaskID'])),
    );
    test(
      'typeOfWait matches',
      () => expect(taskDetailsPlanJsonResult['typeOfWait'],
          equals(WFSDX.happyCase['details']['typeOfWait'])),
    );
  });
}

/// Example JSON inputs for WaitForStartDetailsPlan
class WFSDX {
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
    'taskType': 'waitForStart',
    'title': 'A wait for start task which will never be started 🤷‍♂️',
    'details': {
      // 'taskID': 'exampleID-abc',
      // 'practiceEvacTaskID': null,
    },
  };
  // nullPETid
  static const Map<String, dynamic> nullPETid = {
    'taskID': 'exampleID-abc',
    'taskType': 'waitForStart',
    'title': 'A wait for start task which will never be started 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
      // 'practiceEvacTaskID': null,
    },
  };
  // noWaitType
  static const Map<String, dynamic> noWaitType = {
    'taskID': 'exampleID-abc',
    'taskType': 'waitForStart',
    'title': 'A wait for start task which will never be started 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
      'practiceEvacTaskID': 'exampleID-ghi',
    },
  };
  // happyCase
  static const Map<String, dynamic> happyCase = {
    'taskID': 'exampleID-abc',
    'taskType': 'waitForStart',
    'title': 'A wait for start task which will never be started 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
      'practiceEvacTaskID': 'exampleID-ghi',
      'typeOfWait': 'self',
    },
  };
}
