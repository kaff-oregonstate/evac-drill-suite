import 'package:evac_drill_console/models/evac_instruction_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testEvacInstructionPlan();
}

void testEvacInstructionPlan() {
  test(
    'EvacInstructionPlan.fromJson(invalid) throws FormatException',
    () => expect(() => EvacInstructionPlan.fromJson(EIPX.invalidCase),
        throwsFormatException),
  );

  test(
    'EvacInstructionPlan.fromJson(nullID) throws FormatException',
    () => expect(
        () => EvacInstructionPlan.fromJson(EIPX.nullID), throwsFormatException),
  );

  group('EvacInstructionPlan.fromJson(nullText)', () {
    // import from example DrillTaskPlanJson using EvacInstructionPlan.fromJson
    final eIP = EvacInstructionPlan.fromJson(EIPX.nullText);
    test('id matches', () => expect(eIP.id, equals(EIPX.nullText['id'])));
    test('text is null', () => expect(eIP.text, isNull));

    final missingParams = eIP.paramsMissing();
    test('.paramsMissing() is not empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 1',
        () => expect(missingParams.length, equals(1)));
  });

  group('EvacInstructionPlan.toJson(nullText)', () {
    // import from example DrillTaskPlanJson using EvacInstructionPlan.fromJson
    final eIP = EvacInstructionPlan.fromJson(EIPX.nullText);
    // Export to EvacInstructionJson using EvacInstructionPlan.toJson
    final eIPJsonResult = eIP.toJson();

    test('id matches',
        () => expect(eIPJsonResult['id'], equals(EIPX.nullText['id'])));
    test('text is still null', () => expect(eIPJsonResult['text'], isNull));
  });

  group('EvacInstructionPlan.fromJson(emptyText)', () {
    // import from example DrillTaskPlanJson using EvacInstructionPlan.fromJson
    final eIP = EvacInstructionPlan.fromJson(EIPX.emptyText);
    test('id matches', () => expect(eIP.id, equals(EIPX.emptyText['id'])));
    test('text is empty', () => expect(eIP.text, isEmpty));

    final missingParams = eIP.paramsMissing();
    test('.paramsMissing() is not empty',
        () => expect(missingParams, isNotEmpty));
    test('.paramsMissing() returns 1',
        () => expect(missingParams.length, equals(1)));
  });

  group('EvacInstructionPlan.toJson(emptyText)', () {
    // import from example DrillTaskPlanJson using EvacInstructionPlan.fromJson
    final eIP = EvacInstructionPlan.fromJson(EIPX.emptyText);
    // Export to EvacInstructionJson using EvacInstructionPlan.toJson
    final eIPJsonResult = eIP.toJson();

    test('id matches',
        () => expect(eIPJsonResult['id'], equals(EIPX.emptyText['id'])));
    test('text is still empty', () => expect(eIPJsonResult['text'], isEmpty));
  });

  group('EvacInstructionPlan.fromJson(happyCase)', () {
    // import from example DrillTaskPlanJson using EvacInstructionPlan.fromJson
    final eIP = EvacInstructionPlan.fromJson(EIPX.happyCase);
    test('id matches', () => expect(eIP.id, equals(EIPX.happyCase['id'])));
    test(
      'text matches',
      () => expect(eIP.text, equals(EIPX.happyCase['text'])),
    );
    test('.paramsMissing() is empty',
        () => expect(eIP.paramsMissing(), isEmpty));
  });

  group('EvacInstructionPlan.toJson(happyCase)', () {
    // import from example DrillTaskPlanJson using EvacInstructionPlan.fromJson
    final eIP = EvacInstructionPlan.fromJson(EIPX.happyCase);
    // Export to EvacInstructionJson using EvacInstructionPlan.toJson
    final eIPJsonResult = eIP.toJson();

    test('id matches',
        () => expect(eIPJsonResult['id'], equals(EIPX.happyCase['id'])));
    test('text matches',
        () => expect(eIPJsonResult['text'], equals(EIPX.happyCase['text'])));
  });
}

/// Example JSON inputs for EvacInstructionPlan
class EIPX {
  // invalidCase
  static const Map<String, dynamic> invalidCase = {
    'taskID': 'exampleID-abc',
    'text': 'An evacuation instruction which will never be given 🤷‍♂️',
  };
  // nullID
  static const Map<String, dynamic> nullID = {
    // 'id': null,
    'text': 'An evacuation instruction which will never be given 🤷‍♂️',
  };
  // nullText
  static const Map<String, dynamic> nullText = {
    'id': 'exampleID-abc',
    // 'text': null,
  };
  // emptyText
  static const Map<String, dynamic> emptyText = {
    'id': 'exampleID-abc',
    'text': '',
  };
  // happyCase
  static const Map<String, dynamic> happyCase = {
    'id': 'exampleID-abc',
    'text': 'An evacuation instruction which will never be given 🤷‍♂️',
  };
}
