import 'package:evac_drill_console/models/survey_step_plans/survey_step_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testIntQPlan();
}

/// Tests the IntQPlan Data Model
void testIntQPlan() {
  test(
    'IntQPlan.fromJson(invalid) throws FormatException',
    () =>
        expect(() => IntQPlan.fromJson(IQX.invalidCase), throwsFormatException),
  );

  group('IntQPlan.fromJson(happyCase)', () {
    // import from example SurveyKitStepJson using IntQPlan.fromJson
    final intQPlan = IntQPlan.fromJson(IQX.happyCase);
    test('title matches',
        () => expect(intQPlan.title, equals(IQX.happyCase['title'])));
    test('text matches',
        () => expect(intQPlan.text, equals(IQX.happyCase['text'])));
    test(
        'hint matches',
        () => expect(
            intQPlan.hint, equals(IQX.happyCase['answerFormat']['hint'])));
    test('.paramsMissing() returns empty',
        () => expect(intQPlan.paramsMissing(), isEmpty));
  });

  group('IntQPlan.toJson(happyCase)', () {
    // import from example SurveyKitStepJson using IntQPlan.fromJson
    final intQPlan = IntQPlan.fromJson(IQX.happyCase);
    // Export to SurveyKitStepJson using IntQPlan.toJson
    final intQJsonResult = intQPlan.toJson();

    test('title matches',
        () => expect(intQJsonResult['title'], equals(IQX.happyCase['title'])));
    test(
        'answerFormat.type matches',
        () => expect(intQJsonResult['answerFormat']['type'],
            equals(IQX.happyCase['answerFormat']['type'])));
    test(
        'answerFormat.hint matches',
        () => expect(intQJsonResult['answerFormat']['hint'],
            equals(IQX.happyCase['answerFormat']['hint'])));
  });

  group('IntQPlan.fromJson(iD_noTitle)', () {
    // import from example SurveyKitStepJson using IntQPlan.fromJson
    final intQPlan = IntQPlan.fromJson(IQX.iD_noTitle);

    test(
        'stepID[\'id\'] matches',
        () => expect(intQPlan.stepID['id'],
            equals(IQX.iD_noTitle['stepIdentifier']['id'])));

    final missingParams = intQPlan.paramsMissing();

    test('.paramsMissing() returns non-Empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 1 missing parameter (title is empty)',
        () => expect(missingParams.length, equals(1)));
  });

  group('IntQPlan.fromJson(missingParams)', () {
    // import from example SurveyKitStepJson using IntQPlan.fromJson
    final intQPlan = IntQPlan.fromJson(IQX.missingParams);

    test('stepID[\'id\'] is non-Empty',
        () => expect(intQPlan.stepID['id']?.isNotEmpty, equals(true)));
    test('title is null', () => expect(intQPlan.title, isNull));
    test('hint is null', () => expect(intQPlan.hint, isNull));
    test(
        'text is empty string (\'\')', () => expect(intQPlan.text, equals('')));

    final missingParams = intQPlan.paramsMissing();

    test('.paramsMissing() returns non-Empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 1 missing parameter (only title required)',
        () => expect(missingParams.length, equals(1)));
  });

  group('IntQPlan.toJson(missingParams)', () {
    // import from example SurveyKitStepJson using IntQPlan.fromJson
    final intQPlan = IntQPlan.fromJson(IQX.missingParams);
    // Export to SurveyKitStepJson using IntQPlan.toJson
    final intQJsonResult = intQPlan.toJson();

    test(
        'title matches',
        () => expect(
            intQJsonResult['title'], equals(IQX.missingParams['title'])));
    test(
        'answerFormat.type matches',
        () => expect(intQJsonResult['answerFormat']['type'],
            equals(IQX.missingParams['answerFormat']['type'])));
    test(
        'answerFormat.hint matches',
        () => expect(intQJsonResult['answerFormat']['hint'],
            equals(IQX.missingParams['answerFormat']['hint'])));
  });
}

class IQX {
  static const Map<String, dynamic> invalidCase = {
    'type': 'question',
    'title': 'Example question title',
    'text': 'example text',
    'answerFormat': {
      'type': 'date',
      'minDate': '2015-06-25T04:08:16Z',
      'maxDate': '2025-06-25T04:08:16Z',
      'defaultDate': '2021-06-25T04:08:16Z',
    },
  };
  static const Map<String, dynamic> happyCase = {
    'type': 'question',
    'title': 'Example question title',
    'text': 'example text',
    'answerFormat': {
      'type': 'integer',
      'hint': 'Please enter your social security number 🦾',
    },
  };
  // ignore: constant_identifier_names
  static const Map<String, dynamic> iD_noTitle = {
    'type': 'question',
    'stepIdentifier': {
      'id': 'absdcdasfasdf',
    },
    'answerFormat': {
      'type': 'integer',
      'hint': 'Please enter your social security number 🦾',
    },
  };
  static const Map<String, dynamic> missingParams = {
    'type': 'question',
    'answerFormat': {
      'type': 'integer',
    },
  };
}
