import 'package:evac_drill_console/models/evac_instruction_plan.dart';
import 'package:evac_drill_console/models/task_details_plans/task_details_plan.dart';

/// Defines the task detail for DrillTaskPlan of DrillTaskType `practiceEvac`

class PracticeEvacDetailsPlan implements TaskDetailsPlan {
  static const taskType = DrillTaskType.practiceEvac;
  final String taskID;
  // TODO: Add title field to PDEvacInstructions (this title is displayed during the practice evacuation)
  // i.e. it isn't the same as the DrillTask(plan) title
  String? title;
  bool? trackingLocation;
  List<EvacInstructionPlan> instructions;

  PracticeEvacDetailsPlan({
    taskID,
    this.title,
    this.trackingLocation,
    this.instructions = const [],
  }) : taskID = taskID ?? const Uuid().v4();

  factory PracticeEvacDetailsPlan.fromJson(taskJson) {
    if (taskJson['taskType'] != taskType.name) {
      throw FormatException(
          'Incorrect taskType on `practiceEvac`: ${taskJson['taskType']}');
    }
    final json = taskJson['details'] as Map<String, dynamic>;
    if (json['taskID'] == null) {
      throw const FormatException('No PracticeEvacDetailsPlan.taskID??');
    }
    return PracticeEvacDetailsPlan(
      taskID: json['taskID'],
      title: json['title'],
      trackingLocation: json['trackingLocation'],
      instructions: _listFromJson(json['instructionsJson']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'taskID': taskID,
      'title': title,
      'trackingLocation': trackingLocation,
      // HACK: There's really no reason to wrap this twice? If we fix the app as well then we could be done with this…
      'instructionsJson': {
        'instructions': _jsonFromList(instructions),
      },
    };
  }

  @override
  List<MissingPlanParam> paramsMissing() {
    List<MissingPlanParam> missingParams = [];

    if (title == null || title!.isEmpty) {
      missingParams.add(MissingPlanParam('practiceEvac.$taskID.title'));
    }
    if (instructions.isEmpty) {
      missingParams.add(MissingPlanParam('practiceEvac.$taskID.instructions'));
    }
    if (trackingLocation == null) {
      missingParams
          .add(MissingPlanParam('practiceEvac.$taskID.trackingLocation'));
    }

    for (var i = 0; i < instructions.length; i++) {
      final instructionMissingParams = instructions[i].paramsMissing();
      for (final missingParam in instructionMissingParams) {
        // HACK: what should the `field` string of a practiceEvac be for MissingPlanParam? (currently: 'practiceEvac.$taskID')
        // FIXME: currently using both index (here: `$i`) and {instruction}`id` (there: `$id`). Choose one.
        missingParams.add(
            MissingPlanParam('practiceEvac.$taskID[$i].${missingParam.field}'));
      }
    }

    return missingParams;
  }
}

List<Map<String, dynamic>> _jsonFromList(
    List<EvacInstructionPlan> instructions) {
  List<Map<String, dynamic>> instructionsJsonList = [];
  for (final instruction in instructions) {
    instructionsJsonList.add(instruction.toJson());
  }
  return instructionsJsonList;
}

List<EvacInstructionPlan> _listFromJson(instructionsJson) {
  final List<Map<String, dynamic>> instructionsJsonList =
      instructionsJson['instructions'];
  List<EvacInstructionPlan> instructions = [];
  for (final instructionJson in instructionsJsonList) {
    instructions.add(EvacInstructionPlan.fromJson(instructionJson));
  }
  return instructions;
}
