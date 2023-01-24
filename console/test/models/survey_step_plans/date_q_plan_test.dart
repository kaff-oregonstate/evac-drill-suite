import 'package:evac_drill_console/models/survey_step_plans/survey_step_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testDateQPlan();
}

/// Tests the DateQPlan Data Model
void testDateQPlan() {
  test(
    'DateQPlan.fromJson(invalid) throws FormatException',
    () => expect(
        () => DateQPlan.fromJson(DQX.invalidCase), throwsFormatException),
  );

  group('DateQPlan.fromJson(happyCase)', () {
    // import from example SurveyKitStepJson using DateQPlan.fromJson
    final dateQPlan = DateQPlan.fromJson(DQX.happyCase);
    test('title matches',
        () => expect(dateQPlan.title, equals(DQX.happyCase['title'])));
    test('text matches',
        () => expect(dateQPlan.text, equals(DQX.happyCase['text'])));
    test(
        'minDate matches',
        () => expect(dateQPlan.minDate,
            equals(DateTime.parse(DQX.happyCase['answerFormat']['minDate']))));
    test(
        'maxDate matches',
        () => expect(dateQPlan.maxDate,
            equals(DateTime.parse(DQX.happyCase['answerFormat']['maxDate']))));
    test(
        'defaultDate matches',
        () => expect(
            dateQPlan.defaultDate,
            equals(
                DateTime.parse(DQX.happyCase['answerFormat']['defaultDate']))));
    test('.paramsMissing() returns empty',
        () => expect(dateQPlan.paramsMissing(), isEmpty));
  });

  group('DateQPlan.toJson(happyCase)', () {
    // import from example SurveyKitStepJson using DateQPlan.fromJson
    final dateQPlan = DateQPlan.fromJson(DQX.happyCase);
    // Export to SurveyKitStepJson using DateQPlan.toJson
    final dateQJsonResult = dateQPlan.toJson();

    test('title matches',
        () => expect(dateQJsonResult['title'], equals(DQX.happyCase['title'])));
    test(
        'answerFormat.minDate results in matching DateTimes',
        () => expect(DateTime.parse(dateQJsonResult['answerFormat']['minDate']),
            equals(DateTime.parse(DQX.happyCase['answerFormat']['minDate']))));
    test(
        'answerFormat.maxDate results in matching DateTimes',
        () => expect(DateTime.parse(dateQJsonResult['answerFormat']['maxDate']),
            equals(DateTime.parse(DQX.happyCase['answerFormat']['maxDate']))));
    test(
        'answerFormat.defaultDate results in matching DateTimes',
        () => expect(
            DateTime.parse(dateQJsonResult['answerFormat']['defaultDate']),
            equals(
                DateTime.parse(DQX.happyCase['answerFormat']['defaultDate']))));
    test(
        'answerFormat.type matches',
        () => expect(dateQJsonResult['answerFormat']['type'],
            equals(DQX.happyCase['answerFormat']['type'])));
  });

  group('DateQPlan.fromJson(iD_noTitle)', () {
    // import from example SurveyKitStepJson using DateQPlan.fromJson
    final dateQPlan = DateQPlan.fromJson(DQX.iD_noTitle);

    test(
        'stepID[\'id\'] matches',
        () => expect(dateQPlan.stepID['id'],
            equals(DQX.iD_noTitle['stepIdentifier']['id'])));

    final missingParams = dateQPlan.paramsMissing();

    test('.paramsMissing() returns non-Empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 1 missing parameter (title is empty)',
        () => expect(missingParams.length, equals(1)));
  });

  group('DateQPlan.fromJson(missingParams)', () {
    // import from example SurveyKitStepJson using DateQPlan.fromJson
    final dateQPlan = DateQPlan.fromJson(DQX.missingParams);

    test('stepID[\'id\'] is non-Empty',
        () => expect(dateQPlan.stepID['id']?.isNotEmpty, equals(true)));
    test('title is null', () => expect(dateQPlan.title, isNull));
    test('text is empty string (\'\')',
        () => expect(dateQPlan.text, equals('')));
    test('minDate is null', () => expect(dateQPlan.minDate, isNull));
    test('maxDate is null', () => expect(dateQPlan.maxDate, isNull));
    test('defaultDate is null', () => expect(dateQPlan.defaultDate, isNull));

    final missingParams = dateQPlan.paramsMissing();

    test('.paramsMissing() returns non-Empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 4 missing parameters',
        () => expect(missingParams.length, equals(4)));
  });

  group('DateQPlan.toJson(missingParams)', () {
    // import from example SurveyKitStepJson using DateQPlan.fromJson
    final dateQPlan = DateQPlan.fromJson(DQX.missingParams);
    // Export to SurveyKitStepJson using DateQPlan.toJson
    final dateQJsonResult = dateQPlan.toJson();

    test(
        'title matches',
        () => expect(
            dateQJsonResult['title'], equals(DQX.missingParams['title'])));
    test(
        'answerFormat.type matches',
        () => expect(dateQJsonResult['answerFormat']['type'],
            equals(DQX.missingParams['answerFormat']['type'])));
    test(
        'answerFormat.minDate matches',
        () => expect(dateQJsonResult['answerFormat']['minDate'],
            equals(DQX.missingParams['answerFormat']['minDate'])));
    test(
        'answerFormat.maxDate matches',
        () => expect(dateQJsonResult['answerFormat']['maxDate'],
            equals(DQX.missingParams['answerFormat']['maxDate'])));
    test(
        'answerFormat.defaultDate matches',
        () => expect(dateQJsonResult['answerFormat']['defaultDate'],
            equals(DQX.missingParams['answerFormat']['defaultDate'])));
  });
}

class DQX {
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
      'type': 'date',
      'minDate': '2015-06-25T04:08:16Z',
      'maxDate': '2025-06-25T04:08:16Z',
      'defaultDate': '2021-06-25T04:08:16Z',
    },
  };
  // ignore: constant_identifier_names
  static const Map<String, dynamic> iD_noTitle = {
    'title': '',
    'type': 'question',
    'stepIdentifier': {
      'id': 'absdcdasfasdf',
    },
    'answerFormat': {
      'type': 'date',
      'minDate': '2015-06-25T04:08:16Z',
      'maxDate': '2025-06-25T04:08:16Z',
      'defaultDate': '2021-06-25T04:08:16Z',
    },
  };
  static const Map<String, dynamic> missingParams = {
    'type': 'question',
    'answerFormat': {
      'type': 'date',
    },
  };
}
