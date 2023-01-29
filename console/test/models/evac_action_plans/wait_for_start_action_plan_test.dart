import 'package:evac_drill_console/models/evac_action_plans/wait_for_start_action_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWaitForStartActionPlan();
}

void testWaitForStartActionPlan() {
  test(
    'WaitForStartActionPlan.fromJson(invalid) throws FormatException',
    () => expect(() => WaitForStartActionPlan.fromJson(WFSAX.invalidCase),
        throwsFormatException),
  );

  test(
    'WaitForStartActionPlan.fromJson(null actionID) throws FormatException',
    () => expect(() => WaitForStartActionPlan.fromJson(WFSAX.nullID),
        throwsFormatException),
  );

  test(
    'WaitForStartActionPlan.fromJson(noWaitType) throws FormatException',
    () => expect(() => WaitForStartActionPlan.fromJson(WFSAX.noWaitType),
        throwsFormatException),
  );

  group('WaitForStartActionPlan.fromJson(happyCase)', () {
    // import from example EvacActionPlanJson using WaitForStartActionPlan.fromJson
    final wFSAP = WaitForStartActionPlan.fromJson(WFSAX.happyCase);
    test(
      'actionID matches',
      () => expect(wFSAP.actionID, equals(WFSAX.happyCase['actionID'])),
    );
    // test(
    //   'practiceEvacTaskID matches',
    //   () => expect(wFSAP.practiceEvacTaskID,
    //       equals(WFSAX.happyCase['practiceEvacTaskID'])),
    // );
    test(
      'waitType matches',
      () => expect(wFSAP.waitType.name, equals(WFSAX.happyCase['waitType'])),
    );
    test('.paramsMissing() returns empty',
        () => expect(wFSAP.paramsMissing(), isEmpty));
  });

  group('WaitForStartActionPlan.toJson(happyCase)', () {
    // import from example EvacActionPlanJson using WaitForStartActionPlan.fromJson
    final wFSAP = WaitForStartActionPlan.fromJson(WFSAX.happyCase);
    // Export to EvacActionPlanJson using WaitForStartActionPlan.toJson
    final evacActionPlanJsonResult = wFSAP.toJson();

    test(
      'actionID matches',
      () => expect(evacActionPlanJsonResult['actionID'],
          equals(WFSAX.happyCase['actionID'])),
    );
    test(
      'actionType matches',
      () => expect(evacActionPlanJsonResult['actionType'],
          equals(WFSAX.happyCase['actionType'])),
    );
    // test(
    //   'practiceEvacTaskID matches',
    //   () => expect(evacActionPlanJsonResult['practiceEvacTaskID'],
    //       equals(WFSAX.happyCase['practiceEvacTaskID'])),
    // );
    test(
      'waitType matches',
      () => expect(evacActionPlanJsonResult['waitType'],
          equals(WFSAX.happyCase['waitType'])),
    );
  });
}

/// Example JSON inputs for WaitForStartActionPlan
class WFSAX {
  // invalidCase
  static const Map<String, dynamic> invalidCase = {
    'actionID': 'exampleID-abc',
    'actionType': 'instruction',
    'text': 'An instruction which will never be given 🤷‍♂️',
  };
  // nullID
  static const Map<String, dynamic> nullID = {
    // 'actionID': null,
    'actionType': 'waitForStart',
    'waitType': 'self',
  };
  // // nullPETid
  // static const Map<String, dynamic> nullPETid = {
  //   'actionID': 'exampleID-abc',
  //   'actionType': 'waitForStart',
  //   'waitType': 'self',
  //   'practiceEvacTaskID': null,
  // };
  // noWaitType
  static const Map<String, dynamic> noWaitType = {
    'actionID': 'exampleID-abc',
    'actionType': 'waitForStart',
    // 'waitType': null,
  };
  // happyCase
  static const Map<String, dynamic> happyCase = {
    'actionID': 'exampleID-abc',
    'actionType': 'waitForStart',
    'waitType': 'self',
  };
}
