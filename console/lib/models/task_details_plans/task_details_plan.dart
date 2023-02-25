import 'package:evac_drill_console/models/missing_plan_param.dart';

import 'package:evac_drill_console/models/task_details_plans/practice_evac_details_plan.dart'
    show PracticeEvacDetailsPlan;
import 'package:evac_drill_console/models/task_details_plans/req_loc_perms_details_plan.dart';
import 'package:evac_drill_console/models/task_details_plans/survey_details_plan.dart'
    show SurveyDetailsPlan;
import 'package:evac_drill_console/models/task_details_plans/travel_details_plan.dart';
import 'package:evac_drill_console/models/task_details_plans/upload_details_plan.dart';
export 'package:evac_drill_console/models/task_details_plans/practice_evac_details_plan.dart'
    show PracticeEvacDetailsPlan;
export 'package:evac_drill_console/models/task_details_plans/req_loc_perms_details_plan.dart';
export 'package:evac_drill_console/models/task_details_plans/survey_details_plan.dart'
    show SurveyDetailsPlan;
export 'package:evac_drill_console/models/task_details_plans/travel_details_plan.dart';
export 'package:evac_drill_console/models/task_details_plans/upload_details_plan.dart';

export 'package:evac_drill_console/models/missing_plan_param.dart';
export 'package:evac_drill_console/models/drill_task_plan.dart'
    show DrillTaskType;
export 'package:uuid/uuid.dart' show Uuid;

/// Abstract class which typed DrillTaskPlans implement to describe their
/// details

abstract class TaskDetailsPlan {
  Map<String, dynamic> toJson();
  List<MissingPlanParam> paramsMissing();

  String get taskID;

  factory TaskDetailsPlan.fromJson(
    Map<String, dynamic> taskJson,
  ) {
    switch (taskJson['taskType'] as String) {
      case 'survey':
        return SurveyDetailsPlan.fromJson(taskJson);
      case 'reqLocPerms':
        return ReqLocPermsDetailsPlan.fromJson(taskJson);
      case 'practiceEvac':
        return PracticeEvacDetailsPlan.fromJson(taskJson);
      case 'travel':
        return TravelDetailsPlan.fromJson(taskJson);
      case 'upload':
        return UploadDetailsPlan.fromJson(taskJson);
      default:
        // Error: Unrecognized TaskDetailsPlan
        throw const FormatException(
            'Unrecognized TaskDetailsPlan DrillTaskType');
    }
  }
}
