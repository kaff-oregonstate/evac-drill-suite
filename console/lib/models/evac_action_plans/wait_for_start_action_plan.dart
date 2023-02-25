import 'package:evac_drill_console/models/evac_action_plans/evac_action_plan.dart';
import 'package:uuid/uuid.dart';

/// The types of WaitForStart EvacActions (currently only `self`)

enum WaitType {
  // synchronized,
  // signal,
  self,
}

extension WaitName on WaitType {
  String get fullName {
    switch (this) {
      case WaitType.self:
        return 'Self-Start';
      default:
        throw Exception('Internal: bad WaitType on .fullName');
    }
  }
}

class WaitForStartActionPlan implements EvacActionPlan {
  @override
  final EvacActionType actionType = EvacActionType.waitForStart;
  @override
  final String actionID;
  WaitType waitType;
  // are the following ever needed?
  // final String practiceEvacTaskID;
  // String? text;

  WaitForStartActionPlan({actionID, waitType})
      : waitType = waitType ?? WaitType.self,
        actionID = actionID ?? const Uuid().v4();

  factory WaitForStartActionPlan.fromJson(json) {
    if (json['actionType'] != 'waitForStart') {
      throw FormatException(
          "json['actionType'] is ${json['actionType']}, not 'waitForStart'.");
    }
    if (json['actionID'] == null) {
      throw const FormatException("json['actionID'] is null");
    }
    if (json['waitType'] == null || json['waitType'] != 'self') {
      throw FormatException(
          "json['waitType'] is ${json['waitType']}, not 'self'.");
    }
    WaitType thisWaitType;
    switch (json['typeOfWait']) {
      case 'self':
        thisWaitType = WaitType.self;
        break;
      default:
        thisWaitType = WaitType.self;
    }
    return WaitForStartActionPlan(
        actionID: json['actionID'], waitType: thisWaitType);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': actionType.name,
      'actionID': actionID,
      'waitType': waitType.name,
    };
  }

  @override
  List<MissingPlanParam> paramsMissing() {
    // No params, return empty list
    return [];
  }
}
