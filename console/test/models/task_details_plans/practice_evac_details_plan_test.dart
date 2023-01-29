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

  // test empty actions list passed into .fromJson

  // test empty case .paramsMissing()

  // test invalid actions list passed into .fromJson

  // test actions having missingParams case .paramsMissing()

  // test full actions list passed into .fromJson
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
      // 'actions': null,
    },
  };
  // actionsEmptyMissingParams
  static const Map<String, dynamic> actionsEmptyMissingParams = {
    'taskID': 'exampleID-abc',
    'taskType': 'practiceEvac',
    // 'title': 'A practice evacuation which will never be taken 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
      'title': '',
      'actions': [],
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
      // TODO: Implement actions with only `instructions`
      'actions': [],
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
      // TODO: Implement valid actions with missing params
      'actions': [],
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
      // TODO: Implement actions happyCase
      'actions': [],
    },
  };
}
