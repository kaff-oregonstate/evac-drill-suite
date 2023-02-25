import 'package:evac_drill_console/models/survey_step_plans/survey_step_plan.dart'
    show SurveyStepPlan, SurveyStepType, Uuid;
import 'package:evac_drill_console/models/missing_plan_param.dart';

class IntQPlan implements SurveyStepPlan {
  @override
  final SurveyStepType type = SurveyStepType.integer;
  @override
  Map<String, String> stepID;
  @override
  String? title;
  @override
  String text;
  String hint;

  IntQPlan({
    stepID,
    this.title,
    this.text = '', // unfortunately, SurveyKit does not handle null vals here
    hint,
  })  : stepID = stepID ?? {'id': const Uuid().v4()},
        hint = hint ?? '';

  factory IntQPlan.fromJson(stepJson) {
    if (stepJson['answerFormat']['type'] != 'integer') {
      throw FormatException(
        "stepJson['answerFormat']['type'] is ${stepJson['answerFormat']['type']}, not 'integer'.",
      );
    }
    return IntQPlan(
      stepID: {'id': stepJson['stepIdentifier']['id'] as String},
      title: stepJson['title'],
      text: stepJson['text'] ?? '',
      hint: stepJson['answerFormat']['hint'],
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
        'type': 'integer',
        'hint': hint,
      },
    };
  }

  @override
  List<MissingPlanParam> paramsMissing() {
    List<MissingPlanParam> missingParams = [];

    if (title == null || title!.isEmpty) {
      missingParams.add(MissingPlanParam('intQuestion.title'));
    }

    return missingParams;
  }
}
