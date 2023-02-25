import 'package:evac_drill_console/models/survey_step_plans/survey_step_plan.dart'
    show SurveyStepPlan, SurveyStepType, Uuid;
import 'package:evac_drill_console/models/missing_plan_param.dart';

class BoolQPlan implements SurveyStepPlan {
  @override
  final SurveyStepType type = SurveyStepType.boolean;
  @override
  Map<String, String> stepID;
  @override
  String? title;
  @override
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
      stepID: {'id': stepJson['stepIdentifier']['id'] as String},
      title: stepJson['title'],
      text: stepJson['text'] ?? '',
      positiveAnswer: stepJson['answerFormat']['positiveAnswer'],
      negativeAnswer: stepJson['answerFormat']['negativeAnswer'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
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
      missingParams.add(MissingPlanParam('boolQuestion.title'));
    }
    if (positiveAnswer == null || positiveAnswer!.isEmpty) {
      missingParams.add(MissingPlanParam('boolQuestion.positiveAnswer'));
    }
    if (negativeAnswer == null || negativeAnswer!.isEmpty) {
      missingParams.add(MissingPlanParam('boolQuestion.negativeAnswer'));
    }

    return missingParams;
  }
}
