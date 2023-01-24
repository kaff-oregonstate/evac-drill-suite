import 'package:evac_drill_console/models/survey_step_plans/survey_step_plan.dart'
    show SurveyStepPlan, SurveyStepType;
import 'package:evac_drill_console/models/missing_plan_param.dart';
import 'package:uuid/uuid.dart';

class BoolQPlan implements SurveyStepPlan {
  static SurveyStepType type = SurveyStepType.boolean;
  Map<String, String> stepID;
  String? title;
  String text;
  String? positiveAnswer;
  String? negativeAnswer;

  BoolQPlan({
    stepID,
    this.title,
    this.text = '', // unfortunately, SurveyKit does not handle null vals here
    this.positiveAnswer,
    this.negativeAnswer,
  }) : stepID = stepID ?? {'id': const Uuid().v4()};

  factory BoolQPlan.fromJson(stepJson) {
    if (stepJson['answerFormat']['type'] != 'bool') {
      throw FormatException(
        "stepJson['answerFormat']['type'] is ${stepJson['answerFormat']['type']}, not 'bool'.",
      );
    }
    return BoolQPlan(
      stepID: stepJson['stepIdentifier'],
      title: stepJson['title'],
      text: stepJson['text'] ?? '',
      positiveAnswer: stepJson['answerFormat']['positiveAnswer'],
      negativeAnswer: stepJson['answerFormat']['negativeAnswer'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    // UNDONE: Does this work? sending null values of keys to Firestore…
    // …will they read back in correctly?
    return {
      'stepIdentifier': stepID,
      'type': 'question',
      'title': title,
      'text': text,
      'answerFormat': {
        'type': 'bool',
        'positiveAnswer': positiveAnswer,
        'negativeAnswer': negativeAnswer,
        'result': 'POSITIVE',
      },
    };
  }

  @override
  List<MissingPlanParam> paramsMissing() {
    List<MissingPlanParam> missingParams = [];

    if (title == null || title!.isEmpty) {
      missingParams.add(MissingPlanParam('${stepID['id']}.title'));
    }
    if (positiveAnswer == null || positiveAnswer!.isEmpty) {
      missingParams.add(MissingPlanParam('${stepID['id']}.positiveAnswer'));
    }
    if (negativeAnswer == null || negativeAnswer!.isEmpty) {
      missingParams.add(MissingPlanParam('${stepID['id']}.negativeAnswer'));
    }

    return missingParams;
  }
}
