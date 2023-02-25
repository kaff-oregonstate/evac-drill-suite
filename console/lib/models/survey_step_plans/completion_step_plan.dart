import 'package:evac_drill_console/models/survey_step_plans/survey_step_plan.dart'
    show SurveyStepPlan, SurveyStepType, Uuid;
import 'package:evac_drill_console/models/missing_plan_param.dart';

class CompletionStepPlan implements SurveyStepPlan {
  @override
  SurveyStepType type = SurveyStepType.completion;
  @override
  Map<String, String> stepID;
  @override
  String? title;
  @override
  String text;

  CompletionStepPlan({
    stepID,
    this.title,
    this.text = '', // unfortunately, SurveyKit does not handle null vals here
  }) : stepID = stepID ?? {'id': const Uuid().v4()};

  factory CompletionStepPlan.fromJson(stepJson) {
    if (stepJson['type'] != 'completion') {
      throw FormatException(
        "stepJson['type'] is ${stepJson['type']}, not 'completion'.",
      );
    }
    return CompletionStepPlan(
      stepID: {'id': stepJson['stepIdentifier']['id'] as String},
      title: stepJson['title'],
      text: stepJson['text'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'stepIdentifier': stepID,
      'type': 'completion',
      'title': title,
      'text': text,
      'buttonText': 'Submit survey', // Use this default?
    };
  }

  @override
  List<MissingPlanParam> paramsMissing() {
    List<MissingPlanParam> missingParams = [];

    if (title == null || title!.isEmpty) {
      missingParams.add(MissingPlanParam('completionStep.title'));
    }

    return missingParams;
  }
}
