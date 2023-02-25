import 'package:evac_drill_console/models/evac_action_plans/evac_action_plan.dart';
import 'package:evac_drill_console/models/task_details_plans/task_details_plan.dart';

/// Defines the task detail for DrillTaskPlan of DrillTaskType `practiceEvac`

class PracticeEvacDetailsPlan implements TaskDetailsPlan {
  static const taskType = DrillTaskType.practiceEvac;
  @override
  final String taskID;
  String? title;
  bool? trackingLocation;
  List<EvacActionPlan> actions;

  PracticeEvacDetailsPlan({
    taskID,
    this.title,
    this.trackingLocation,
    this.actions = const [],
  }) : taskID = taskID ?? const Uuid().v4();

  factory PracticeEvacDetailsPlan.fromJson(taskJson) {
    if (taskJson['taskType'] != taskType.name) {
      throw FormatException(
          'Incorrect taskType on `practiceEvac`: ${taskJson['taskType']}');
    }
    final json = taskJson['details'] as Map<String, dynamic>;
    if (json['taskID'] == null) {
      throw const FormatException('No PracticeEvacDetailsPlan.taskID??');
    }
    if (json['actions'] == null) {
      throw const FormatException(
          'PracticeEvacDetails `actions` cannot be null');
    }
    return PracticeEvacDetailsPlan(
      taskID: json['taskID'],
      title: json['title'],
      trackingLocation: json['trackingLocation'],
      actions: _listFromJson(json['actions'], json['taskID']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'taskID': taskID,
      'title': title,
      'trackingLocation': trackingLocation,
      'actions': _jsonFromList(actions),
    };
  }

  @override
  List<MissingPlanParam> paramsMissing() {
    List<MissingPlanParam> missingParams = [];

    if (title == null || title!.isEmpty) {
      missingParams.add(MissingPlanParam('practiceEvac.title'));
    }
    if (trackingLocation == null) {
      missingParams.add(MissingPlanParam('practiceEvac.trackingLocation'));
    }
    if (actions.isEmpty || actions.length == 1) {
      // if length == 1 then only WaitForStart, need at least one Instruction
      missingParams.add(MissingPlanParam('practiceEvac.actions'));
    }

    // can start on index = 1 as index == 0 will always be WaitForStartAction,
    // and it cannot be missing params
    for (var i = 1; i < actions.length; i++) {
      final instructionMissingParams = actions[i].paramsMissing();
      for (final missingParam in instructionMissingParams) {
        missingParams.add(
            MissingPlanParam('practiceEvac.action[$i].${missingParam.field}'));
      }
    }

    return missingParams;
  }
}

List<Map<String, dynamic>> _jsonFromList(List<EvacActionPlan> actions) {
  List<Map<String, dynamic>> actionsJsonList = [];
  for (final action in actions) {
    actionsJsonList.add(action.toJson());
  }
  return actionsJsonList;
}

List<EvacActionPlan> _listFromJson(List<dynamic> actionsJson, id) {
  List<EvacActionPlan> actions = [];

  /// probably should be implemented, but handling this restriction on the
  /// frontend is more than I have time for (3 days left)
  // if (actionsJson.isNotEmpty &&
  //     actionsJson[0]['actionType'] != EvacActionType.waitForStart.name) {
  //   throw FormatException(
  //       'Practice Evac Actions must begin with a `waitForStart`, but the list for task `$id` starts with a different type of EvacAction');
  // }
  for (final actionJson in actionsJson) {
    actions.add(EvacActionPlan.fromJson(actionJson));
  }
  return actions;
}
