import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PDProgressBar extends StatelessWidget {
  const PDProgressBar(this.ratioComplete, {Key? key}) : super(key: key);

  final double ratioComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x33000000),
            offset: Offset(0, 2),
          )
        ],
      ),
      child: LinearPercentIndicator(
        percent: ratioComplete.clamp(0.0, 1.0),
        width: MediaQuery.of(context).size.width,
        lineHeight: 8,
        animation: true,
        progressColor: FlutterFlowTheme.of(context).primaryColor,
        backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
        barRadius: const Radius.circular(0),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
