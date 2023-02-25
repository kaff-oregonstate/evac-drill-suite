import 'package:evac_drill_console/models/task_details_plans/task_details_plan.dart';

/// Initially defined in the App, DrillTaskType enumerates the types
/// of drill tasks

enum DrillTaskType {
  survey,
  reqLocPerms,
  practiceEvac,
  travel,
  upload,
}

extension DrillTaskName on DrillTaskType {
  String get fullName {
    switch (this) {
      case DrillTaskType.survey:
        return 'Survey';
      case DrillTaskType.reqLocPerms:
        return 'Request Location Permissions';
      case DrillTaskType.practiceEvac:
        return 'Practice Evacuation';
      case DrillTaskType.travel:
        return 'Travel';
      case DrillTaskType.upload:
        return 'Upload';
      default:
        throw Exception('Internal: bad DrillTaskType on .fullName');
    }
  }
}

// FIXME: The double-layers of abstraction (DrillTask, TaskDetails) seems redundant
// and unnecessary now, why isn't just DrillTask with implemented types? Let's
// switch this once the initial version of the Console is done.

/// The DrillTaskPlan describes within the DrillPlan the current plan for a
/// matching DrillTask object within a DrillDetails object

class DrillTaskPlan {
  final String taskID;
  // final int index;
  final DrillTaskType taskType;
  String? title;
  TaskDetailsPlan details;

  DrillTaskPlan({
    required this.taskID,
    // required this.index,
    required this.taskType,
    this.title,
    required this.details,
  });

  factory DrillTaskPlan.fromJson(Map<String, dynamic> json) {
    DrillTaskType thisTaskType;
    switch (json['taskType']) {
      case 'survey':
        thisTaskType = DrillTaskType.survey;
        break;
      case 'reqLocPerms':
        thisTaskType = DrillTaskType.reqLocPerms;
        break;
      case 'practiceEvac':
        thisTaskType = DrillTaskType.practiceEvac;
        break;
      case 'travel':
        thisTaskType = DrillTaskType.travel;
        break;
      case 'upload':
        thisTaskType = DrillTaskType.upload;
        break;
      default:
        throw FormatException(
            'Unrecognized DrillTaskType: ${json['taskType']}');
    }
    return DrillTaskPlan(
      taskID: json['taskID'],
      // index: json['index'],
      taskType: thisTaskType,
      title: json['title'],
      details: TaskDetailsPlan.fromJson(json),
    );
  }

  // @override
  // bool operator ==(Object other) {
  //   if (other.runtimeType != DrillTaskPlan) {
  //     print('other.runtimeType');
  //     return false;
  //   }
  //   other as DrillTaskPlan;
  //   // taskID
  //   if (taskID != other.taskID) {
  //     print('taskID');
  //     return false;
  //   }
  //   // taskType
  //   if (taskType != other.taskType) {
  //     print('taskType');
  //     return false;
  //   }
  //   // title
  //   if (title != other.title) {
  //     print('title');
  //     return false;
  //   }
  //   // details
  //   if (details != other.details) {
  //     print('details');
  //     return false;
  //   }

  //   return true;
  // }

  @override
  String toString() => toJson().toString();

  Map<String, dynamic> toJson() => {
        'taskID': taskID,
        // 'index': index,
        'taskType': taskType.name,
        'title': title,
        'details': details.toJson(),
      };

  List<MissingPlanParam> paramsMissing() {
    List<MissingPlanParam> missingParams = [];

    if (title == null || title!.isEmpty) {
      missingParams.add(MissingPlanParam('task.title'));
    }
    // details (recursive)
    for (final missingParam in details.paramsMissing()) {
      missingParams.add(MissingPlanParam(missingParam.field));
    }

    return missingParams;
  }
}
