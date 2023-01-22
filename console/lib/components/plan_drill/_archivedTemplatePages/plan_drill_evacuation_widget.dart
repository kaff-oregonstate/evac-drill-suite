import 'package:evac_drill_console/components/evacuation_instruction_field.dart';
import 'package:evac_drill_console/components/plan_drill/pd_app_bar.dart';
import 'package:evac_drill_console/components/plan_drill/pd_bottom_nav_buttons.dart';
import 'package:evac_drill_console/components/plan_drill/pd_progress_bar.dart';
import 'package:evac_drill_console/components/plan_drill/pd_steps_list.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_widgets.dart';
import 'package:evac_drill_console/screen_too_small/show_notice_on_small.dart';
import 'package:flutter/material.dart';

class PlanDrillEvacuationWidget extends StatefulWidget {
  const PlanDrillEvacuationWidget({Key? key}) : super(key: key);

  @override
  State<PlanDrillEvacuationWidget> createState() =>
      _PlanDrillEvacuationWidgetState();
}

class _PlanDrillEvacuationWidgetState extends State<PlanDrillEvacuationWidget> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return ShowNoticeOnSmall(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const PDAppBar(),
                      const PDProgressBar(0.62),
                      Stack(
                        children: [
                          const PDStepsList(3),
                          // Body
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 24, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 24),
                                        child: Container(
                                          width: double.infinity,
                                          constraints: const BoxConstraints(
                                            maxWidth: 570,
                                          ),
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            boxShadow: const [
                                              BoxShadow(
                                                blurRadius: 4,
                                                color: Color(0x33000000),
                                                offset: Offset(0, 3),
                                                spreadRadius: 2,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 0, 16, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          16, 32, 16, 4),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SelectionArea(
                                                          child: Text(
                                                        'Evacuation',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .title1,
                                                      )),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          FFButtonWidget(
                                                            onPressed: () {
                                                              // TODO: Implement Reorder Instructions `.onPressed`
                                                              // ignore: avoid_print
                                                              print(
                                                                  'Button pressed ...');
                                                            },
                                                            text: 'Reorder',
                                                            icon: Icon(
                                                              Icons
                                                                  .reorder_rounded,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              size: 15,
                                                            ),
                                                            options:
                                                                FFButtonOptions(
                                                              height: 40,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtitle2
                                                                      .override(
                                                                        fontFamily:
                                                                            'Space Grotesk',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                      ),
                                                              borderSide:
                                                                  const BorderSide(
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                    8, 0, 0, 0),
                                                            child:
                                                                FFButtonWidget(
                                                              onPressed: () {
                                                                // TODO: Implement Add Instruction `.onPressed`
                                                                // ignore: avoid_print
                                                                print(
                                                                    'Button pressed ...');
                                                              },
                                                              text:
                                                                  'Add Instruction',
                                                              icon: const Icon(
                                                                Icons
                                                                    .add_rounded,
                                                                color: Colors
                                                                    .white,
                                                                size: 15,
                                                              ),
                                                              options:
                                                                  FFButtonOptions(
                                                                height: 40,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .subtitle2
                                                                    .override(
                                                                      fontFamily:
                                                                          'Space Grotesk',
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                borderSide:
                                                                    const BorderSide(
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          16, 0, 16, 12),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 200,
                                                        decoration:
                                                            const BoxDecoration(),
                                                        child: SelectionArea(
                                                            child: Text(
                                                          '"Escape Tsunami Inundation Zone"',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .subtitle1
                                                              .override(
                                                                fontFamily:
                                                                    'Outfit',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                              ),
                                                        )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  height: 2,
                                                  thickness: 2,
                                                  indent: 12,
                                                  endIndent: 12,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiaryColor,
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.66,
                                                  decoration:
                                                      const BoxDecoration(),
                                                  child: ListView(
                                                    padding: EdgeInsets.zero,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    children: const [
                                                      EvacuationInstructionField(),
                                                    ],
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
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  // plan drill BottomNavButtons
                  const PDBottomNavButtons(
                    backActive: true,
                    backText: 'Survey Questions (1)',
                    backRoute: 'planDrill-Survey-1',
                    forwardIsReview: false,
                    forwardText: 'Survey Questions (2)',
                    forwardRoute: 'planDrill-Survey-2',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
