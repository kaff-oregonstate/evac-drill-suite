import 'package:evac_drill_console/models/missing_plan_param.dart';
export 'package:evac_drill_console/models/missing_plan_param.dart';

/// Abstract class which typed DrillTaskPlans implement to describe their
/// details

abstract class TaskDetailsPlan {
  Map<String, dynamic> toJson();
  List<MissingPlanParam> paramsMissing();
}
