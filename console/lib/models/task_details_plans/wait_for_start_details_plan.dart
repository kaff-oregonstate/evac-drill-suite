import 'package:evac_drill_console/models/task_details_plans/task_details_plan.dart';

/// The types of WaitForStart DrillTasks (currently only `self`)

enum TypeOfWait {
  // synchronized,
  // signal,
  self,
}

/// Defines the task detail for DrillTaskPlan of DrillTaskType `waitForStart`

class WaitForStartDetailsPlan implements TaskDetailsPlan {
  static const taskType = DrillTaskType.waitForStart;
  final String taskID;
  // each WaitForStart task is intrinsically linked with a PracticeEvac task
  final String practiceEvacTaskID;
  TypeOfWait typeOfWait;
  // Map<String, dynamic>? content;

  WaitForStartDetailsPlan({
    taskID,
    required this.practiceEvacTaskID,
    this.typeOfWait = TypeOfWait.self,
    // this.content,
  }) : taskID = taskID ?? const Uuid().v4();

  factory WaitForStartDetailsPlan.fromJson(taskJson) {
    if (taskJson['taskType'] != taskType.name) {
      throw FormatException(
          'Incorrect taskType on `waitForStart`: ${taskJson['taskType']}');
    }
    if (taskJson['details']['taskID'] == null) {
      throw const FormatException('No WaitForStartDetailsPlan.taskID??');
    }
    if (taskJson['details']['practiceEvacTaskID'] == null) {
      throw const FormatException(
          'Null practiceEvacTaskID in WaitForStartDetailsPlan');
    }
    final json = taskJson['details'] as Map<String, dynamic>;
    TypeOfWait thisTypeOfWait;
    switch (json['typeOfWait']) {
      case 'self':
        thisTypeOfWait = TypeOfWait.self;
        break;
      default:
        thisTypeOfWait = TypeOfWait.self;
    }
    return WaitForStartDetailsPlan(
      taskID: json['taskID'],
      practiceEvacTaskID: json['practiceEvacTaskID'],
      typeOfWait: thisTypeOfWait,
      // // content: json['content'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'taskID': taskID,
      'practiceEvacTaskID': practiceEvacTaskID,
      'typeOfWait': typeOfWait.name,
      // // 'content': content,
    };
  }

  @override
  List<MissingPlanParam> paramsMissing() {
    // For now, this is always valid, so return empty list
    return [];
  }
}
