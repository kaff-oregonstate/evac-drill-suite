import 'package:evac_drill_console/components/plan_drill/pd_app_bar.dart';
import 'package:evac_drill_console/components/plan_drill/pd_bottom_nav_buttons.dart';
import 'package:evac_drill_console/components/plan_drill/pd_progress_bar.dart';
import 'package:evac_drill_console/components/review_drill_plan/info_review_card_widget.dart';
import 'package:evac_drill_console/components/review_drill_plan/practice_evac_review_card_widget.dart';
import 'package:evac_drill_console/components/review_drill_plan/procedure_review_card_widget.dart';
import 'package:evac_drill_console/components/review_drill_plan/survey_review_card_widget.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/screen_too_small/show_notice_on_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FinalReviewPage extends StatefulWidget {
  const FinalReviewPage({Key? key}) : super(key: key);

  @override
  State<FinalReviewPage> createState() => _FinalReviewPageState();
}

class _FinalReviewPageState extends State<FinalReviewPage> {
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
                      PDAppBar(),
                      PDProgressBar(0.94),
                      Stack(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 24, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 24),
                                        child: Container(
                                          width: double.infinity,
                                          constraints: BoxConstraints(
                                            maxWidth: 1140,
                                          ),
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            boxShadow: [
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
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 0, 16, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 32, 16, 4),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SelectionArea(
                                                          child: Text(
                                                        'Review',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .title1,
                                                      )),
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
                                                      0.64,
                                                  decoration: BoxDecoration(),
                                                  child: Scrollbar(
                                                    thumbVisibility: true,
                                                    // trackVisibility: true,
                                                    child:
                                                        MasonryGridView.count(
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 0,
                                                      mainAxisSpacing: 0,
                                                      itemCount: 5,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return [
                                                          () =>
                                                              InfoReviewCardWidget(),
                                                          () =>
                                                              ProcedureReviewCardWidget(),
                                                          () =>
                                                              SurveyReviewCardWidget(
                                                                  0),
                                                          () =>
                                                              PracticeEvacReviewCardWidget(),
                                                          () =>
                                                              SurveyReviewCardWidget(
                                                                  1),
                                                        ][index]();
                                                      },
                                                    ),
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
                  PDBottomNavButtons(
                    backActive: true,
                    backText: 'Edit drill plan',
                    backRoute: 'planDrill-Evacuation',
                    forwardIsReview: false,
                    forwardIsPublish: true,
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
