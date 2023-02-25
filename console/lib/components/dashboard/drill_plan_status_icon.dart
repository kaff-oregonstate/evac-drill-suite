import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_theme.dart';

class DrillPlanStatusIcon extends StatelessWidget {
  const DrillPlanStatusIcon(
    this.message,
    this.iconData, {
    super.key,
  });

  final String message;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      textAlign: TextAlign.center,
      // preferBelow: false,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 2.0,
          left: 8.0,
          right: 8.0,
        ),
        child: Icon(
          iconData,
          size: 16.0,
          // Icons.edit_off_rounded,
          color: FFTheme.of(context).secondaryText,
        ),
      ),
    );
  }
}
