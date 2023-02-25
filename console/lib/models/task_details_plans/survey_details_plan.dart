import 'package:evac_drill_console/models/survey_step_plans/survey_step_plan.dart';
import 'package:evac_drill_console/models/task_details_plans/task_details_plan.dart';

/// Defines the task detail for DrillTaskPlan of DrillTaskType `survey`

class SurveyDetailsPlan implements TaskDetailsPlan {
  static const taskType = DrillTaskType.survey;
  @override
  final String taskID;
  String? title;
  List<SurveyStepPlan> surveySteps;

  SurveyDetailsPlan({
    taskID,
    this.title,
    surveySteps,
  })  : taskID = taskID ?? const Uuid().v4(),
        surveySteps = surveySteps ?? _defaultSurveySteps;
  // surveySteps = surveySteps ?? const [];

  factory SurveyDetailsPlan.fromJson(taskJson) {
    if (taskJson['taskType'] != taskType.name) {
      throw FormatException(
          'Incorrect taskType on `survey`: ${taskJson['taskType']}');
    }
    final json = taskJson['details'] as Map<String, dynamic>;
    if (json['taskID'] == null) {
      throw const FormatException('No SurveyDetailsPlan.taskID??');
    }
    if (json['surveyKitJson'] == null) {
      throw const FormatException(
          'SurveyDetails `surveyKitJson` cannot be null');
    }
    if (json['surveyKitJson']['steps'] == null) {
      throw const FormatException(
          'SurveyDetails `surveyKitJson[\'steps\']` cannot be null');
    }
    return SurveyDetailsPlan(
      taskID: json['taskID'],
      title: json['title'],
      surveySteps: _listFromSurveyKitJson(json['surveyKitJson']),
    );
  }

  // @override
  // bool operator ==(Object other) {
  //   if (other.runtimeType != SurveyDetailsPlan) {
  //     print('other.runtimeType');
  //     return false;
  //   }
  //   other as SurveyDetailsPlan;
  //   // taskID
  //   if (taskID != other.taskID) {
  //     print('taskID');
  //     return false;
  //   }
  //   // title
  //   if (title != other.title) {
  //     print('title');
  //     return false;
  //   }
  //   // surveySteps
  //   if (surveySteps.length != other.surveySteps.length) {
  //     print('surveySteps.length');
  //     return false;
  //   }
  //   for (var i = 0; i < surveySteps.length; i++) {
  //     if (surveySteps[i] != other.surveySteps[i]) {
  //       print('surveySteps[$i]');
  //       return false;
  //     }
  //   }

  //   return true;
  // }

  @override
  String toString() => 'SurveyStepDetails: ${toJson().toString()}';

  @override
  Map<String, dynamic> toJson() => {
        'taskID': taskID,
        'title': title,
        'surveyKitJson': {
          'id': title,
          'type': 'navigable',
          'steps': _jsonFromList(surveySteps),
        },
      };

  @override
  List<MissingPlanParam> paramsMissing() {
    List<MissingPlanParam> missingParams = [];

    if (title == null || title!.isEmpty) {
      missingParams.add(MissingPlanParam('survey.title'));
    }
    if (surveySteps.isEmpty) {
      missingParams.add(MissingPlanParam('survey.surveySteps'));
    }

    // Need to modify the found MissingPlanParams to have the full field string,
    // or whatever format we end up with we need to add the identifier for the
    // larger context of that missing param in the given SurveyStepPlan

    for (var i = 0; i < surveySteps.length; i++) {
      final stepMissingParams = surveySteps[i].paramsMissing();
      for (final missingParam in stepMissingParams) {
        missingParams
            .add(MissingPlanParam('survey.step[$i].${missingParam.field}'));
      }
    }

    return missingParams;
  }
}

List<Map<String, dynamic>> _jsonFromList(List<SurveyStepPlan> surveySteps) {
  List<Map<String, dynamic>> surveyStepsJson = [];
  for (final step in surveySteps) {
    surveyStepsJson.add(step.toJson());
  }
  return surveyStepsJson;
}

List<SurveyStepPlan> _listFromSurveyKitJson(surveyKitJson) {
  final List<dynamic> stepsJson = surveyKitJson['steps'];
  List<SurveyStepPlan> surveySteps = [];
  for (final stepJson in stepsJson) {
    surveySteps.add(SurveyStepPlan.fromJson(stepJson));
  }
  return surveySteps;
}

List<SurveyStepPlan> _defaultSurveySteps = [
  IntroductionStepPlan(title: 'Begin Survey'),
  BoolQPlan(title: 'True or False?'),
  DateQPlan(title: 'What is the date today?'),
  IntQPlan(title: 'How old are you?'),
  ScaleQPlan(title: 'How prepared are you to evacuate?'),
  SingleChoiceQPlan(title: 'Yes or No?', yesChoice: 'Yes', noChoice: 'No'),
  TextQPlan(title: 'Who invited you to this evacuation drill?'),
  CompletionStepPlan(title: 'Complete Survey'),
];
