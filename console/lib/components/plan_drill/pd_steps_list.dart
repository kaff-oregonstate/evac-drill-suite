import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../../plan_drill/plan_drill_controller.dart';

const _pdStepsListItemWidth = 200.0;

class PDStepsList extends StatelessWidget {
  const PDStepsList(this.pdController, {Key? key}) : super(key: key);

  // final int activeIndex;

  final PDController? pdController;

  // final List<List<String>> steps;

  // static const steps = [
  //   ['Info', 'planDrill-Info'],
  //   ['Procedure', 'planDrill-Procedure'],
  //   ['Survey Questions (1)', 'planDrill-Survey-1'],
  //   ['Evacuation Instructions', 'planDrill-Evacuation'],
  //   ['Survey Questions (2)', 'planDrill-Survey-2'],
  // ];

  @override
  Widget build(BuildContext context) {
    final steps = pdController?.steps;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(36, 24, 36, 16),
      child: Container(
        width: _pdStepsListItemWidth,
        decoration: BoxDecoration(
          color: FFTheme.of(context).secondaryBackground,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                  child: Text(
                    'Steps',
                    style: FFTheme.of(context).subtitle2.override(
                          fontFamily: 'Space Grotesk',
                          color: FFTheme.of(context).secondaryText,
                        ),
                  ),
                ),
                Divider(
                  height: 12,
                  thickness: 2,
                  color: FFTheme.of(context).tertiaryColor,
                ),
              ] +
              ((pdController == null)
                  ? [
                      const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ]
                  : List.generate(
                      steps!.length,
                      (index) => PDStepsListItem(
                        steps[index],
                        active: (index == pdController!.currentPage),
                        onTap: () => pdController!.navToPage(index),
                      ),
                    )),
        ),
      ),
    );
  }
}

class PDStepsListItem extends StatelessWidget {
  const PDStepsListItem(
    this.stepName, {
    Key? key,
    required this.active,
    required this.onTap,
  }) : super(key: key);

  final String stepName;
  final bool active;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 3),
      child: Container(
        width: _pdStepsListItemWidth,
        decoration: BoxDecoration(
          color: (active) ? FFTheme.of(context).primaryBackground : null,
          border: (active)
              ? null
              : Border.all(
                  color: FFTheme.of(context).tertiaryColor,
                  width: 1,
                ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: (active)
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  stepName,
                  style: FFTheme.of(context).bodyText1,
                ),
              )
            : Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: onTap,
                  // onTap: () => context.goNamed(
                  //   route,
                  //   params: {
                  //     'drillID': drillID,
                  //     'view': view,
                  //   },
                  // ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      stepName,
                      style: FFTheme.of(context).bodyText1,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
