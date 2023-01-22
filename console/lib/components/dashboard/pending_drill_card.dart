import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PendingDrillCard extends StatefulWidget {
  const PendingDrillCard({Key? key}) : super(key: key);

  @override
  State<PendingDrillCard> createState() => _PendingDrillCardState();
}

class _PendingDrillCardState extends State<PendingDrillCard>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          maxWidth: 500,
        ),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: FlutterFlowTheme.of(context).tertiaryColor,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(12, 16, 12, 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Seaside Tsunami Evacuation Drill',
                style: FlutterFlowTheme.of(context).subtitle1.override(
                      fontFamily: 'Outfit',
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                    child: Text(
                      '10am Today',
                      style: FlutterFlowTheme.of(context).bodyText2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                    child: Text(
                      ' ( ',
                      style: FlutterFlowTheme.of(context).bodyText2.override(
                            fontFamily: 'Space Grotesk',
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                    child: Text(
                      '2 hours',
                      style: FlutterFlowTheme.of(context).bodyText2.override(
                            fontFamily: 'Space Grotesk',
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                    child: Text(
                      ' ago )',
                      style: FlutterFlowTheme.of(context).bodyText2.override(
                            fontFamily: 'Space Grotesk',
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Seaside, Oregon, USA',
                    style: FlutterFlowTheme.of(context).bodyText2,
                  ),
                  Text(
                    ' - ',
                    style: FlutterFlowTheme.of(context).bodyText2,
                  ),
                  Text(
                    'Tsunami',
                    style: FlutterFlowTheme.of(context).bodyText2,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                child: LinearPercentIndicator(
                  percent: 0.75,
                  width: 310,
                  lineHeight: 16,
                  animation: true,
                  progressColor: FlutterFlowTheme.of(context).primaryColor,
                  backgroundColor:
                      FlutterFlowTheme.of(context).primaryBackground,
                  barRadius: const Radius.circular(16),
                  padding: EdgeInsets.zero,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      '9',
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                            fontFamily: 'Outfit',
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                    ),
                    Text(
                      ' of 12 participants uploaded results so far',
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                            fontFamily: 'Outfit',
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 24,
                thickness: 2,
                color: FlutterFlowTheme.of(context).tertiaryColor,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Invite Code:   ',
                    style: FlutterFlowTheme.of(context).title2.override(
                          fontFamily: 'Outfit',
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                  ),
                  Text(
                    '876 543',
                    style: FlutterFlowTheme.of(context).title2,
                  ),
                ],
              ),
              Divider(
                height: 24,
                thickness: 2,
                color: FlutterFlowTheme.of(context).tertiaryColor,
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    text: 'Download Results Early',
                    icon: Icon(
                      Icons.cloud_download_rounded,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 15,
                    ),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 40,
                      color: FlutterFlowTheme.of(context).tertiaryColor,
                      textStyle: FlutterFlowTheme.of(context)
                          .subtitle2
                          .override(
                            fontFamily: 'Space Grotesk',
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
