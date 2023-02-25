import 'package:evac_app/models/drill_details/drill_tasks/task_details/task_details.dart';
import 'package:evac_app/models/instructions/instructions.dart';

class PracticeEvacDetails extends TaskDetails {
  final String taskID;
  final String title;
  final bool trackingLocation;
  final Map<String, dynamic> instructionsJson;
  // outputFormat String?,
  //               enum oF{GPX,GEOJSON,RAW}?,

  PracticeEvacDetails({
    required this.taskID,
    required this.title,
    required this.trackingLocation,
    required this.instructionsJson,
  });

  PracticeEvacDetails.example(this.taskID)
      : title = 'Tsunami Evacuation Drill from Beach',
        trackingLocation = true,
        instructionsJson = Instructions.example().toJson();

  factory PracticeEvacDetails.fromJson(Map<String, dynamic> json) =>
      PracticeEvacDetails(
        taskID: json['taskID'],
        title: json['title'],
        trackingLocation: json['trackingLocation'],
        instructionsJson: json['instructionsJson'],
      );

  Map<String, dynamic> toJson() => {
        'taskID': taskID,
        'title': title,
        'trackingLocation': trackingLocation,
        'instructionsJson': instructionsJson,
      };
}
