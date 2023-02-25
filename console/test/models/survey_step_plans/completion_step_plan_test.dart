import 'package:evac_drill_console/models/survey_step_plans/survey_step_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testCompletionStepPlan();
}

/// Tests the CompletionStepPlan Data Model
void testCompletionStepPlan() {
  test(
    'CompletionStepPlan.fromJson(invalid) throws FormatException',
    () => expect(() => CompletionStepPlan.fromJson(CSX.invalidCase),
        throwsFormatException),
  );

  group('CompletionStepPlan.fromJson(happyCase)', () {
    // import from example SurveyKitStepJson using CompletionStepPlan.fromJson
    final completionStepPlan = CompletionStepPlan.fromJson(CSX.happyCase);
    test('title matches',
        () => expect(completionStepPlan.title, equals(CSX.happyCase['title'])));
    test('text matches',
        () => expect(completionStepPlan.text, equals(CSX.happyCase['text'])));
    test('.paramsMissing() returns empty',
        () => expect(completionStepPlan.paramsMissing(), isEmpty));
  });

  group('CompletionStepPlan.toJson(happyCase)', () {
    // import from example SurveyKitStepJson using CompletionStepPlan.fromJson
    final completionStepPlan = CompletionStepPlan.fromJson(CSX.happyCase);
    // Export to SurveyKitStepJson using CompletionStepPlan.toJson
    final completionStepJsonResult = completionStepPlan.toJson();

    test(
        'title matches',
        () => expect(
            completionStepJsonResult['title'], equals(CSX.happyCase['title'])));
    test(
        'type matches',
        () => expect(
            completionStepJsonResult['type'], equals(CSX.happyCase['type'])));
  });

  group('CompletionStepPlan.fromJson(iD_noTitle)', () {
    // import from example SurveyKitStepJson using CompletionStepPlan.fromJson
    final completionStepPlan = CompletionStepPlan.fromJson(CSX.iD_noTitle);

    test(
        'stepID[\'id\'] matches',
        () => expect(completionStepPlan.stepID['id'],
            equals(CSX.iD_noTitle['stepIdentifier']['id'])));

    final missingParams = completionStepPlan.paramsMissing();

    test('.paramsMissing() returns non-Empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 1 missing parameter (title is empty)',
        () => expect(missingParams.length, equals(1)));
  });

  group('CompletionStepPlan.fromJson(missingParams)', () {
    // import from example SurveyKitStepJson using CompletionStepPlan.fromJson
    final completionStepPlan = CompletionStepPlan.fromJson(CSX.missingParams);

    test(
        'stepID[\'id\'] is non-Empty',
        () =>
            expect(completionStepPlan.stepID['id']?.isNotEmpty, equals(true)));
    test('title is null', () => expect(completionStepPlan.title, isNull));
    test('text is empty string (\'\')',
        () => expect(completionStepPlan.text, equals('')));

    final missingParams = completionStepPlan.paramsMissing();

    test('.paramsMissing() returns non-Empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 1 missing parameters',
        () => expect(missingParams.length, equals(1)));
  });

  group('CompletionStepPlan.toJson(missingParams)', () {
    // import from example SurveyKitStepJson using CompletionStepPlan.fromJson
    final completionStepPlan = CompletionStepPlan.fromJson(CSX.missingParams);
    // Export to SurveyKitStepJson using CompletionStepPlan.toJson
    final completionStepJsonResult = completionStepPlan.toJson();

    test(
        'title matches',
        () => expect(completionStepJsonResult['title'],
            equals(CSX.missingParams['title'])));
    test(
        'type matches',
        () => expect(completionStepJsonResult['type'],
            equals(CSX.missingParams['type'])));
  });
}

class CSX {
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
    'type': 'completion',
    'title': 'Example completion title',
    'text': 'example text',
  };
  // ignore: constant_identifier_names
  static const Map<String, dynamic> iD_noTitle = {
    'title': '',
    'type': 'completion',
    'stepIdentifier': {
      'id': 'absdcdasfasdf',
    },
  };
  static const Map<String, dynamic> missingParams = {
    'type': 'completion',
  };
}
