import 'package:evac_drill_console/models/survey_step_plans/survey_step_plan.dart'
    show SurveyStepPlan, SurveyStepType, Uuid;
import 'package:evac_drill_console/models/missing_plan_param.dart';

class TextQPlan implements SurveyStepPlan {
  @override
  final SurveyStepType type = SurveyStepType.text;
  @override
  Map<String, String> stepID;
  @override
  String? title;
  @override
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
      stepID: {'id': stepJson['stepIdentifier']['id'] as String},
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
        // linter doesn't know what it's talking about here, must escape 's':
        // ignore: unnecessary_string_escapes
        'validationRegEx': '^(?!\s*\$).+'
      },
    };
  }

  @override
  List<MissingPlanParam> paramsMissing() {
    List<MissingPlanParam> missingParams = [];

    if (title == null || title!.isEmpty) {
      missingParams.add(MissingPlanParam('textQeustion.title'));
    }

    return missingParams;
  }
}
