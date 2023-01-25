import 'package:evac_drill_console/models/task_details_plans/survey_details_plan.dart';

import '../survey_step_plans/survey_step_plan_test.dart' show SSPX;
import 'package:flutter_test/flutter_test.dart';

void main() {
  testSurveyDetailsPlan();
}

void testSurveyDetailsPlan() {
  test(
    'SurveyDetailsPlan.fromJson(invalid) throws FormatException',
    () => expect(() => SurveyDetailsPlan.fromJson(SDX.invalidCase),
        throwsFormatException),
  );

  test(
    'SurveyDetailsPlan.fromJson(null taskID) throws FormatException',
    () => expect(
        () => SurveyDetailsPlan.fromJson(SDX.nullID), throwsFormatException),
  );

  // test null surveySteps list passed into .fromJson

  // test empty surveySteps list passed into .fromJson
  // test empty case .paramsMissing() {title, surveySteps}

  // test surveySteps having missingParams case .paramsMissing()

  // test full surveySteps list passed into .fromJson
}

/// Example JSON inputs for SurveyDetailsPlan
class SDX {
  // invalidCase
  static const Map<String, dynamic> invalidCase = {
    'taskID': 'exampleID-abc',
    'taskType': 'reqLocPerms',
    'title': 'A location permissions request which will never be asked 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
    },
  };
  // nullID
  static const Map<String, dynamic> nullID = {
    'taskID': 'exampleID-abc',
    'taskType': 'survey',
    'title': 'A survey which will never be taken 🤷‍♂️',
    'details': {
      // 'taskID': 'exampleID-abc',
    },
  };
  // nullList
  static const Map<String, dynamic> nullList = {
    'taskID': 'exampleID-abc',
    'taskType': 'survey',
    'title': 'A survey which will never be taken 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
      // 'surveyKitJson': null,
    },
  };
  // emptyListMissingParams
  static const Map<String, dynamic> emptyList = {
    'taskID': 'exampleID-abc',
    'taskType': 'survey',
    'title': 'A survey which will never be taken 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
      'title': '',
      'surveyKitJson': [],
    },
  };
  // listMissingParams
  static const Map<String, dynamic> listMissingParams = {
    'taskID': 'exampleID-abc',
    'taskType': 'survey',
    'title': 'A survey which will never be taken 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
      'title': 'Example Survey Title',
      // TODO: Implement surveyKitJson with missingParams
      'surveyKitJson': [],
    },
  };
  // happyCase
  static const Map<String, dynamic> happyCase = {
    'taskID': 'exampleID-abc',
    'taskType': 'survey',
    'title': 'A survey which will never be taken 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
      'title': 'Example Survey Title',
      // TODO: Implement happyCase surveyKitJson
      // build from SSPX.validCases
      'surveyKitJson': [],
    },
  };
}
