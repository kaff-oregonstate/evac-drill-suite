import 'package:evac_drill_console/models/evac_action_plans/evac_action_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testEvacActionPlan();
}

/// Tests the EvacActionPlan abstract Data Model
void testEvacActionPlan() {
  // test bad formatting passed into .fromJson to confirm throwFormatException
  test(
    'EvacActionPlan.fromJson(invalidType) throws FormatException',
    () => expect(
        () => EvacActionPlan.fromJson(EAPX.invalidType), throwsFormatException),
  );

  // test each type passed into .fromJson
  group('EvacActionPlan.fromJson()', () {
    for (var entry in EAPX.validCases.entries) {
      final thisStepPlan = EvacActionPlan.fromJson(entry.value);
      // final thisType = EAPX.types[entry.key]!;
      test(
        entry.key.name,
        () => expect(thisStepPlan.runtimeType, equals(EAPX.types[entry.key])),

        /// Attempting to follow guidance here:
        /// https://dart.dev/guides/language/language-tour#getting-an-objects-type
        /// But it doesn't work…
        ///     Type in `isA<T>()` can't be defined programmatically?
        // () => expect(thisStepPlan, isA<thisType>()),
      );
    }
  });
}

/// Example JSON inputs for EvacActionPlan
class EAPX {
  static const Map<String, dynamic> invalidType = {
    'actionType': 'SGLewis',
    'title': 'Lifetime',
    'text': 'https://open.spotify.com/track/1msgEd8W5hBZAOmd3s9hC0',
  };
  static const Map<EvacActionType, Map<String, dynamic>> validCases = {
    EvacActionType.waitForStart: {
      'actionType': 'waitForStart',
      'actionID': 'example-ID-abc',
      'waitType': 'self',
    },
    EvacActionType.instruction: {
      'actionType': 'instruction',
      'actionID': 'example-ID-abc',
      'text': 'example instruction action text',
    },
    // EvacActionType.completion: {
    //   'actionType': 'completion',
    //   'actionID': 'example-ID-abc',
    //   'text': 'example step text',
    // },
  };
  static const Map<EvacActionType, Type> types = {
    EvacActionType.waitForStart: WaitForStartActionPlan,
    EvacActionType.instruction: InstructionActionPlan,
    // EvacActionType.completion: CompletionActionPlan,
  };
}
