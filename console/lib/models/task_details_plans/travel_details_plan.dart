import 'package:evac_drill_console/models/task_details_plans/task_details_plan.dart';

/// Defines the task detail for DrillTaskPlan of DrillTaskType `travel`
/// (Not currently targeted for development as of Jan. 25 2023)

class TravelDetailsPlan implements TaskDetailsPlan {
  // TODO: BACKLOG: Implement TravelDetailsPlan
  static const taskType = DrillTaskType.travel;
  final String taskID;

  TravelDetailsPlan({taskID}) : taskID = taskID ?? const Uuid().v4();

  factory TravelDetailsPlan.fromJson(taskJson) {
    if (taskJson['taskType'] != taskType.name) {
      throw FormatException(
          'Incorrect taskType on `travel`: ${taskJson['taskType']}');
    }
    if (taskJson['details']['taskID'] == null) {
      throw const FormatException('No TravelDetailsPlan.taskID??');
    }
    return TravelDetailsPlan(
      taskID: taskJson['details']['taskID'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'taskID': taskID,
    };
  }

  @override
  List<MissingPlanParam> paramsMissing() {
    // T O D O : recursive TravelDetailsPlan.paramsMissing()

    return [];
  }
}
