import 'package:evac_drill_console/models/survey_step_plans/survey_step_plan.dart'
    show SurveyStepPlan, SurveyStepType, Uuid;
import 'package:evac_drill_console/models/missing_plan_param.dart';

class SingleChoiceQPlan implements SurveyStepPlan {
  @override
  final SurveyStepType type = SurveyStepType.singleChoice;
  @override
  Map<String, String> stepID;
  @override
  String? title;
  @override
  String text;
  String? yesChoice;
  String? noChoice;

  SingleChoiceQPlan({
    stepID,
    this.title,
    this.text = '', // unfortunately, SurveyKit does not handle null vals here
    this.yesChoice,
    this.noChoice,
  }) : stepID = stepID ?? {'id': const Uuid().v4()};

  factory SingleChoiceQPlan.fromJson(stepJson) {
    if (stepJson['answerFormat']['type'] != 'single') {
      throw FormatException(
        "stepJson['answerFormat']['type'] is ${stepJson['answerFormat']['type']}, not 'single'.",
      );
    }
    return SingleChoiceQPlan(
      stepID: {'id': stepJson['stepIdentifier']['id'] as String},
      title: stepJson['title'],
      text: stepJson['text'] ?? '',
      yesChoice: stepJson['answerFormat']['textChoices']?[0]['text'],
      noChoice: stepJson['answerFormat']['textChoices']?[1]['text'],
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
        'type': 'single',
        'textChoices': [
          {'text': yesChoice, 'value': 'Yes'},
          {'text': noChoice, 'value': 'No'}
        ]
      },
    };
  }

  @override
  List<MissingPlanParam> paramsMissing() {
    List<MissingPlanParam> missingParams = [];

    if (title == null || title!.isEmpty) {
      missingParams.add(MissingPlanParam('singleChoiceQuestion.title'));
    }
    if (yesChoice == null || yesChoice!.isEmpty) {
      missingParams.add(MissingPlanParam('singleChoiceQuestion.yesChoice'));
    }
    if (noChoice == null || noChoice!.isEmpty) {
      missingParams.add(MissingPlanParam('singleChoiceQuestion.noChoice'));
    }

    return missingParams;
  }
}
