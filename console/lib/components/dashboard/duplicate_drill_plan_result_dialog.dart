import 'package:evac_drill_console/nav/nav.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_theme.dart';

class DuplicateDrillPlanResultDialog extends StatelessWidget {
  const DuplicateDrillPlanResultDialog(this.drillID, {super.key});

  final String? drillID;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: (drillID != null)
          ? const Icon(Icons.check_circle_outline_rounded)
          : const Icon(Icons.error_outline_outlined),
      title: (drillID != null)
          ? const Text('Duplicated DrillPlan successfully')
          : const Text(
              'Failed to duplicate DrillPlan, try again or contact admin'),
      // content: (drillID != null) ? Text('New drill has ID: $drillID') : null,
      content: (drillID == null)
          ? null
          : RichText(
              text: TextSpan(
                style: FFTheme.of(context).bodyText2,
                children: [
                  TextSpan(
                    text: 'New drill has ID: `$drillID`\n\nGo to the ',
                  ),
                  TextSpan(
                    text: 'Planned Drills page',
                    style: FFTheme.of(context).bodyText2.copyWith(
                          // color: FFTheme.of(context)
                          //     .primaryText,
                          decoration: TextDecoration.underline,
                        ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => context.goNamed('Dash_plannedDrills'),
                  ),
                  const TextSpan(
                    text: ' to see it in the collection,\nor ',
                  ),
                  TextSpan(
                    text: 'plan the drill right now',
                    style: FFTheme.of(context).bodyText2.copyWith(
                          // color: FFTheme.of(context)
                          //     .primaryText,
                          decoration: TextDecoration.underline,
                        ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        WidgetsBinding.instance.addPostFrameCallback((_) =>
                            context.pushNamed('planDrill',
                                params: {'drillID': drillID!}));
                        Navigator.of(context).pop();
                      },
                  ),
                  const TextSpan(
                    text: '.',
                  ),
                ],
              ),
            ),
      actions: <Widget>[
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
