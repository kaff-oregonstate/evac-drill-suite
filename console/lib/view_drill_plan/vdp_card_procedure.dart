import 'package:flutter/material.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../models/drill_plan.dart';
import '../models/drill_task_plan.dart';
import 'vdp_card_wrapper.dart';

class VDPCardProcedure extends StatelessWidget {
  const VDPCardProcedure(
    this.drillPlan,
    this.isCreator, {
    super.key,
  });

  final DrillPlan drillPlan;
  final bool isCreator;

  @override
  Widget build(BuildContext context) {
    return VDPCardWrapper(
      drillID: drillPlan.drillID,
      isCreator: isCreator,
      title: 'Procedure',
      pdView: 'procedure',
      hintText: 'Plan the drill procedure',
      children: List.generate(
        drillPlan.tasks.length,
        (index) => VDPCProcedureRow(
          index: index,
          value:
              '${drillPlan.tasks[index].taskType.fullName}:  ${drillPlan.tasks[index].title ?? '[no task title yet]'}',
        ),
      ),
    );
  }
}

class VDPCProcedureRow extends StatelessWidget {
  const VDPCProcedureRow({
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
