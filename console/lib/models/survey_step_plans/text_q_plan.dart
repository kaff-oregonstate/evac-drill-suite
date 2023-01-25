import 'package:evac_drill_console/models/survey_step_plans/survey_step_plan.dart'
    show SurveyStepPlan, SurveyStepType, Uuid;
import 'package:evac_drill_console/models/missing_plan_param.dart';

class TextQPlan implements SurveyStepPlan {
  static const SurveyStepType type = SurveyStepType.text;
  Map<String, String> stepID;
  String? title;
  String text;
  int? maxLines;

  TextQPlan({
    stepID,
    this.title,
    this.text = '', // unfortunately, SurveyKit does not handle null vals here
    this.maxLines,
  }) : stepID = stepID ?? {'id': const Uuid().v4()};

  factory TextQPlan.fromJson(stepJson) {
    if (stepJson['answerFormat']['type'] != 'text') {
      throw FormatException(
        "stepJson['answerFormat']['type'] is ${stepJson['answerFormat']['type']}, not 'text'.",
      );
    }
    return TextQPlan(
      stepID: stepJson['stepIdentifier'],
      title: stepJson['title'],
      text: stepJson['text'] ?? '',
      maxLines: stepJson['answerFormat']['maxLines'],
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
        'type': 'text',
        'maxLines': maxLines,
      },
    };
  }

  @override
  List<MissingPlanParam> paramsMissing() {
    List<MissingPlanParam> missingParams = [];

    if (title == null || title!.isEmpty) {
      missingParams.add(MissingPlanParam('${stepID['id']}.title'));
    }

    return missingParams;
  }
}
