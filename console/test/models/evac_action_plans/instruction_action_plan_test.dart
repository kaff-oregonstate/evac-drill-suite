import 'package:evac_drill_console/models/evac_action_plans/instruction_action_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testInstructionActionPlan();
}

void testInstructionActionPlan() {
  test(
    'InstructionActionPlan.fromJson(invalid) throws FormatException',
    () => expect(() => InstructionActionPlan.fromJson(EIAX.invalidCase),
        throwsFormatException),
  );

  test(
    'InstructionActionPlan.fromJson(nullID) throws FormatException',
    () => expect(() => InstructionActionPlan.fromJson(EIAX.nullID),
        throwsFormatException),
  );

  group('InstructionActionPlan.fromJson(nullText)', () {
    // import from example DrillTaskPlanJson using InstructionActionPlan.fromJson
    final iAP = InstructionActionPlan.fromJson(EIAX.nullText);
    test('actionID matches',
        () => expect(iAP.actionID, equals(EIAX.nullText['actionID'])));
    test('text is null', () => expect(iAP.text, isNull));

    final missingParams = iAP.paramsMissing();
    test('.paramsMissing() is not empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 1',
        () => expect(missingParams.length, equals(1)));
  });

  group('InstructionActionPlan.toJson(nullText)', () {
    // import from example DrillTaskPlanJson using InstructionActionPlan.fromJson
    final iAP = InstructionActionPlan.fromJson(EIAX.nullText);
    // Export to EvacActionPlanJson using InstructionActionPlan.toJson
    final evacActionPlanJsonResult = iAP.toJson();

    test(
        'actionID matches',
        () => expect(evacActionPlanJsonResult['actionID'],
            equals(EIAX.nullText['actionID'])));
    test(
      'actionType matches',
      () => expect(evacActionPlanJsonResult['actionType'],
          equals(EIAX.nullText['actionType'])),
    );
    test('text is still null',
        () => expect(evacActionPlanJsonResult['text'], isNull));
  });

  group('InstructionActionPlan.fromJson(emptyText)', () {
    // import from example DrillTaskPlanJson using InstructionActionPlan.fromJson
    final iAP = InstructionActionPlan.fromJson(EIAX.emptyText);
    test('actionID matches',
        () => expect(iAP.actionID, equals(EIAX.emptyText['actionID'])));
    test('text is empty', () => expect(iAP.text, isEmpty));

    final missingParams = iAP.paramsMissing();
    test('.paramsMissing() is not empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 1',
        () => expect(missingParams.length, equals(1)));
  });

  group('InstructionActionPlan.toJson(emptyText)', () {
    // import from example DrillTaskPlanJson using InstructionActionPlan.fromJson
    final iAP = InstructionActionPlan.fromJson(EIAX.emptyText);
    // Export to EvacActionPlanJson using InstructionActionPlan.toJson
    final evacActionPlanJsonResult = iAP.toJson();

    test(
        'actionID matches',
        () => expect(evacActionPlanJsonResult['actionID'],
            equals(EIAX.emptyText['actionID'])));
    test(
      'actionType matches',
      () => expect(evacActionPlanJsonResult['actionType'],
          equals(EIAX.emptyText['actionType'])),
    );
    test('text is still empty',
        () => expect(evacActionPlanJsonResult['text'], isEmpty));
  });

  group('InstructionActionPlan.fromJson(happyCase)', () {
    // import from example DrillTaskPlanJson using InstructionActionPlan.fromJson
    final iAP = InstructionActionPlan.fromJson(EIAX.happyCase);
    test('actionID matches',
        () => expect(iAP.actionID, equals(EIAX.happyCase['actionID'])));
    test(
      'text matches',
      () => expect(iAP.text, equals(EIAX.happyCase['text'])),
    );
    test('.paramsMissing() is empty',
        () => expect(iAP.paramsMissing(), isEmpty));
  });

  group('InstructionActionPlan.toJson(happyCase)', () {
    // import from example DrillTaskPlanJson using InstructionActionPlan.fromJson
    final iAP = InstructionActionPlan.fromJson(EIAX.happyCase);
    // Export to EvacActionPlanJson using InstructionActionPlan.toJson
    final evacActionPlanJsonResult = iAP.toJson();

    test(
        'actionID matches',
        () => expect(evacActionPlanJsonResult['actionID'],
            equals(EIAX.happyCase['actionID'])));
    test(
      'actionType matches',
      () => expect(evacActionPlanJsonResult['actionType'],
          equals(EIAX.happyCase['actionType'])),
    );
    test(
        'text matches',
        () => expect(
            evacActionPlanJsonResult['text'], equals(EIAX.happyCase['text'])));
  });
}

/// Example JSON inputs for InstructionActionPlan
class EIAX {
  // invalidCase
  static const Map<String, dynamic> invalidCase = {
    'actionType': 'waitForStart',
    'actionID': 'exampleID-abc',
    'waitType': 'self',
    // 'text': 'An wait for start action that will never be completed 🤷‍♂️',
  };
  // nullID
  static const Map<String, dynamic> nullID = {
    'actionType': 'instruction',
    // 'actionID': null,
    'text': 'An evacuation instruction which will never be given 🤷‍♂️',
  };
  // nullText
  static const Map<String, dynamic> nullText = {
    'actionType': 'instruction',
    'actionID': 'exampleID-abc',
    // 'text': null,
  };
  // emptyText
  static const Map<String, dynamic> emptyText = {
    'actionType': 'instruction',
    'actionID': 'exampleID-abc',
    'text': '',
  };
  // happyCase
  static const Map<String, dynamic> happyCase = {
    'actionType': 'instruction',
    'actionID': 'exampleID-abc',
    'text': 'An evacuation instruction which will never be given 🤷‍♂️',
  };
}
