import 'package:evac_drill_console/models/survey_step_plans/survey_step_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testIntroductionStepPlan();
}

/// Tests the IntroductionStepPlan Data Model
void testIntroductionStepPlan() {
  test(
    'IntroductionStepPlan.fromJson(invalid) throws FormatException',
    () => expect(() => IntroductionStepPlan.fromJson(ISX.invalidCase),
        throwsFormatException),
  );

  group('IntroductionStepPlan.fromJson(happyCase)', () {
    // import from example SurveyKitStepJson using IntroductionStepPlan.fromJson
    final introStepPlan = IntroductionStepPlan.fromJson(ISX.happyCase);
    test('title matches',
        () => expect(introStepPlan.title, equals(ISX.happyCase['title'])));
    test('text matches',
        () => expect(introStepPlan.text, equals(ISX.happyCase['text'])));
    test('.paramsMissing() returns empty',
        () => expect(introStepPlan.paramsMissing(), isEmpty));
  });

  group('IntroductionStepPlan.toJson(happyCase)', () {
    // import from example SurveyKitStepJson using IntroductionStepPlan.fromJson
    final introStepPlan = IntroductionStepPlan.fromJson(ISX.happyCase);
    // Export to SurveyKitStepJson using IntroductionStepPlan.toJson
    final introStepJsonResult = introStepPlan.toJson();

    test(
        'title matches',
        () => expect(
            introStepJsonResult['title'], equals(ISX.happyCase['title'])));
    test(
        'type matches',
        () =>
            expect(introStepJsonResult['type'], equals(ISX.happyCase['type'])));
  });

  group('IntroductionStepPlan.fromJson(iD_noTitle)', () {
    // import from example SurveyKitStepJson using IntroductionStepPlan.fromJson
    final introStepPlan = IntroductionStepPlan.fromJson(ISX.iD_noTitle);

    test(
        'stepID[\'id\'] matches',
        () => expect(introStepPlan.stepID['id'],
            equals(ISX.iD_noTitle['stepIdentifier']['id'])));

    final missingParams = introStepPlan.paramsMissing();

    test('.paramsMissing() returns non-Empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 1 missing parameter (title is empty)',
        () => expect(missingParams.length, equals(1)));
  });

  group('IntroductionStepPlan.fromJson(missingParams)', () {
    // import from example SurveyKitStepJson using IntroductionStepPlan.fromJson
    final introStepPlan = IntroductionStepPlan.fromJson(ISX.missingParams);

    test('stepID[\'id\'] is non-Empty',
        () => expect(introStepPlan.stepID['id']?.isNotEmpty, equals(true)));
    test('title is null', () => expect(introStepPlan.title, isNull));
    test('text is empty string (\'\')',
        () => expect(introStepPlan.text, equals('')));

    final missingParams = introStepPlan.paramsMissing();

    test('.paramsMissing() returns non-Empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 1 missing parameter (only title required)',
        () => expect(missingParams.length, equals(1)));
  });

  group('IntroductionStepPlan.toJson(missingParams)', () {
    // import from example SurveyKitStepJson using IntroductionStepPlan.fromJson
    final introStepPlan = IntroductionStepPlan.fromJson(ISX.missingParams);
    // Export to SurveyKitStepJson using IntroductionStepPlan.toJson
    final introStepJsonResult = introStepPlan.toJson();

    test(
        'title matches',
        () => expect(
            introStepJsonResult['title'], equals(ISX.missingParams['title'])));
    test(
        'type matches',
        () => expect(
            introStepJsonResult['type'], equals(ISX.missingParams['type'])));
  });
}

class ISX {
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
    'type': 'intro',
    'title': 'Example question title',
    'text': 'example text',
    'buttonText': 'Ok, next 👉',
  };
  // ignore: constant_identifier_names
  static const Map<String, dynamic> iD_noTitle = {
    'type': 'intro',
    'title': '',
    'stepIdentifier': {
      'id': 'absdcdasfasdf',
    },
  };
  static const Map<String, dynamic> missingParams = {
    'type': 'intro',
  };
}
