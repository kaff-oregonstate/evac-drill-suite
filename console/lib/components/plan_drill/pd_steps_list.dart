import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

const _pdStepsListItemWidth = 200.0;

class PDStepsList extends StatelessWidget {
  const PDStepsList(this.activeIndex, {Key? key}) : super(key: key);

  final int activeIndex;

  static const steps = [
    ['Info', 'planDrill-Info'],
    ['Procedure', 'planDrill-Procedure'],
    ['Survey Questions (1)', 'planDrill-Survey-1'],
    ['Evacuation Instructions', 'planDrill-Evacuation'],
    ['Survey Questions (2)', 'planDrill-Survey-2'],
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(36, 24, 36, 16),
      child: Container(
        width: _pdStepsListItemWidth,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                  child: Text(
                    'Steps',
                    style: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Space Grotesk',
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                  ),
                ),
                Divider(
                  height: 12,
                  thickness: 2,
                  color: FlutterFlowTheme.of(context).tertiaryColor,
                ),
              ] +
              List.generate(
                steps.length,
                (index) => PDStepsListItem(
                  steps[index][0],
                  steps[index][1],
                  active: (index == activeIndex),
                ),
              ),
        ),
      ),
    );
  }
}

class PDStepsListItem extends StatelessWidget {
  const PDStepsListItem(this.label, this.route,
      {Key? key, required this.active})
      : super(key: key);

  final String label;
  // final Function? nav;
  final String route;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 3),
      child: Container(
        width: _pdStepsListItemWidth,
        decoration: BoxDecoration(
          color:
              (active) ? FlutterFlowTheme.of(context).primaryBackground : null,
          border: (active)
              ? null
              : Border.all(
                  color: FlutterFlowTheme.of(context).tertiaryColor,
                  width: 1,
                ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: (active)
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  label,
                  style: FlutterFlowTheme.of(context).bodyText1,
                ),
              )
            : Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => context.goNamed(route),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      label,
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
