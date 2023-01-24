import 'package:evac_drill_console/models/survey_step_plans/survey_step_plan.dart'
    show SurveyStepPlan, SurveyStepType;
import 'package:evac_drill_console/models/missing_plan_param.dart';
import 'package:uuid/uuid.dart';

class IntroductionStepPlan implements SurveyStepPlan {
  static const SurveyStepType type = SurveyStepType.introduction;
  Map<String, String> stepID;
  String? title;
  String text;
  // String? buttonText;

  IntroductionStepPlan({
    stepID,
    this.title,
    this.text = '', // unfortunately, SurveyKit does not handle null vals here
  }) : stepID = stepID ?? {'id': const Uuid().v4()};

  factory IntroductionStepPlan.fromJson(stepJson) {
    if (stepJson['type'] != 'intro') {
      throw FormatException(
        "stepJson['type'] is ${stepJson['type']}, not 'intro'.",
      );
    }
    return IntroductionStepPlan(
      stepID: stepJson['stepIdentifier'],
      title: stepJson['title'],
      text: stepJson['text'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'stepIdentifier': stepID,
      'type': 'intro',
      'title': title,
      'text': text,
      // 'buttonText': 'I\'m Ready!' // Use this default?
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
