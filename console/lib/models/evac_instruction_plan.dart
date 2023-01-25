import 'package:evac_drill_console/models/missing_plan_param.dart';
import 'package:uuid/uuid.dart';

class EvacInstructionPlan {
  final String id;
  String? text;

  EvacInstructionPlan({
    id,
    this.text,
  }) : id = id ?? const Uuid().v4();

  factory EvacInstructionPlan.fromJson(instructionJson) {
    if (instructionJson['id'] == null) {
      throw const FormatException('No id in EvacInstructionPlan');
    }
    return EvacInstructionPlan(
      id: instructionJson['id'],
      text: instructionJson['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
    };
  }

  List<MissingPlanParam> paramsMissing() =>
      (text == null || text!.isEmpty) ? [MissingPlanParam('$id.text')] : [];
}
