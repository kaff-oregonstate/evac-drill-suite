import 'package:flutter/material.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart' show readableDateTime;
import '../models/drill_plan.dart';
import 'vdp_card_wrapper.dart';

class VDPCardInfo extends StatelessWidget {
  const VDPCardInfo(
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
      title: 'Info',
      pdView: 'info',
      hintText: 'Plan the drill info',
      children: [
        VDPCInfoRow(
          param: 'Title',
          value: drillPlan.title ?? '[no title yet]',
          odd: false,
        ),
        VDPCInfoRow(
          param: 'Location',
          value: (drillPlan.meetingLocationPlainText != null &&
                  drillPlan.meetingLocationPlainText!.isNotEmpty)
              ? drillPlan.meetingLocationPlainText!
              : '[no meeting location yet]',
          odd: true,
        ),
        VDPCInfoRow(
          param: 'Type',
          value: drillPlan.type.name,
          odd: false,
        ),
        VDPCInfoRow(
          param: 'Date & Time',
          value: readableDateTime(drillPlan.meetingDateTime) ?? '[no date yet]',
          odd: true,
        ),
        VDPCInfoRow(
          param: 'Blurb',
          value: (drillPlan.blurb != null && drillPlan.blurb!.isNotEmpty)
              ? drillPlan.blurb!
              : '[no blurb yet]',
          odd: false,
        ),
        VDPCInfoRow(
          param: 'Description',
          value: (drillPlan.description != null &&
                  drillPlan.description!.isNotEmpty)
              ? drillPlan.description!
              : '[no description yet]',
          // : 'an extremely long description which would most certainly overflow the area provided were it not contained within an Expanded Widget within a Row which is within a Container which is wihtin a column which is within another Container (hopefully)',
          odd: true,
        ),
      ],
    );
  }
}

class VDPCInfoRow extends StatelessWidget {
  const VDPCInfoRow({
    required this.param,
    required this.value,
    required this.odd,
    super.key,
  });

  final String param;
  final String value;
  final bool odd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (odd) ? FFTheme.of(context).primaryBackground : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              '$param: ',
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
