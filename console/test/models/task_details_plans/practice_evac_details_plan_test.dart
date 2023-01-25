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

  // test null instructions list passed into .fromJson

  // test empty instructions list passed into .fromJson

  // test empty case .paramsMissing()

  // test instructions having missingParams case .paramsMissing()

  // test full instructions list passed into .fromJson
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
      // 'taskID': 'exampleID-abc',
    },
  };
  // nullList
  static const Map<String, dynamic> nullList = {
    'taskID': 'exampleID-abc',
    'taskType': 'practiceEvac',
    'title': 'A practice evacuation which will never be taken 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
      // 'instructionsJson': null,
    },
  };
  // emptyListMissingParams
  static const Map<String, dynamic> emptyListMissingParams = {
    'taskID': 'exampleID-abc',
    'taskType': 'practiceEvac',
    'title': 'A practice evacuation which will never be taken 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
      'title': '',
      'instructionsJson': [],
    },
  };
  // listMissingParams
  static const Map<String, dynamic> listMissingParams = {
    'taskID': 'exampleID-abc',
    'taskType': 'practiceEvac',
    'title': 'A practice evacuation which will never be taken 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
      'title': 'An Example Practice Evacuation Title',
      // TODO: Implement instructionsJson with missing params
      'instructionsJson': [],
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
      // TODO: Implement instructionsJson happyCase
      'instructionsJson': [],
    },
  };
}
