import 'package:evac_drill_console/models/survey_step_plans/survey_step_plan.dart'
    show SurveyStepPlan, SurveyStepType, Uuid;
import 'package:evac_drill_console/models/missing_plan_param.dart';

class DateQPlan implements SurveyStepPlan {
  static const SurveyStepType type = SurveyStepType.date;
  Map<String, String> stepID;
  String? title;
  String text;
  DateTime? minDate;
  DateTime? maxDate;
  DateTime? defaultDate;

  DateQPlan({
    stepID,
    this.title,
    this.text = '', // unfortunately, SurveyKit does not handle null vals here
    this.minDate,
    this.maxDate,
    this.defaultDate,
  }) : stepID = stepID ?? {'id': const Uuid().v4()};

  factory DateQPlan.fromJson(stepJson) {
    if (stepJson['answerFormat']['type'] != 'date') {
      throw FormatException(
        "stepJson['answerFormat']['type'] is ${stepJson['answerFormat']['type']}, not 'date'.",
      );
    }
    return DateQPlan(
      stepID: stepJson['stepIdentifier'],
      title: stepJson['title'],
      text: stepJson['text'] ?? '',
      minDate: DateTime.tryParse(stepJson['answerFormat']['minDate'] ?? ''),
      maxDate: DateTime.tryParse(stepJson['answerFormat']['maxDate'] ?? ''),
      defaultDate:
          DateTime.tryParse(stepJson['answerFormat']['defaultDate'] ?? ''),
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
        'type': 'date',
        'minDate': minDate?.toIso8601String(),
        'maxDate': maxDate?.toIso8601String(),
        'defaultDate': defaultDate?.toIso8601String(),
      },
    };
  }

  @override
  List<MissingPlanParam> paramsMissing() {
    List<MissingPlanParam> missingParams = [];

    if (title == null || title!.isEmpty) {
      missingParams.add(MissingPlanParam('${stepID['id']}.title'));
    }
    if (minDate == null) {
      missingParams.add(MissingPlanParam('${stepID['id']}.minDate'));
    }
    if (maxDate == null) {
      missingParams.add(MissingPlanParam('${stepID['id']}.maxDate'));
    }
    if (defaultDate == null) {
      missingParams.add(MissingPlanParam('${stepID['id']}.defaultDate'));
    }

    return missingParams;
  }
}
