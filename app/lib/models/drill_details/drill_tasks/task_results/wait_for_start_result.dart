import 'package:evac_app/models/drill_details/drill_details_type_enums.dart';
import 'package:evac_app/models/drill_details/drill_tasks/task_details/wait_for_start_details.dart';
import 'package:evac_app/models/drill_details/drill_tasks/task_results/task_result.dart';
import 'package:evac_app/models/drill_results/drill_results.dart';

class WaitForStartResult extends TaskResult {
  static const DrillTaskType _taskType = DrillTaskType.waitForStart;
  final String _taskID;
  // renamed from `practiceEvacTaskID`
  final String practiceEvacTaskID;
  final TypeOfWait typeOfWait;
  final bool complete;

  DrillTaskType taskType() => _taskType;
  String taskID() => _taskID;

  WaitForStartResult({
    required String taskID,
    required this.practiceEvacTaskID,
    required this.complete,
  })  : typeOfWait = TypeOfWait.self,
        _taskID = taskID;

  Map<String, dynamic> toJson() => {
        'taskType': _taskType.name,
        'taskID': _taskID,
        'practiceEvacTaskID': practiceEvacTaskID,
        'typeOfWait': typeOfWait.name,
        'complete': complete,
      };
}

/// This function returns a function.
/// The returned function will properly set a SurveyTaskResult inside of the
/// provided DrillResults' taskResults member from anywhere (below the top-level
/// function call) in the widget tree.

// top-level function:
Function makeWaitForStartResultSetter(DrillResults drillResults,
    WaitForStartDetails waitForStartDetails, Function pumpState) {
  // returned function:
  void setWaitForStartResult(bool result) {
    // find out if there is already an `WaitForStartResult` in `drillResults` with `taskID`
    bool haveWaitForStartResult = false;
    int? indexOfWaitForStartRes;
    int index = 0;
    for (TaskResult taskResult in drillResults.taskResults) {
      print(taskResult.taskType());
      if (taskResult.taskType() == DrillTaskType.waitForStart) {
        if (taskResult.taskID() == waitForStartDetails.taskID) {
          haveWaitForStartResult = true;
          indexOfWaitForStartRes = index;
          break;
        }
      }
      index++;
    }

    // If there isn't a result yet, add one
    if (!haveWaitForStartResult) {
      drillResults.taskResults.add(
        WaitForStartResult(
          taskID: waitForStartDetails.taskID,
          practiceEvacTaskID: waitForStartDetails.practiceEvacTaskID,
          complete: result,
        ),
      );
    }

    // otherwise, overwrite the one we already have
    else {
      if (indexOfWaitForStartRes == null) {
        throw Exception(
            'setWaitForStartResult: How did we not have an index set if there is already a result?');
      }
      drillResults.taskResults[indexOfWaitForStartRes] = WaitForStartResult(
        taskID: waitForStartDetails.taskID,
        practiceEvacTaskID: waitForStartDetails.practiceEvacTaskID,
        complete: result,
      );
    }
    pumpState(() => null);
  }

  return setWaitForStartResult;
}
