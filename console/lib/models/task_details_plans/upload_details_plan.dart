import 'package:evac_drill_console/models/task_details_plans/task_details_plan.dart';

/// Defines the task detail for DrillTaskPlan of DrillTaskType `upload`

class UploadDetailsPlan implements TaskDetailsPlan {
  static const taskType = DrillTaskType.upload;
  final String taskID;

  UploadDetailsPlan({taskID}) : taskID = taskID ?? const Uuid().v4();

  factory UploadDetailsPlan.fromJson(taskJson) {
    if (taskJson['taskType'] != taskType.name) {
      throw FormatException(
          'Incorrect taskType on `upload`: ${taskJson['taskType']}');
    }
    if (taskJson['details']['taskID'] == null) {
      throw const FormatException('No UploadDetailsPlan.taskID??');
    }
    return UploadDetailsPlan(taskID: taskJson['details']['taskID']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'taskID': taskID,
    };
  }

  @override
  List<MissingPlanParam> paramsMissing() {
    // always valid, return an empty list
    return [];
  }
}
