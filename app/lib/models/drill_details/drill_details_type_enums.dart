/// If this app is developed further, there may be multiple types of drills. Lets define the types as such:

enum DrillType { TSUNAMI }

/// Drill task types range from "tapping a button" to "moving to a new location irl", and are defined more formally below in the DrillTaskType enum.

enum DrillTaskType {
  survey,
  reqLocPerms,
  waitForStart,
  practiceEvac,
  travel,
  upload,
}

extension DrillTaskTypeName on DrillTaskType {
  String get actionName {
    switch (this) {
      case DrillTaskType.survey:
        return 'Complete survey';
      case DrillTaskType.reqLocPerms:
        return 'Allow location tracking';
      case DrillTaskType.waitForStart:
        return 'Wait for evacuation start';
      case DrillTaskType.practiceEvac:
        return 'Practice evacuating';
      case DrillTaskType.travel:
        return 'Travel to location';
      case DrillTaskType.upload:
        return 'Conclude drill';
      default:
        throw Exception('INTERNAL: Unknown DrillTaskType on .actionName');
    }
  }
}

// enum DrillTaskType {
//   SURVEY,
//   ALLOW_LOCATION_PERMISSIONS,
//   WAIT_FOR_START,
//   PERFORM_DRILL,
//   TRAVEL,
//   UPLOAD,
// }

/// We want to give researchers options on how they start their participants performing drills. Let's define the types of starts as such:

enum TypeOfWait {
  // synchronized,
  // signal,
  self,
}
