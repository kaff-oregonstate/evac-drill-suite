import 'package:evac_drill_console/models/survey_step_plans/survey_step_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testSingleChoiceQPlan();
}

/// Tests the SingleChoiceQPlan Data Model
void testSingleChoiceQPlan() {
  test(
    'SingleChoiceQPlan.fromJson(invalid) throws FormatException',
    () => expect(() => SingleChoiceQPlan.fromJson(SCQX.invalidCase),
        throwsFormatException),
  );

  group('SingleChoiceQPlan.fromJson(happyCase)', () {
    // import from example SurveyKitStepJson using SingleChoiceQPlan.fromJson
    final singleChoiceQPlan = SingleChoiceQPlan.fromJson(SCQX.happyCase);
    test('title matches',
        () => expect(singleChoiceQPlan.title, equals(SCQX.happyCase['title'])));
    test('text matches',
        () => expect(singleChoiceQPlan.text, equals(SCQX.happyCase['text'])));
    test(
        'yesChoice matches',
        () => expect(singleChoiceQPlan.yesChoice,
            equals(SCQX.happyCase['answerFormat']['textChoices']?[0]['text'])));
    test(
        'noChoice matches',
        () => expect(singleChoiceQPlan.noChoice,
            equals(SCQX.happyCase['answerFormat']['textChoices']?[1]['text'])));
    test('.paramsMissing() returns empty',
        () => expect(singleChoiceQPlan.paramsMissing(), isEmpty));
  });

  group('SingleChoiceQPlan.toJson(happyCase)', () {
    // import from example SurveyKitStepJson using SingleChoiceQPlan.fromJson
    final singleChoiceQPlan = SingleChoiceQPlan.fromJson(SCQX.happyCase);
    // Export to SurveyKitStepJson using SingleChoiceQPlan.toJson
    final singleChoiceQJsonResult = singleChoiceQPlan.toJson();

    test(
        'title matches',
        () => expect(
            singleChoiceQJsonResult['title'], equals(SCQX.happyCase['title'])));
    test(
        'answerFormat.type matches',
        () => expect(singleChoiceQJsonResult['answerFormat']['type'],
            equals(SCQX.happyCase['answerFormat']['type'])));
    test(
        'answerFormat.textChoices[0].text matches',
        () => expect(
            singleChoiceQJsonResult['answerFormat']['textChoices']?[0]['text'],
            equals(SCQX.happyCase['answerFormat']['textChoices']?[0]['text'])));
    test(
        'answerFormat.textChoices[1].text matches',
        () => expect(
            singleChoiceQJsonResult['answerFormat']['textChoices']?[1]['text'],
            equals(SCQX.happyCase['answerFormat']['textChoices']?[1]['text'])));
  });

  group('SingleChoiceQPlan.fromJson(iD_noTitle)', () {
    // import from example SurveyKitStepJson using SingleChoiceQPlan.fromJson
    final singleChoiceQPlan = SingleChoiceQPlan.fromJson(SCQX.iD_noTitle);

    test(
        'stepID[\'id\'] matches',
        () => expect(singleChoiceQPlan.stepID['id'],
            equals(SCQX.iD_noTitle['stepIdentifier']['id'])));

    final missingParams = singleChoiceQPlan.paramsMissing();

    test('.paramsMissing() returns non-Empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 1 missing parameter (title is empty)',
        () => expect(missingParams.length, equals(1)));
  });

  group('SingleChoiceQPlan.fromJson(missingParams)', () {
    // import from example SurveyKitStepJson using SingleChoiceQPlan.fromJson
    final singleChoiceQPlan = SingleChoiceQPlan.fromJson(SCQX.missingParams);

    test('stepID[\'id\'] is non-Empty',
        () => expect(singleChoiceQPlan.stepID['id']?.isNotEmpty, equals(true)));
    test('title is null', () => expect(singleChoiceQPlan.title, isNull));
    test('text is empty string (\'\')',
        () => expect(singleChoiceQPlan.text, equals('')));
    test(
        'yesChoice is null', () => expect(singleChoiceQPlan.yesChoice, isNull));
    test('noChoice is null', () => expect(singleChoiceQPlan.noChoice, isNull));

    final missingParams = singleChoiceQPlan.paramsMissing();

    test('.paramsMissing() returns non-Empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 3 missing parameters',
        () => expect(missingParams.length, equals(3)));
  });

  group('SingleChoiceQPlan.toJson(missingParams)', () {
    // import from example SurveyKitStepJson using SingleChoiceQPlan.fromJson
    final singleChoiceQPlan = SingleChoiceQPlan.fromJson(SCQX.missingParams);
    // Export to SurveyKitStepJson using SingleChoiceQPlan.toJson
    final singleChoiceQJsonResult = singleChoiceQPlan.toJson();

    test(
        'title matches',
        () => expect(singleChoiceQJsonResult['title'],
            equals(SCQX.missingParams['title'])));
    test(
        'answerFormat.type matches',
        () => expect(singleChoiceQJsonResult['answerFormat']['type'],
            equals(SCQX.missingParams['answerFormat']['type'])));
    test(
        'answerFormat.textChoices[0].text matches',
        () => expect(
            singleChoiceQJsonResult['answerFormat']['textChoices']?[0]['text'],
            equals(SCQX.missingParams['answerFormat']['textChoices']?[0]
                ['text'])));
    test(
        'answerFormat.textChoices[1].text matches',
        () => expect(
            singleChoiceQJsonResult['answerFormat']['textChoices']?[1]['text'],
            equals(SCQX.missingParams['answerFormat']['textChoices']?[1]
                ['text'])));
  });
}

class SCQX {
  static const Map<String, dynamic> invalidCase = {
    'type': 'question',
    'title': 'Example question title',
    'text': 'example text',
    'answerFormat': {
      'type': 'integer',
      'hint': 'This question will never be asked 🤪',
    },
  };
  static const Map<String, dynamic> happyCase = {
    'type': 'question',
    'title': 'Example question title',
    'text': 'example text',
    'answerFormat': {
      'type': 'single',
      'textChoices': [
        {'text': 'Yes', 'value': 'Yes'},
        {'text': 'No', 'value': 'No'}
      ]
    },
  };
  // ignore: constant_identifier_names
  static const Map<String, dynamic> iD_noTitle = {
    'type': 'question',
    'title': '',
    'stepIdentifier': {
      'id': 'absdcdasfasdf',
    },
    'answerFormat': {
      'type': 'single',
      'textChoices': [
        {'text': 'Yes', 'value': 'Yes'},
        {'text': 'No', 'value': 'No'}
      ],
    },
  };
  static const Map<String, dynamic> missingParams = {
    'type': 'question',
    'answerFormat': {
      'type': 'single',
    },
  };
}
