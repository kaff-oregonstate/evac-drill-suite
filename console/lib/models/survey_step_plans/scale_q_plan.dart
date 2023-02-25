import 'package:evac_drill_console/models/survey_step_plans/survey_step_plan.dart'
    show SurveyStepPlan, SurveyStepType, Uuid;
import 'package:evac_drill_console/models/missing_plan_param.dart';

class ScaleQPlan implements SurveyStepPlan {
  @override
  final SurveyStepType type = SurveyStepType.scale;
  @override
  Map<String, String> stepID;
  @override
  String? title;
  @override
  String text;
  double? step;
  double? minimumValue;
  double? maximumValue;
  double? defaultValue;
  String? minimumValueDescription;
  String? maximumValueDescription;

  ScaleQPlan({
    stepID,
    this.title,
    this.text = '', // unfortunately, SurveyKit does not handle null vals here
    this.step,
    this.minimumValue,
    this.maximumValue,
    this.defaultValue,
    this.minimumValueDescription,
    this.maximumValueDescription,
  }) : stepID = stepID ?? {'id': const Uuid().v4()};

  factory ScaleQPlan.fromJson(stepJson) {
    if (stepJson['answerFormat']['type'] != 'scale') {
      throw FormatException(
        "stepJson['answerFormat']['type'] is ${stepJson['answerFormat']['type']}, not 'scale'.",
      );
    }
    var stepVal = stepJson['answerFormat']['step'];
    var minVal = stepJson['answerFormat']['minimumValue'];
    var maxVal = stepJson['answerFormat']['maximumValue'];
    var defVal = stepJson['answerFormat']['defaultValue'];
    if (stepVal.runtimeType == int) stepVal = (stepVal as int).toDouble();
    if (minVal.runtimeType == int) minVal = (minVal as int).toDouble();
    if (maxVal.runtimeType == int) maxVal = (maxVal as int).toDouble();
    if (defVal.runtimeType == int) defVal = (defVal as int).toDouble();
    return ScaleQPlan(
      stepID: {'id': stepJson['stepIdentifier']['id'] as String},
      title: stepJson['title'],
      text: stepJson['text'] ?? '',
      step: stepVal,
      minimumValue: minVal,
      maximumValue: maxVal,
      defaultValue: defVal,
      minimumValueDescription: stepJson['answerFormat']
          ['minimumValueDescription'],
      maximumValueDescription: stepJson['answerFormat']
          ['maximumValueDescription'],
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
        'type': 'scale',
        'step': step,
        'minimumValue': minimumValue,
        'maximumValue': maximumValue,
        'defaultValue': defaultValue,
        'minimumValueDescription': minimumValueDescription,
        'maximumValueDescription': maximumValueDescription,
      },
    };
  }

  @override
  List<MissingPlanParam> paramsMissing() {
    List<MissingPlanParam> missingParams = [];

    if (title == null || title!.isEmpty) {
      missingParams.add(MissingPlanParam('scaleQuestion.title'));
    }
    if (step == null) {
      missingParams.add(MissingPlanParam('scaleQuestion.step'));
    }
    if (minimumValue == null) {
      missingParams.add(MissingPlanParam('scaleQuestion.minimumValue'));
    }
    if (maximumValue == null) {
      missingParams.add(MissingPlanParam('scaleQuestion.maximumValue'));
    }
    if (defaultValue == null) {
      missingParams.add(MissingPlanParam('scaleQuestion.defaultValue'));
    }

    return missingParams;
  }
}
