import 'package:evac_drill_console/models/task_details_plans/survey_details_plan.dart';
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

  test(
    'SurveyDetailsPlan.fromJson(null surveyKitJson[\'steps\']) throws FormatException',
    () => expect(
        () => SurveyDetailsPlan.fromJson(SDX.nullList), throwsFormatException),
  );

  // test empty surveySteps list passed into .fromJson
  // test empty case .paramsMissing() {title, surveySteps}
  group('SurveyDetailsPlan.fromJson(emptyListMissingParams)', () {
    // import from example DrillTaskPlanJson using SurveyDetailsPlan.fromJson
    final sDP = SurveyDetailsPlan.fromJson(SDX.emptyListMissingParams);
    test(
      'taskID matches',
      () => expect(
          sDP.taskID, equals(SDX.emptyListMissingParams['details']['taskID'])),
    );
    test(
      'title matches',
      () => expect(
          sDP.title, equals(SDX.emptyListMissingParams['details']['title'])),
    );
    test(
      'surveySteps length matches surveyKitJson[`steps`] length',
      () {
        final stepsList = SDX.emptyListMissingParams['details']['surveyKitJson']
            ['steps'] as List<dynamic>;
        expect(sDP.surveySteps.length, equals(stepsList.length));
      },
    );

    final missingParams = sDP.paramsMissing();
    test('.paramsMissing() is not empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 2',
        () => expect(missingParams.length, equals(2)));
  });

  group('SurveyDetailsPlan.toJson(emptyListMissingParams)', () {
    // import from example DrillTaskPlanJson using SurveyDetailsPlan.fromJson
    final sDP = SurveyDetailsPlan.fromJson(SDX.emptyListMissingParams);
    // Export to TaskDetailsPlanJson using SurveyDetailsPlan.toJson
    final taskDetailsPlanJsonResult = sDP.toJson();

    test(
      'taskID matches',
      () => expect(taskDetailsPlanJsonResult['taskID'],
          equals(SDX.emptyListMissingParams['details']['taskID'])),
    );
    test(
      'title matches',
      () => expect(taskDetailsPlanJsonResult['title'],
          equals(SDX.emptyListMissingParams['details']['title'])),
    );
    test(
      'surveyKitJson matches',
      () => expect(taskDetailsPlanJsonResult['surveyKitJson'],
          equals(SDX.emptyListMissingParams['details']['surveyKitJson'])),
    );
  });

  // test surveySteps having missingParams case .paramsMissing()
  group('SurveyDetailsPlan.fromJson(listMissingParams)', () {
    // import from example DrillTaskPlanJson using SurveyDetailsPlan.fromJson
    final sDP = SurveyDetailsPlan.fromJson(SDX.listMissingParams);
    test(
      'taskID matches',
      () => expect(
          sDP.taskID, equals(SDX.listMissingParams['details']['taskID'])),
    );
    test(
      'title matches',
      () =>
          expect(sDP.title, equals(SDX.listMissingParams['details']['title'])),
    );
    test(
      'surveySteps length matches surveyKitJson[`steps`] length',
      () {
        final stepsList = SDX.listMissingParams['details']['surveyKitJson']
            ['steps'] as List<dynamic>;
        expect(sDP.surveySteps.length, equals(stepsList.length));
      },
    );

    final missingParams = sDP.paramsMissing();
    test('.paramsMissing() is not empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 19',
        () => expect(missingParams.length, equals(19)));
  });

  group('SurveyDetailsPlan.toJson(listMissingParams)', () {
    // import from example DrillTaskPlanJson using SurveyDetailsPlan.fromJson
    final sDP = SurveyDetailsPlan.fromJson(SDX.listMissingParams);
    // Export to TaskDetailsPlanJson using SurveyDetailsPlan.toJson
    final taskDetailsPlanJsonResult = sDP.toJson();

    test(
      'taskID matches',
      () => expect(taskDetailsPlanJsonResult['taskID'],
          equals(SDX.listMissingParams['details']['taskID'])),
    );
    test(
      'title matches',
      () => expect(taskDetailsPlanJsonResult['title'],
          equals(SDX.listMissingParams['details']['title'])),
    );
    test(
      'surveyKitJson matches',
      () => expect(taskDetailsPlanJsonResult['surveyKitJson'],
          equals(SDX.listMissingParams['details']['surveyKitJson'])),
    );
  });

  // test full surveySteps list passed into .fromJson
  group('SurveyDetailsPlan.fromJson(happyCase)', () {
    // import from example DrillTaskPlanJson using SurveyDetailsPlan.fromJson
    final sDP = SurveyDetailsPlan.fromJson(SDX.happyCase);
    test(
      'taskID matches',
      () => expect(sDP.taskID, equals(SDX.happyCase['details']['taskID'])),
    );
    test(
      'title matches',
      () => expect(sDP.title, equals(SDX.happyCase['details']['title'])),
    );
    test(
      'surveySteps length matches surveyKitJson[`steps`] length',
      () {
        final stepsList =
            SDX.happyCase['details']['surveyKitJson']['steps'] as List<dynamic>;
        expect(sDP.surveySteps.length, equals(stepsList.length));
      },
    );

    final missingParams = sDP.paramsMissing();
    test('.paramsMissing() is empty', () => expect(missingParams, isEmpty));
  });

  group('SurveyDetailsPlan.toJson(happyCase)', () {
    // import from example DrillTaskPlanJson using SurveyDetailsPlan.fromJson
    final sDP = SurveyDetailsPlan.fromJson(SDX.happyCase);
    // Export to TaskDetailsPlanJson using SurveyDetailsPlan.toJson
    final taskDetailsPlanJsonResult = sDP.toJson();

    test(
      'taskID matches',
      () => expect(taskDetailsPlanJsonResult['taskID'],
          equals(SDX.happyCase['details']['taskID'])),
    );
    test(
      'title matches',
      () => expect(taskDetailsPlanJsonResult['title'],
          equals(SDX.happyCase['details']['title'])),
    );
    test(
      'surveyKitJson matches',
      () => expect(taskDetailsPlanJsonResult['surveyKitJson'],
          equals(SDX.happyCase['details']['surveyKitJson'])),
    );
  });
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
      'taskID': null,
      // 'surveyKitJson': null,
    },
  };
  // nullList
  static const Map<String, dynamic> nullList = {
    'taskID': 'exampleID-abc',
    'taskType': 'survey',
    'title': 'A survey which will never be taken 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
      // 'title': null,
      'surveyKitJson': {
        // 'id': null,
        'type': 'navigable',
        // 'steps': null,
      },
    },
  };
  // emptyListMissingParams
  static const Map<String, dynamic> emptyListMissingParams = {
    'taskID': 'exampleID-abc',
    'taskType': 'survey',
    'title': 'A survey which will never be taken 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
      'title': '',
      'surveyKitJson': {
        'id': '',
        'type': 'navigable',
        'steps': [],
      },
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
      'surveyKitJson': {
        'id': 'Example Survey Title',
        'type': 'navigable',
        'steps': [
          {
            'stepIdentifier': {'id': 'eee'},
            'type': 'intro',
            'title': '',
            'text': 'example step text',
          },
          {
            'stepIdentifier': {'id': 'eee'},
            'type': 'question',
            'title': null,
            'text': 'example bool step text',
            'answerFormat': {
              'type': 'bool',
              'positiveAnswer': null,
              'negativeAnswer': null,
              'result': 'POSITIVE',
            },
          },
          {
            'stepIdentifier': {'id': 'eee'},
            'type': 'question',
            'title': null,
            'text': 'example step text',
            'answerFormat': {
              'type': 'date',
              'minDate': null,
              'maxDate': null,
              'defaultDate': null,
            }
          },
          {
            'stepIdentifier': {'id': 'eee'},
            'type': 'question',
            'title': null,
            'text': 'example step text',
            'answerFormat': {
              'type': 'integer',
              'hint': null,
            }
          },
          {
            'stepIdentifier': {'id': 'eee'},
            'type': 'question',
            'title': null,
            'text': 'example step text',
            'answerFormat': {
              'type': 'scale',
              'step': null,
              'minimumValue': null,
              'maximumValue': null,
              'defaultValue': null,
              'minimumValueDescription': null,
              'maximumValueDescription': null,
            }
          },
          {
            'stepIdentifier': {'id': 'eee'},
            'type': 'question',
            'title': null,
            'text': 'example step text',
            'answerFormat': {
              'type': 'single',
              'textChoices': [
                {'text': null, 'value': 'Yes'},
                {'text': null, 'value': 'No'}
              ],
            }
          },
          {
            'stepIdentifier': {'id': 'eee'},
            'type': 'question',
            'title': null,
            'text': 'example step text',
            'answerFormat': {
              'type': 'text',
              'maxLines': null,
            }
          },
          {
            'stepIdentifier': {'id': 'eee'},
            'type': 'completion',
            'title': null,
            'text': 'example step text',
            'buttonText': 'Submit survey'
          },
        ],
      },
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
      'surveyKitJson': {
        'id': 'Example Survey Title',
        'type': 'navigable',
        'steps': [
          {
            'stepIdentifier': {'id': 'eee'},
            'type': 'intro',
            'title': 'An example title text',
            'text': 'example step text',
          },
          {
            'stepIdentifier': {'id': 'eee'},
            'type': 'question',
            'title': 'Is this a survey?',
            'text': 'example bool step text',
            'answerFormat': {
              'type': 'bool',
              'positiveAnswer': 'Yes',
              'negativeAnswer': 'No',
              'result': 'POSITIVE',
            },
          },
          {
            'stepIdentifier': {'id': 'eee'},
            'type': 'question',
            'title': 'An example title text',
            'text': 'example step text',
            'answerFormat': {
              'type': 'date',
              'minDate': '2015-06-25T04:08:16.000Z',
              'maxDate': '2025-06-25T04:08:16.000Z',
              'defaultDate': '2021-06-25T04:08:16.000Z',
            }
          },
          {
            'stepIdentifier': {'id': 'eee'},
            'type': 'question',
            'title': 'An example title text',
            'text': 'example step text',
            'answerFormat': {
              'type': 'integer',
              'hint': null,
            }
          },
          {
            'stepIdentifier': {'id': 'eee'},
            'type': 'question',
            'title': 'An example title text',
            'text': 'example step text',
            'answerFormat': {
              'type': 'scale',
              'step': 0.1,
              'minimumValue': 0.0,
              'maximumValue': 5.0,
              'defaultValue': 2.5,
              'minimumValueDescription': 'zero',
              'maximumValueDescription': 'five'
            }
          },
          {
            'stepIdentifier': {'id': 'eee'},
            'type': 'question',
            'title': 'An example title text',
            'text': 'example step text',
            'answerFormat': {
              'type': 'single',
              'textChoices': [
                {'text': 'Yes', 'value': 'Yes'},
                {'text': 'No', 'value': 'No'}
              ],
            }
          },
          {
            'stepIdentifier': {'id': 'eee'},
            'type': 'question',
            'title': 'An example title text',
            'text': 'example step text',
            'answerFormat': {
              'type': 'text',
              'maxLines': 5,
            }
          },
          {
            'stepIdentifier': {'id': 'eee'},
            'type': 'completion',
            'title': 'An example title text',
            'text': 'example step text',
            'buttonText': 'Submit survey'
          },
        ],
      },
    },
  };
}
