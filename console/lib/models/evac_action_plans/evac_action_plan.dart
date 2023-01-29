import 'package:evac_drill_console/models/evac_action_plans/instruction_action_plan.dart';
import 'package:evac_drill_console/models/evac_action_plans/wait_for_start_action_plan.dart';
import 'package:evac_drill_console/models/missing_plan_param.dart';
export 'package:evac_drill_console/models/evac_action_plans/instruction_action_plan.dart';
export 'package:evac_drill_console/models/evac_action_plans/wait_for_start_action_plan.dart';
export 'package:evac_drill_console/models/missing_plan_param.dart';

enum EvacActionType {
  instruction,
  waitForStart,
  // ¿compeletion?
}

abstract class EvacActionPlan {
  Map<String, dynamic> toJson();
  List<MissingPlanParam> paramsMissing();

  factory EvacActionPlan.fromJson(Map<String, dynamic> actionJson) {
    switch (actionJson['actionType'] as String) {
      case 'instruction':
        return InstructionActionPlan.fromJson(actionJson);
      case 'waitForStart':
        return WaitForStartActionPlan.fromJson(actionJson);
      // case 'completion':
      //   return CompletionActionPlan.fromJson(actionJson);
      default:
        // Error: Unrecognized EvacActionType
        throw const FormatException('Unrecognized EvacActionType');
    }
  }
}
