import 'package:evac_drill_console/models/survey_step_plans/survey_step_plan.dart'
    show SurveyStepPlan, SurveyStepType, Uuid;
import 'package:evac_drill_console/models/missing_plan_param.dart';

class IntroductionStepPlan implements SurveyStepPlan {
  @override
  final SurveyStepType type = SurveyStepType.introduction;
  @override
  Map<String, String> stepID;
  @override
  String? title;
  @override
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
      stepID: {'id': stepJson['stepIdentifier']['id'] as String},
      title: stepJson['title'],
      text: stepJson['text'] ?? '',
    );
  }

  // @override
  // bool operator ==(Object other) {
  //   if (other.runtimeType != IntroductionStepPlan) {
  //     print('other.runtimeType');
  //     return false;
  //   }
  //   other as IntroductionStepPlan;
  //   // taskID
  //   if (stepID['id'] != other.stepID['id']) {
  //     print('stepID');
  //     return false;
  //   }
  //   // title
  //   if (title != other.title) {
  //     print('title');
  //     return false;
  //   }
  //   // surveySteps
  //   if (text != other.text) {
  //     print('text');
  //     return false;
  //   }

  //   return true;
  // }

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
      missingParams.add(MissingPlanParam('introStep.title'));
    }

    return missingParams;
  }
}
