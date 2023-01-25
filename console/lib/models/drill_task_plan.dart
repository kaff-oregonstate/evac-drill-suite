import 'package:evac_drill_console/models/task_details_plans/task_details_plan.dart';

/// Initially defined in the App, DrillTaskType enumerates the types
/// of drill tasks

enum DrillTaskType {
  survey,
  reqLocPerms,
  waitForStart,
  practiceEvac,
  travel,
  upload,
}

/// The DrillTaskPlan describes within the DrillPlan the current plan for a
/// matching DrillTask object within a DrillDetails object

class DrillTaskPlan {
  final String taskID;
  final int index;
  final DrillTaskType taskType;
  final String title;
  final TaskDetailsPlan details;

  DrillTaskPlan({
    required this.taskID,
    required this.index,
    required this.taskType,
    required this.title,
    required this.details,
  });

  // TODO: DrillTaskPlan.fromJson(json)
  // TODO: DrillTaskPlan.toJson()
  // TODO: recursive DrillTaskPlan.paramsMissing()
}
