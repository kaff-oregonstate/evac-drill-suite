// import 'package:evac_drill_console/models/evac_action_plans/evac_action_plan.dart';

// /// Not being implemented yet, as of 28 January 2023

// class CompletionActionPlan implements EvacActionPlan {
//   // static EvacActionType type = EvacActionType.completion;

//   get actionID => 'completion';

//   CompletionActionPlan();

//   factory CompletionActionPlan.fromJson(actionJson) {
//     if (actionJson['actionType'] != 'completion') {
//       throw FormatException(
//         "actionJson['actionType'] is ${actionJson['actionType']}, not 'completion'.",
//       );
//     }
//     return CompletionActionPlan();
//   }

//   @override
//   Map<String, dynamic> toJson() {
//     // Implement CompletionActionPlan.toJson()
//     return {};
//   }

//   @override
//   List<MissingPlanParam> paramsMissing() {
//     // Implement CompletionActionPlan.toJson()
//     return [];
//   }
// }
