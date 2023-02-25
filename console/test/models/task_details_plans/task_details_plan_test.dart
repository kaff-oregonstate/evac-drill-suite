// ignore: unused_import
import 'package:flutter_test/flutter_test.dart';

void main() {
  testTaskDetailsPlan();
}

void testTaskDetailsPlan() {
  // test bad formatting passed into .fromJson to confirm throwFormatException

  // test each type of TaskDetailsPlan passed into .fromJson to confirm type
  // model after SSPX.validCases
}

/// Example JSON inputs for TaskDetailsPlan
class TDX {
  // invalidCase
  static const Map<String, dynamic> invalidCase = {
    'taskID': 'exampleID-abc',
    'taskType': 'survey',
    'title': 'A survey which will never be taken 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
    },
  };
  // validCases
  // // static const Map<DrillTaskType, Map<String, dynamic>> validCases = {}
  // types
  // // static const Map<DrillTaskType, Type> types = {
  // //   DrillTaskType.survey: SurveyDetailsPlan,
  // // };
}
