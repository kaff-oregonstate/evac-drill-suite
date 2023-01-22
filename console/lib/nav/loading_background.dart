import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

const _orangt = Color(0xFFD64C06);

class LoadingBackground extends StatelessWidget {
  const LoadingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(6, 8, 4, 0),
              child: Text(
                'Evacuation Drill',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).subtitle2.override(
                      fontFamily: 'Space Grotesk',
                      color: _orangt,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 4, 12),
              child: Text(
                'Console',
                textAlign: TextAlign.start,
                style: FlutterFlowTheme.of(context).title2.override(
                      // fontFamily: 'Outfit',
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w700,
                      lineHeight: 1,
                      fontSize: 36,
                      letterSpacing: -0.2,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(40),
              child: SizedBox(
                height: 96,
                width: 96,
                child: CircularProgressIndicator(
                  color: _orangt,
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
