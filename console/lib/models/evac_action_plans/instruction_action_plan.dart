import 'package:evac_drill_console/models/evac_action_plans/evac_action_plan.dart';
import 'package:uuid/uuid.dart';

class InstructionActionPlan implements EvacActionPlan {
  @override
  final EvacActionType actionType = EvacActionType.instruction;
  @override
  final String actionID;
  String? text;

  InstructionActionPlan({
    actionID,
    this.text,
  }) : actionID = actionID ?? const Uuid().v4();

  factory InstructionActionPlan.fromJson(actionJson) {
    if (actionJson['actionType'] != 'instruction') {
      throw FormatException(
        "actionJson['actionType'] is ${actionJson['actionType']}, not 'instruction'.",
      );
    }
    if (actionJson['actionID'] == null) {
      throw const FormatException('No actionID in InstructionActionPlan');
    }
    return InstructionActionPlan(
      actionID: actionJson['actionID'],
      text: actionJson['text'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': actionType.name,
      'actionID': actionID,
      'text': text,
    };
  }

  @override
  List<MissingPlanParam> paramsMissing() {
    if (text == null || text!.isEmpty) {
      return [MissingPlanParam('instruction.text')];
    }
    return [];
  }
}
