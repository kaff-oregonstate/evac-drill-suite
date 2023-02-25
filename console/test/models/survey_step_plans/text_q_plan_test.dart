import 'package:evac_drill_console/models/survey_step_plans/survey_step_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testTextQPlan();
}

/// Tests the TextQPlan Data Model
void testTextQPlan() {
  test(
    'TextQPlan.fromJson(invalid) throws FormatException',
    () => expect(
        () => TextQPlan.fromJson(TQX.invalidCase), throwsFormatException),
  );

  group('TextQPlan.fromJson(happyCase)', () {
    // import from example SurveyKitStepJson using TextQPlan.fromJson
    final textQPlan = TextQPlan.fromJson(TQX.happyCase);
    test('title matches',
        () => expect(textQPlan.title, equals(TQX.happyCase['title'])));
    test('text matches',
        () => expect(textQPlan.text, equals(TQX.happyCase['text'])));
    test(
        'maxLines matches',
        () => expect(textQPlan.maxLines,
            equals(TQX.happyCase['answerFormat']['maxLines'])));
    test('.paramsMissing() returns empty',
        () => expect(textQPlan.paramsMissing(), isEmpty));
  });

  group('TextQPlan.toJson(happyCase)', () {
    // import from example SurveyKitStepJson using TextQPlan.fromJson
    final textQPlan = TextQPlan.fromJson(TQX.happyCase);
    // Export to SurveyKitStepJson using TextQPlan.toJson
    final textQJsonResult = textQPlan.toJson();

    test('title matches',
        () => expect(textQJsonResult['title'], equals(TQX.happyCase['title'])));
    test(
        'answerFormat.type matches',
        () => expect(textQJsonResult['answerFormat']['type'],
            equals(TQX.happyCase['answerFormat']['type'])));
    test(
        'answerFormat.maxLines matches',
        () => expect(textQJsonResult['answerFormat']['maxLines'],
            equals(TQX.happyCase['answerFormat']['maxLines'])));
  });

  group('TextQPlan.fromJson(iD_noTitle)', () {
    // import from example SurveyKitStepJson using TextQPlan.fromJson
    final textQPlan = TextQPlan.fromJson(TQX.iD_noTitle);

    test(
        'stepID[\'id\'] matches',
        () => expect(textQPlan.stepID['id'],
            equals(TQX.iD_noTitle['stepIdentifier']['id'])));

    final missingParams = textQPlan.paramsMissing();

    test('.paramsMissing() returns non-Empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 1 missing parameter (title is empty)',
        () => expect(missingParams.length, equals(1)));
  });

  group('TextQPlan.fromJson(missingParams)', () {
    // import from example SurveyKitStepJson using TextQPlan.fromJson
    final textQPlan = TextQPlan.fromJson(TQX.missingParams);

    test('stepID[\'id\'] is non-Empty',
        () => expect(textQPlan.stepID['id']?.isNotEmpty, equals(true)));
    test('title is null', () => expect(textQPlan.title, isNull));
    test('text is empty string (\'\')',
        () => expect(textQPlan.text, equals('')));
    test('maxLines is null', () => expect(textQPlan.maxLines, isNull));

    final missingParams = textQPlan.paramsMissing();

    test('.paramsMissing() returns non-Empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 1 missing parameter',
        () => expect(missingParams.length, equals(1)));
  });

  group('TextQPlan.toJson(missingParams)', () {
    // import from example SurveyKitStepJson using TextQPlan.fromJson
    final textQPlan = TextQPlan.fromJson(TQX.missingParams);
    // Export to SurveyKitStepJson using TextQPlan.toJson
    final textQJsonResult = textQPlan.toJson();

    test(
        'title matches',
        () => expect(
            textQJsonResult['title'], equals(TQX.missingParams['title'])));
    test(
        'answerFormat.type matches',
        () => expect(textQJsonResult['answerFormat']['type'],
            equals(TQX.missingParams['answerFormat']['type'])));
    test(
        'answerFormat.maxLines matches',
        () => expect(textQJsonResult['answerFormat']['maxLines'],
            equals(TQX.missingParams['answerFormat']['maxLines'])));
  });
}

class TQX {
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
      'type': 'text',
      'maxLines': 5,
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
      'type': 'text',
      'maxLines': 5,
    },
  };
  static const Map<String, dynamic> missingParams = {
    'type': 'question',
    'answerFormat': {
      'type': 'text',
    },
  };
}
