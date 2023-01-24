import 'package:evac_drill_console/models/survey_step_plans/survey_step_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testSurveyStepPlan();
}

/// Tests the SurveyStepPlan abstract Data Model
void testSurveyStepPlan() {
  // test bad formatting passed into .fromJson to confirm throwFormatException
  test(
    'SurveyStepPlan.fromJson(invalidType) throws FormatException',
    () => expect(
        () => SurveyStepPlan.fromJson(SSPX.invalidType), throwsFormatException),
  );
  test(
    'SurveyStepPlan.fromJson(invalidQType) throws FormatException',
    () => expect(() => SurveyStepPlan.fromJson(SSPX.invalidQType),
        throwsFormatException),
  );

  // test each type passed into .fromJson
  group('SurveyStepPlan.fromJson()', () {
    for (var entry in SSPX.validCases.entries) {
      final thisStepPlan = SurveyStepPlan.fromJson(entry.value);
      test(
        entry.key.name,
        () => expect(thisStepPlan.runtimeType, equals(SSPX.types[entry.key])),
      );
    }
  });
}

/// Example JSON inputs for SurveyStepPlan
class SSPX {
  static const Map<String, dynamic> invalidType = {
    'type': 'afroman',
    'title': 'Did you have to traumatize my kids?',
    'text': 'https://www.youtube.com/watch?v=oponIfu5L3Y',
    'answerFormat': {
      'type': 'intexer',
      'hint': 'This question will never be asked 🤪',
    },
  };
  static const Map<String, dynamic> invalidQType = {
    'type': 'question',
    'title': 'How many surveys is this?',
    'text': 'example intexer step text',
    'answerFormat': {
      'type': 'intexer',
      'hint': 'This question will never be asked 🤪',
    },
  };
  static const Map<SurveyStepType, Map<String, dynamic>> validCases = {
    SurveyStepType.boolean: {
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
    SurveyStepType.completion: {
      'type': 'completion',
      'title': 'An example title text',
      'text': 'example step text',
    },
    SurveyStepType.date: {
      'type': 'question',
      'title': 'An example title text',
      'text': 'example step text',
      'answerFormat': {
        'type': 'date',
      }
    },
    SurveyStepType.integer: {
      'type': 'question',
      'title': 'An example title text',
      'text': 'example step text',
      'answerFormat': {
        'type': 'integer',
      }
    },
    SurveyStepType.introduction: {
      'type': 'intro',
      'title': 'An example title text',
      'text': 'example step text',
    },
    SurveyStepType.scale: {
      'type': 'question',
      'title': 'An example title text',
      'text': 'example step text',
      'answerFormat': {
        'type': 'scale',
      }
    },
    SurveyStepType.singleChoice: {
      'type': 'question',
      'title': 'An example title text',
      'text': 'example step text',
      'answerFormat': {
        'type': 'single',
      }
    },
    SurveyStepType.text: {
      'type': 'question',
      'title': 'An example title text',
      'text': 'example step text',
      'answerFormat': {
        'type': 'text',
      }
    },
  };
  static const Map<SurveyStepType, Type> types = {
    SurveyStepType.boolean: BoolQPlan,
    SurveyStepType.completion: CompletionStepPlan,
    SurveyStepType.date: DateQPlan,
    SurveyStepType.integer: IntQPlan,
    SurveyStepType.introduction: IntroductionStepPlan,
    SurveyStepType.scale: ScaleQPlan,
    SurveyStepType.singleChoice: SingleChoiceQPlan,
    SurveyStepType.text: TextQPlan,
  };
}
