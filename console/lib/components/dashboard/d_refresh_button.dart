import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class DRefreshButton extends StatelessWidget {
  const DRefreshButton({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final void Function()? onTap;

  static final buttonBorderRadius = BorderRadius.circular(8.0);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: buttonBorderRadius,
      clipBehavior: Clip.antiAlias,
      child: IconButton(
        onPressed: onTap,
        icon: Icon(
          Icons.refresh_rounded,
          color: FFTheme.of(context).secondaryText,
        ),
        tooltip: 'Refresh drills',
      ),
    );
  }
}
