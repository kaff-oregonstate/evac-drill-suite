import 'package:flutter/material.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../models/evac_action_plans/evac_action_plan.dart';
import '../models/task_details_plans/practice_evac_details_plan.dart';
import 'vdp_card_wrapper.dart';

class VDPCardPracticeEvac extends StatelessWidget {
  const VDPCardPracticeEvac({
    required this.drillID,
    required this.practiceEvacDetails,
    required this.isCreator,
    required this.evacIndex,
    super.key,
  });

  final String drillID;
  final PracticeEvacDetailsPlan practiceEvacDetails;
  final bool isCreator;
  final int evacIndex;

  @override
  Widget build(BuildContext context) {
    return VDPCardWrapper(
      drillID: drillID,
      isCreator: isCreator,
      title:
          'Practice Evacuation: ${practiceEvacDetails.title ?? '[no task title yet]'}',
      pdView: 'evacuation-$evacIndex',
      hintText: 'Plan the evacuation actions',
      children: List.generate(
        practiceEvacDetails.actions.length,
        (index) => VDPCPracticeEvacRow(
          index: index,
          value: (practiceEvacDetails.actions[index].actionType ==
                  EvacActionType.waitForStart)
              ? '${practiceEvacDetails.actions[index].actionType.fullName}: ${(practiceEvacDetails.actions[index] as WaitForStartActionPlan).waitType.fullName}'
              : '${practiceEvacDetails.actions[index].actionType.fullName}:  ${(practiceEvacDetails.actions[index] as InstructionActionPlan).text ?? '[no step title/question yet]'}',
        ),
      ),
    );
  }
}

class VDPCPracticeEvacRow extends StatelessWidget {
  const VDPCPracticeEvacRow({
    required this.index,
    required this.value,
    super.key,
  });

  final int index;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (index % 2 == 1) ? FFTheme.of(context).primaryBackground : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            padding: const EdgeInsets.only(right: 4),
            child: Text(
              '${index + 1}.',
              textAlign: TextAlign.end,
              style: FFTheme.of(context).bodyText2,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: FFTheme.of(context).bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
