import 'package:evac_drill_console/models/task_details_plans/upload_details_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testUploadDetailsPlan();
}

void testUploadDetailsPlan() {
  test(
    'UploadDetailsPlan.fromJson(invalid) throws FormatException',
    () => expect(() => UploadDetailsPlan.fromJson(UDX.invalidCase),
        throwsFormatException),
  );

  test(
    'UploadDetailsPlan.fromJson(null taskID) throws FormatException',
    () => expect(
        () => UploadDetailsPlan.fromJson(UDX.nullID), throwsFormatException),
  );

  group('UploadDetailsPlan.fromJson(happyCase)', () {
    // import from example DrillTaskPlanJson using UploadDetailsPlan.fromJson
    final uDP = UploadDetailsPlan.fromJson(UDX.happyCase);
    test('taskID matches',
        () => expect(uDP.taskID, equals(UDX.happyCase['details']['taskID'])));
    test('.paramsMissing() returns empty',
        () => expect(uDP.paramsMissing(), isEmpty));
  });

  group('UploadDetailsPlan.toJson(happyCase)', () {
    // import from example DrillTaskPlanJson using UploadDetailsPlan.fromJson
    final uDP = UploadDetailsPlan.fromJson(UDX.happyCase);
    // Export to TaskDetailsPlanJson using UploadDetailsPlan.toJson
    final taskDetailsPlanJsonResult = uDP.toJson();

    test(
      'taskID matches',
      () => expect(taskDetailsPlanJsonResult['taskID'],
          equals(UDX.happyCase['details']['taskID'])),
    );
  });
}

/// Example JSON inputs for UploadDetailsPlan
class UDX {
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
    'taskType': 'upload',
    'title': 'An upload task which will never be completed 🤷‍♂️',
    'details': {
      // 'taskID': 'exampleID-abc',
    },
  };
  // happyCase
  static const Map<String, dynamic> happyCase = {
    'taskID': 'exampleID-abc',
    'taskType': 'upload',
    'title': 'An upload task which will never be completed 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
    },
  };
}
