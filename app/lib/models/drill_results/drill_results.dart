import 'package:evac_app/models/drill_details/drill_details_type_enums.dart';
import 'package:evac_app/models/drill_details/drill_tasks/task_results/practice_evac_result.dart';
import 'package:evac_app/models/drill_details/drill_tasks/task_results/task_result.dart';

/// To hold all of these `[_task_]Result`s, along with meta-info (userID, drillID), we will redefine the DrillResults model as follows

class DrillResults {
  final String drillID;
  final String userID;
  final String publicKey;
  List<TaskResult> taskResults;

  late List<String> gpxFiles;

  DrillResults(
      {required this.drillID, required this.userID, required this.publicKey})
      : taskResults = [];

  void assembleGpxFilesList() {
    gpxFiles = [];
    for (var result in taskResults) {
      if (result.taskType() == DrillTaskType.practiceEvac) {
        final practiceEvacResult = result as PracticeEvacResult;
        if (practiceEvacResult.trajectoryFilePathOnDevice != null)
          gpxFiles.add(practiceEvacResult.trajectoryFilePathOnDevice!);
      }
    }
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> taskResultsJsonList = [];
    for (var taskResult in taskResults) {
      taskResultsJsonList.add(taskResult.toJson());
    }
    if (taskResultsJsonList.isEmpty) {
      print(
          'DrillResults: either no tasks completed or unable to parse any taskResults to json');
    }
    return {
      'drillID': drillID,
      'userID': userID,
      'taskResults': taskResultsJsonList,
    };
  }
}
