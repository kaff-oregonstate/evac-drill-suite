import 'package:evac_drill_console/models/survey_step_plans/survey_step_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testScaleQPlan();
}

/// Tests the ScaleQPlan Data Model
void testScaleQPlan() {
  test(
    'ScaleQPlan.fromJson(invalid) throws FormatException',
    () => expect(
        () => ScaleQPlan.fromJson(SQX.invalidCase), throwsFormatException),
  );

  group('ScaleQPlan.fromJson(happyCase)', () {
    // import from example SurveyKitStepJson using ScaleQPlan.fromJson
    final scaleQPlan = ScaleQPlan.fromJson(SQX.happyCase);
    test('title matches',
        () => expect(scaleQPlan.title, equals(SQX.happyCase['title'])));
    test('text matches',
        () => expect(scaleQPlan.text, equals(SQX.happyCase['text'])));
    test(
        'step matches',
        () => expect(
            scaleQPlan.step, equals(SQX.happyCase['answerFormat']['step'])));
    test(
        'minimumValue matches',
        () => expect(scaleQPlan.minimumValue,
            equals(SQX.happyCase['answerFormat']['minimumValue'])));
    test(
        'maximumValue matches',
        () => expect(scaleQPlan.maximumValue,
            equals(SQX.happyCase['answerFormat']['maximumValue'])));
    test(
        'defaultValue matches',
        () => expect(scaleQPlan.defaultValue,
            equals(SQX.happyCase['answerFormat']['defaultValue'])));
    test(
        'minimumValueDescription matches',
        () => expect(scaleQPlan.minimumValueDescription,
            equals(SQX.happyCase['answerFormat']['minimumValueDescription'])));
    test(
        'maximumValueDescription matches',
        () => expect(scaleQPlan.maximumValueDescription,
            equals(SQX.happyCase['answerFormat']['maximumValueDescription'])));
    test('.paramsMissing() returns empty',
        () => expect(scaleQPlan.paramsMissing(), isEmpty));
  });

  group('ScaleQPlan.toJson(happyCase)', () {
    // import from example SurveyKitStepJson using ScaleQPlan.fromJson
    final scaleQPlan = ScaleQPlan.fromJson(SQX.happyCase);
    // Export to SurveyKitStepJson using ScaleQPlan.toJson
    final scaleQJsonResult = scaleQPlan.toJson();

    test(
        'title matches',
        () =>
            expect(scaleQJsonResult['title'], equals(SQX.happyCase['title'])));
    test(
        'answerFormat.type matches',
        () => expect(scaleQJsonResult['answerFormat']['type'],
            equals(SQX.happyCase['answerFormat']['type'])));
    test(
        'answerFormat.step matches',
        () => expect(scaleQJsonResult['answerFormat']['step'],
            equals(SQX.happyCase['answerFormat']['step'])));
    test(
        'answerFormat.minimumValue matches',
        () => expect(scaleQJsonResult['answerFormat']['minimumValue'],
            equals(SQX.happyCase['answerFormat']['minimumValue'])));
    test(
        'answerFormat.maximumValue matches',
        () => expect(scaleQJsonResult['answerFormat']['maximumValue'],
            equals(SQX.happyCase['answerFormat']['maximumValue'])));
    test(
        'answerFormat.defaultValue matches',
        () => expect(scaleQJsonResult['answerFormat']['defaultValue'],
            equals(SQX.happyCase['answerFormat']['defaultValue'])));
    test(
        'answerFormat.minimumValueDescription matches',
        () => expect(
            scaleQJsonResult['answerFormat']['minimumValueDescription'],
            equals(SQX.happyCase['answerFormat']['minimumValueDescription'])));
    test(
        'answerFormat.maximumValueDescription matches',
        () => expect(
            scaleQJsonResult['answerFormat']['maximumValueDescription'],
            equals(SQX.happyCase['answerFormat']['maximumValueDescription'])));
  });

  group('ScaleQPlan.fromJson(iD_noTitle)', () {
    // import from example SurveyKitStepJson using ScaleQPlan.fromJson
    final scaleQPlan = ScaleQPlan.fromJson(SQX.iD_noTitle);

    test(
        'stepID[\'id\'] matches',
        () => expect(scaleQPlan.stepID['id'],
            equals(SQX.iD_noTitle['stepIdentifier']['id'])));

    final missingParams = scaleQPlan.paramsMissing();

    test('.paramsMissing() returns non-Empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 1 missing parameter (title is empty)',
        () => expect(missingParams.length, equals(1)));
  });

  group('ScaleQPlan.fromJson(missingParams)', () {
    // import from example SurveyKitStepJson using ScaleQPlan.fromJson
    final scaleQPlan = ScaleQPlan.fromJson(SQX.missingParams);

    test('stepID[\'id\'] is non-Empty',
        () => expect(scaleQPlan.stepID['id']?.isNotEmpty, equals(true)));
    test('title is null', () => expect(scaleQPlan.title, isNull));
    test('text is empty string (\'\')',
        () => expect(scaleQPlan.text, equals('')));
    test('step is null', () => expect(scaleQPlan.step, isNull));
    test('minimumValue is null', () => expect(scaleQPlan.minimumValue, isNull));
    test('maximumValue is null', () => expect(scaleQPlan.maximumValue, isNull));
    test('defaultValue is null', () => expect(scaleQPlan.defaultValue, isNull));
    test('minimumValueDescription is null',
        () => expect(scaleQPlan.minimumValueDescription, isNull));
    test('maximumValueDescription is null',
        () => expect(scaleQPlan.maximumValueDescription, isNull));

    final missingParams = scaleQPlan.paramsMissing();

    test('.paramsMissing() returns non-Empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 5 missing parameters',
        () => expect(missingParams.length, equals(5)));
  });

  group('ScaleQPlan.toJson(missingParams)', () {
    // import from example SurveyKitStepJson using ScaleQPlan.fromJson
    final scaleQPlan = ScaleQPlan.fromJson(SQX.missingParams);
    // Export to SurveyKitStepJson using ScaleQPlan.toJson
    final scaleQJsonResult = scaleQPlan.toJson();

    test(
        'title matches',
        () => expect(
            scaleQJsonResult['title'], equals(SQX.missingParams['title'])));
    test(
        'answerFormat.type matches',
        () => expect(scaleQJsonResult['answerFormat']['type'],
            equals(SQX.missingParams['answerFormat']['type'])));
    test(
        'answerFormat.step matches',
        () => expect(scaleQJsonResult['answerFormat']['step'],
            equals(SQX.missingParams['answerFormat']['step'])));
    test(
        'answerFormat.minimumValue matches',
        () => expect(scaleQJsonResult['answerFormat']['minimumValue'],
            equals(SQX.missingParams['answerFormat']['minimumValue'])));
    test(
        'answerFormat.maximumValue matches',
        () => expect(scaleQJsonResult['answerFormat']['maximumValue'],
            equals(SQX.missingParams['answerFormat']['maximumValue'])));
    test(
        'answerFormat.defaultValue matches',
        () => expect(scaleQJsonResult['answerFormat']['defaultValue'],
            equals(SQX.missingParams['answerFormat']['defaultValue'])));
    test(
        'answerFormat.minimumValueDescription matches',
        () => expect(
            scaleQJsonResult['answerFormat']['minimumValueDescription'],
            equals(
                SQX.missingParams['answerFormat']['minimumValueDescription'])));
    test(
        'answerFormat.maximumValueDescription matches',
        () => expect(
            scaleQJsonResult['answerFormat']['maximumValueDescription'],
            equals(
                SQX.missingParams['answerFormat']['maximumValueDescription'])));
  });
}

class SQX {
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
      'type': 'scale',
      'step': 1,
      'minimumValue': 1,
      'maximumValue': 5,
      'defaultValue': 3,
      'minimumValueDescription': '1',
      'maximumValueDescription': '5'
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
      'type': 'scale',
      'step': 1,
      'minimumValue': 1,
      'maximumValue': 5,
      'defaultValue': 3,
      'minimumValueDescription': '1',
      'maximumValueDescription': '5'
    },
  };
  static const Map<String, dynamic> missingParams = {
    'type': 'question',
    'answerFormat': {
      'type': 'scale',
    },
  };
}
