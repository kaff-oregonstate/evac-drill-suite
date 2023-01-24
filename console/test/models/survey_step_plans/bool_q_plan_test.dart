import 'package:evac_drill_console/models/survey_step_plans/survey_step_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testBoolQPlan();
}

/// Tests the BoolQPlan Data Model
void testBoolQPlan() {
  test(
    'BoolQPlan.fromJson(invalid) throws FormatException',
    () => expect(
        () => BoolQPlan.fromJson(BQX.invalidCase), throwsFormatException),
  );

  group('BoolQPlan.fromJson(happyCase)', () {
    // import from example SurveyKitStepJson using BoolQPlan.fromJson
    final boolQPlan = BoolQPlan.fromJson(BQX.happyCase);
    test('title matches',
        () => expect(boolQPlan.title, equals(BQX.happyCase['title'])));
    test('text matches',
        () => expect(boolQPlan.text, equals(BQX.happyCase['text'])));
    test(
        'positiveAnswer matches',
        () => expect(boolQPlan.positiveAnswer,
            equals(BQX.happyCase['answerFormat']['positiveAnswer'])));
    test(
        'negativeAnswer matches',
        () => expect(boolQPlan.negativeAnswer,
            equals(BQX.happyCase['answerFormat']['negativeAnswer'])));
    test('.paramsMissing() returns empty',
        () => expect(boolQPlan.paramsMissing(), isEmpty));
  });

  group('BoolQPlan.toJson(happyCase)', () {
    // import from example SurveyKitStepJson using BoolQPlan.fromJson
    final boolQPlan = BoolQPlan.fromJson(BQX.happyCase);
    // Export to SurveyKitStepJson using BoolQPlan.toJson
    final boolStepJsonResult = boolQPlan.toJson();

    test(
        'title matches',
        () => expect(
            boolStepJsonResult['title'], equals(BQX.happyCase['title'])));
    test(
        'answerFormat.type matches',
        () => expect(boolStepJsonResult['answerFormat']['type'],
            equals(BQX.happyCase['answerFormat']['type'])));
    test(
        'answerFormat.positiveAnswer matches',
        () => expect(boolStepJsonResult['answerFormat']['positiveAnswer'],
            equals(BQX.happyCase['answerFormat']['positiveAnswer'])));
    test(
        'answerFormat.negativeAnswer matches',
        () => expect(boolStepJsonResult['answerFormat']['negativeAnswer'],
            equals(BQX.happyCase['answerFormat']['negativeAnswer'])));
    test(
        'answerFormat.result matches',
        () => expect(boolStepJsonResult['answerFormat']['result'],
            equals(BQX.happyCase['answerFormat']['result'])));
  });

  group('BoolQPlan.fromJson(iD_noTitle)', () {
    // import from example SurveyKitStepJson using BoolQPlan.fromJson
    final boolQPlan = BoolQPlan.fromJson(BQX.iD_noTitle);

    test(
        'stepID[\'id\'] matches',
        () => expect(boolQPlan.stepID['id'],
            equals(BQX.iD_noTitle['stepIdentifier']['id'])));

    final missingParams = boolQPlan.paramsMissing();

    test('.paramsMissing() returns non-Empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 1 missing parameter (title is empty)',
        () => expect(missingParams.length, equals(1)));
  });

  group('BoolQPlan.fromJson(missingParams)', () {
    // import from example SurveyKitStepJson using BoolQPlan.fromJson
    final boolQPlan = BoolQPlan.fromJson(BQX.missingParams);

    test('stepID[\'id\'] is non-Empty',
        () => expect(boolQPlan.stepID['id']?.isNotEmpty, equals(true)));
    test('title is null', () => expect(boolQPlan.title, isNull));
    test('text is empty string (\'\')',
        () => expect(boolQPlan.text, equals('')));
    test('positiveAnswer is null',
        () => expect(boolQPlan.positiveAnswer, isNull));
    test('negativeAnswer is null',
        () => expect(boolQPlan.negativeAnswer, isNull));

    final missingParams = boolQPlan.paramsMissing();

    test('.paramsMissing() returns non-Empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 3 missing parameters',
        () => expect(missingParams.length, equals(3)));
  });

  group('BoolQPlan.toJson(missingParams)', () {
    // import from example SurveyKitStepJson using BoolQPlan.fromJson
    final boolQPlan = BoolQPlan.fromJson(BQX.missingParams);
    // Export to SurveyKitStepJson using BoolQPlan.toJson
    final boolStepJsonResult = boolQPlan.toJson();

    test(
        'title matches',
        () => expect(
            boolStepJsonResult['title'], equals(BQX.missingParams['title'])));
    test(
        'answerFormat.type matches',
        () => expect(boolStepJsonResult['answerFormat']['type'],
            equals(BQX.missingParams['answerFormat']['type'])));
    test(
        'answerFormat.positiveAnswer matches',
        () => expect(boolStepJsonResult['answerFormat']['positiveAnswer'],
            equals(BQX.missingParams['answerFormat']['positiveAnswer'])));
    test(
        'answerFormat.negativeAnswer matches',
        () => expect(boolStepJsonResult['answerFormat']['negativeAnswer'],
            equals(BQX.missingParams['answerFormat']['negativeAnswer'])));
    test(
        'answerFormat.result matches',
        () => expect(
            boolStepJsonResult['answerFormat']['result'], equals('POSITIVE')));
  });
}

/// Example JSON inputs for BoolQPlan
class BQX {
  static const Map<String, dynamic> invalidCase = {
    'type': 'question',
    'title': 'How many surveys is this?',
    'text': 'example int step text',
    'answerFormat': {
      'type': 'integer',
      'hint': 'This question will never be asked 🤪',
    },
  };
  static const Map<String, dynamic> happyCase = {
    'type': 'question',
    'title': 'Is this a survey?',
    'text': 'example bool step text',
    'answerFormat': {
      'type': 'bool',
      'positiveAnswer': 'Yes',
      'negativeAnswer': 'No',
      'result': 'POSITIVE',
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
      'type': 'bool',
      'positiveAnswer': 'Yes',
      'negativeAnswer': 'No',
      'result': 'POSITIVE',
    },
  };
  static const Map<String, dynamic> missingParams = {
    'type': 'question',
    'answerFormat': {
      'type': 'bool',
    },
  };
}
