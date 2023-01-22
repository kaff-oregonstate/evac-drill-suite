import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class SurveyReviewCardWidget extends StatefulWidget {
  const SurveyReviewCardWidget(this.surveyIndex, {Key? key}) : super(key: key);

  final int surveyIndex;

  @override
  State<SurveyReviewCardWidget> createState() => _SurveyReviewCardWidgetState();
}

class _SurveyReviewCardWidgetState extends State<SurveyReviewCardWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            context.goNamed((widget.surveyIndex == 0)
                ? 'planDrill-Survey-1'
                : 'planDrill-Survey-2');
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              // color: FlutterFlowTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: FlutterFlowTheme.of(context).tertiaryColor,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SelectionArea(
                            child: Text(
                          'Survey: \"${(widget.surveyIndex == 0) ? 'Pre' : 'Post'}-Drill Survey\"',
                          style: FlutterFlowTheme.of(context).title3.override(
                                fontFamily: 'Outfit',
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                              ),
                        )),
                        Icon(
                          Icons.edit_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 24,
                    thickness: 2,
                    indent: 12,
                    endIndent: 12,
                    color: FlutterFlowTheme.of(context).tertiaryColor,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 90,
                              decoration: const BoxDecoration(),
                              child: Text(
                                'Instruction:',
                                style: FlutterFlowTheme.of(context).bodyText2,
                              ),
                            ),
                            Container(
                              width: 380,
                              decoration: const BoxDecoration(),
                              child: Text(
                                'Please complete our Pre-Drill Survey.',
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: (Theme.of(context).brightness == Brightness.dark)
                            ? const Color(0x1F000000)
                            : const Color(0x09000000),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 90,
                              decoration: const BoxDecoration(),
                              child: Text(
                                'Boolean:',
                                style: FlutterFlowTheme.of(context).bodyText2,
                              ),
                            ),
                            Container(
                              width: 380,
                              decoration: const BoxDecoration(),
                              child: Text(
                                'Have you visited this location before?',
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 90,
                              decoration: const BoxDecoration(),
                              child: Text(
                                'Integer:',
                                style: FlutterFlowTheme.of(context).bodyText2,
                              ),
                            ),
                            Container(
                              width: 380,
                              decoration: const BoxDecoration(),
                              child: Text(
                                'How many times have you visited this location?',
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: (Theme.of(context).brightness == Brightness.dark)
                            ? const Color(0x1F000000)
                            : const Color(0x09000000),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 90,
                              decoration: const BoxDecoration(),
                              child: Text(
                                'Scale:',
                                style: FlutterFlowTheme.of(context).bodyText2,
                              ),
                            ),
                            Container(
                              width: 380,
                              decoration: const BoxDecoration(),
                              child: Text(
                                'How confident are you in completing the practice evacuation?',
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 90,
                              decoration: const BoxDecoration(),
                              child: Text(
                                'Single-Choice:',
                                style: FlutterFlowTheme.of(context).bodyText2,
                              ),
                            ),
                            Container(
                              width: 380,
                              decoration: const BoxDecoration(),
                              child: Text(
                                'Do you prefer to vacation at the beach or the mountains?',
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: (Theme.of(context).brightness == Brightness.dark)
                            ? const Color(0x1F000000)
                            : const Color(0x09000000),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 90,
                              decoration: const BoxDecoration(),
                              child: Text(
                                'Text:',
                                style: FlutterFlowTheme.of(context).bodyText2,
                              ),
                            ),
                            Container(
                              width: 380,
                              decoration: const BoxDecoration(),
                              child: Text(
                                'How did you hear about this evacuation drill?',
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
