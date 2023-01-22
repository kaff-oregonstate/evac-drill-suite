import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_widgets.dart';
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
        // iconSize: 24,
        icon: Icon(
          Icons.refresh_rounded,
          color: FlutterFlowTheme.of(context).secondaryText,
        ),
        // style: ButtonStyle(
        //   shape: MaterialStateProperty.all<OutlinedBorder>(
        //     RoundedRectangleBorder(
        //       borderRadius: buttonBorderRadius,
        //       side: BorderSide.none,
        //     ),
        //   ),
        // ),
        // hoverColor:
        //     FlutterFlowTheme.of(context).primaryBackground.withOpacity(0.6),
        // splashColor:
        //     FlutterFlowTheme.of(context).primaryBackground.withOpacity(0.8),
        tooltip: 'Refresh drills',
      ),
    );

    return FFButtonWidget(
      onPressed: () {
        onTap;
      },
      text: 'Refresh',
      icon: Icon(
        Icons.refresh_rounded,
        color: FlutterFlowTheme.of(context).primaryColor,
        size: 15,
      ),
      options: FFButtonOptions(
        height: 40,
        color: FlutterFlowTheme.of(context).primaryBackground,
        textStyle: FlutterFlowTheme.of(context).subtitle2.override(
              fontFamily: 'Space Grotesk',
              color: FlutterFlowTheme.of(context).primaryColor,
            ),
        borderSide: BorderSide(
          color: FlutterFlowTheme.of(context).primaryColor.withOpacity(0.5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
