import 'package:evac_drill_console/models/task_details_plans/req_loc_perms_details_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testReqLocPermsDetailsPlan();
}

void testReqLocPermsDetailsPlan() {
  test(
    'ReqLocPermsDetailsPlan.fromJson(invalid) throws FormatException',
    () => expect(() => ReqLocPermsDetailsPlan.fromJson(RLPDX.invalidCase),
        throwsFormatException),
  );

  test(
    'ReqLocPermsDetailsPlan.fromJson(null taskID) throws FormatException',
    () => expect(() => ReqLocPermsDetailsPlan.fromJson(RLPDX.nullID),
        throwsFormatException),
  );

  group('ReqLocPermsDetailsPlan.fromJson(happyCase)', () {
    // import from example DrillTaskPlanJson using ReqLocPermsDetailsPlan.fromJson
    final rLPDP = ReqLocPermsDetailsPlan.fromJson(RLPDX.happyCase);
    test(
      'taskID matches',
      () => expect(rLPDP.taskID, equals(RLPDX.happyCase['details']['taskID'])),
    );
    test('.paramsMissing() returns empty',
        () => expect(rLPDP.paramsMissing(), isEmpty));
  });

  group('ReqLocPermsDetailsPlan.toJson(happyCase)', () {
    // import from example DrillTaskPlanJson using ReqLocPermsDetailsPlan.fromJson
    final rLPDP = ReqLocPermsDetailsPlan.fromJson(RLPDX.happyCase);
    // Export to TaskDetailsPlanJson using ReqLocPermsDetailsPlan.toJson
    final taskDetailsPlanJsonResult = rLPDP.toJson();

    test(
        'taskID matches',
        () => expect(taskDetailsPlanJsonResult['taskID'],
            equals(RLPDX.happyCase['details']['taskID'])));
  });
}

/// Example JSON inputs for ReqLocPermsDetailsPlan
class RLPDX {
  // invalidCase
  static const Map<String, dynamic> invalidCase = {
    'taskID': 'exampleID-abc',
    'taskType': 'survey',
    'title': 'A survey which will never be taken 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
    },
  };
  // nullID
  static const Map<String, dynamic> nullID = {
    'taskID': 'exampleID-abc',
    'taskType': 'reqLocPerms',
    'title': 'A location permissions request which will never be asked 🤷‍♂️',
    'details': {
      // 'taskID': 'exampleID-abc',
    },
  };
  // happyCase
  static const Map<String, dynamic> happyCase = {
    'taskID': 'exampleID-abc',
    'taskType': 'reqLocPerms',
    'title': 'A location permissions request which will never be asked 🤷‍♂️',
    'details': {
      'taskID': 'exampleID-abc',
    },
  };
}
