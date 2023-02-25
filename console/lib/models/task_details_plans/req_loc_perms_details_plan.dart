import 'package:evac_drill_console/models/task_details_plans/task_details_plan.dart';

/// Defines the task detail for DrillTaskPlan of DrillTaskType `reqLocPerms`

class ReqLocPermsDetailsPlan implements TaskDetailsPlan {
  static const taskType = DrillTaskType.reqLocPerms;
  @override
  final String taskID;

  ReqLocPermsDetailsPlan({taskID}) : taskID = taskID ?? const Uuid().v4();

  factory ReqLocPermsDetailsPlan.fromJson(Map<String, dynamic> taskJson) {
    if (taskJson['taskType'] != taskType.name) {
      throw FormatException(
          'Incorrect taskType on `reqLocPerms`: ${taskJson['taskType']}');
    }
    if (taskJson['details']['taskID'] == null) {
      throw const FormatException('No ReqLocPermsDetailsPlan.taskID??');
    }
    return ReqLocPermsDetailsPlan(taskID: taskJson['details']['taskID']);
  }

  @override
  Map<String, dynamic> toJson() => {'taskID': taskID};

  @override
  List<MissingPlanParam> paramsMissing() {
    // always valid for now, return an empty list
    return [];
  }
}
