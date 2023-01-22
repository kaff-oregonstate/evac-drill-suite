import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class DisplaySize extends StatelessWidget {
  const DisplaySize({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [child, const SizeDisplay()],
    );
  }
}

class SizeDisplay extends StatelessWidget {
  const SizeDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: FlutterFlowTheme.of(context).tertiaryColor,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$width x $height',
                style: FlutterFlowTheme.of(context).title3.override(
                      fontFamily: 'Outfit',
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
