import 'package:evac_app/models/drill_details/drill_details_type_enums.dart';
import 'package:evac_app/models/drill_details/drill_tasks/task_details/practice_evac_details.dart';
import 'package:evac_app/models/drill_details/drill_tasks/task_results/task_result.dart';
import 'package:evac_app/models/drill_results/drill_results.dart';
import 'package:path/path.dart';

class PracticeEvacResult extends TaskResult {
  static const DrillTaskType _taskType = DrillTaskType.practiceEvac;
  final String _taskID;
  final String drillID;
  final String title;
  final bool trackingLocation;
  final Map<String, dynamic> instructionsJson;
  DateTime startTime;
  DateTime endTime;
  Duration duration;
  double? distanceTravelled; // in (m)
  String? trajectoryFilePathOnDevice;
  String? trajectoryFilePathInResults;
  final bool completed;

  DrillTaskType taskType() => _taskType;
  String taskID() => _taskID;

  PracticeEvacResult(
      {required String taskID,
      required this.drillID,
      required this.title,
      required this.trackingLocation,
      required this.instructionsJson,
      required this.startTime,
      required this.endTime,
      required this.duration,
      required this.distanceTravelled,
      Future<String>? gpxFilePathFuture,
      required this.completed})
      : _taskID = taskID {
    if (gpxFilePathFuture != null)
      setTrajectoryFileFromFuture(gpxFilePathFuture);
  }

  void setTrajectoryFileFromFuture(Future<String> gpxFilePathFuture) async {
    String filePath = await gpxFilePathFuture;
    this.trajectoryFilePathOnDevice = filePath;
    this.trajectoryFilePathInResults = '$drillID-${basename(filePath)}';
  }

  Map<String, dynamic> toJson() => {
        'taskType': _taskType.name,
        'taskID': _taskID,
        'title': title,
        'trackingLocation': trackingLocation,
        'instructionsJson': instructionsJson,
        'startTime': startTime.toString(),
        'endTime': endTime.toString(),
        'duration': duration.toString(),
        'distanceTravelled': distanceTravelled,
        'trajectoryFilePathOnDevice': trajectoryFilePathOnDevice,
        'trajectoryFilePathOnDevice': trajectoryFilePathOnDevice,
        'trajectoryFilePathInResults': trajectoryFilePathInResults,
        'completed': completed,
      };
}

/// This function returns a function.
/// The returned function will properly set a SurveyTaskResult inside of the
/// provided DrillResults' taskResults member from anywhere (below the top-level
/// function call) in the widget tree.

// top-level function
Function makePracticeEvacResultSetter(DrillResults drillResults,
    PracticeEvacDetails practiceEvacDetails, Function pumpState) {
  // returned function
  void setPracticeEvacResult(
    DateTime startTime,
    DateTime endTime,
    Duration duration,
    double? distanceTravelled,
    Future<String> gpxFilePathFuture,
    bool completed,
  ) {
    // find out if there is already an `PracticeEvacResult` in `drillResults` with `taskID`
    bool havePracticeEvacResult = false;
    int? indexOfPracticeEvacRes;
    int index = 0;
    for (TaskResult taskResult in drillResults.taskResults) {
      if (taskResult.taskType() == DrillTaskType.practiceEvac) {
        if (taskResult.taskID() == practiceEvacDetails.taskID) {
          havePracticeEvacResult = true;
          indexOfPracticeEvacRes = index;
          break;
        }
      }
      index++;
    }

    // If there isn't a result yet, add one
    if (!havePracticeEvacResult) {
      drillResults.taskResults.add(
        PracticeEvacResult(
          taskID: practiceEvacDetails.taskID,
          drillID: drillResults.drillID,
          title: practiceEvacDetails.title,
          trackingLocation: practiceEvacDetails.trackingLocation,
          // locationTrackingAllowed?
          instructionsJson: practiceEvacDetails.instructionsJson,
          startTime: startTime,
          endTime: endTime,
          duration: duration,
          distanceTravelled: distanceTravelled,
          gpxFilePathFuture: gpxFilePathFuture,
          completed: completed,
        ),
      );
    }

    // otherwise, overwrite the one we already have
    else {
      if (indexOfPracticeEvacRes == null) {
        throw Exception(
            'setPracticeEvacResult: How did we not have an index set if there is already a result?');
      }
      drillResults.taskResults[indexOfPracticeEvacRes] = PracticeEvacResult(
        taskID: practiceEvacDetails.taskID,
        drillID: drillResults.drillID,
        title: practiceEvacDetails.title,
        trackingLocation: practiceEvacDetails.trackingLocation,
        // locationTrackingAllowed?
        instructionsJson: practiceEvacDetails.instructionsJson,
        startTime: startTime,
        endTime: endTime,
        duration: duration,
        distanceTravelled: distanceTravelled,
        gpxFilePathFuture: gpxFilePathFuture,
        completed: completed,
      );
    }
    pumpState(() => null);
  }

  return setPracticeEvacResult;
}
