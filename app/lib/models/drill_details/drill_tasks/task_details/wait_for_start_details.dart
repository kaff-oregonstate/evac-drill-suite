import 'package:evac_app/models/drill_details/drill_details_type_enums.dart';
import 'package:evac_app/models/drill_details/drill_tasks/task_details/task_details.dart';

class WaitForStartDetails extends TaskDetails {
  /// if(PracticeEvacDetails.trackingLocation)
  ///     `WaitForStart` task should also `AcquireGPS`
  final String taskID;
  // renamed from practiceEvacTaskID
  final String practiceEvacTaskID;
  final TypeOfWait typeOfWait;
  final Map<String, dynamic>? content;
  // that's right, there's potentially one more level required to do some tasks right. We could instead define three different `DrillTaskType`s for three current types of WaitForStart, but that complicates things too much on the backend (drill creation and whatnot).
  // for now, let's only implement `self` and make the other two throw `UnimplementedError`

  WaitForStartDetails({
    required this.taskID,
    required this.practiceEvacTaskID,
    required this.typeOfWait,
    this.content = null,
  });

  WaitForStartDetails.self({
    required this.taskID,
    required this.practiceEvacTaskID,
  })  : content = null,
        typeOfWait = TypeOfWait.self;

  WaitForStartDetails.example(this.taskID)
      : practiceEvacTaskID = 'abc123',
        content = null,
        typeOfWait = TypeOfWait.self;

  factory WaitForStartDetails.fromJson(Map<String, dynamic> json) {
    TypeOfWait thisType = TypeOfWait.values
        .firstWhere((e) => e.toString() == 'TypeOfWait.' + json['typeOfWait']);
    return WaitForStartDetails(
      taskID: json['taskID'],
      // HACK: use old label as backup for now
      practiceEvacTaskID:
          json['practiceEvacTaskID'] ?? json['practiceEvacTaskID'],
      typeOfWait: thisType,
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() => {
        'taskID': taskID,
        'practiceEvacTaskID': practiceEvacTaskID,
        'typeOfWait': typeOfWait.name,
        'content': content,
      };
}
