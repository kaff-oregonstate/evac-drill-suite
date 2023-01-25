import 'package:evac_drill_console/models/survey_step_plans/survey_step_plan.dart';
import 'package:evac_drill_console/models/task_details_plans/task_details_plan.dart';

/// Defines the task detail for DrillTaskPlan of DrillTaskType `survey`

class SurveyDetailsPlan implements TaskDetailsPlan {
  static const taskType = DrillTaskType.survey;
  final String taskID;
  // TODO: Add title field to PDSurvey (this title is displayed in the survey)
  // i.e. it isn't the same as the DrillTask(plan) title
  final String? title;
  List<SurveyStepPlan> surveySteps;

  SurveyDetailsPlan({
    taskID,
    this.title,
    // TODO: Define _defaultSurveySteps
    // FIXME: Load _defaultSurveySteps if null is passed to this constructor
    // (this is allowed because if an empty list is passed, it will remain empty)
    this.surveySteps = const [],
    // FIXME: We actually probably can't be generating the taskIDs here, they need to be from the DrillTaskPlan that's holding these details…
  }) : taskID = taskID ?? const Uuid().v4();

  factory SurveyDetailsPlan.fromJson(taskJson) {
    if (taskJson['taskType'] != taskType.name) {
      throw FormatException(
          'Incorrect taskType on `survey`: ${taskJson['taskType']}');
    }
    final json = taskJson['details'] as Map<String, dynamic>;
    if (json['taskID'] == null) {
      throw const FormatException('No SurveyDetailsPlan.taskID??');
    }
    if (json['surveyKitJson'] == null) json['surveyKitJson'] = [];
    return SurveyDetailsPlan(
      taskID: json['taskID'],
      title: json['title'],
      surveySteps: _listFromSurveyKitJson(json['surveyKitJson']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'taskID': taskID,
        'title': title,
        'surveyKitJson': {
          // UNDONE: Does our custom SurveyKit implementation need something specific here? Concern: Did we implement custom logic based on 'preDrillSurvey' || 'postDrillSurvey'?
          'id': title,
          'type': 'navigable',
          'steps': _jsonFromList(surveySteps),
        },
      };

  @override
  List<MissingPlanParam> paramsMissing() {
    List<MissingPlanParam> missingParams = [];

    if (title == null || title!.isEmpty) {
      missingParams.add(MissingPlanParam('survey.$taskID.title'));
    }
    if (surveySteps.isEmpty) {
      missingParams.add(MissingPlanParam('survey.$taskID.surveySteps'));
    }

    // Need to modify the found MissingPlanParams to have the full field string,
    // or whatever format we end up with we need to add the identifier for the
    // larger context of that missing param in the given SurveyStepPlan

    for (var i = 0; i < surveySteps.length; i++) {
      final stepMissingParams = surveySteps[i].paramsMissing();
      for (final missingParam in stepMissingParams) {
        // HACK: what should the `field` string of a survey be for MissingPlanParam? (currently: 'survey.$taskID')
        // FIXME: currently using both index (here: `$i`) and stepID (there: `$stepID`). Choose one.
        missingParams
            .add(MissingPlanParam('survey.$taskID[$i].${missingParam.field}'));
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
  final List<Map<String, dynamic>> stepsJson = surveyKitJson['steps'];
  List<SurveyStepPlan> surveySteps = [];
  for (final stepJson in stepsJson) {
    surveySteps.add(SurveyStepPlan.fromJson(stepJson));
  }
  return surveySteps;
}
