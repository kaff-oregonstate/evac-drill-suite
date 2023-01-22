import 'package:evac_drill_console/components/dashboard/completed_drill_card.dart';
import 'package:evac_drill_console/components/dashboard/d_refresh_button.dart';
import 'package:evac_drill_console/components/web_nav_bar.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_util.dart';
import 'package:evac_drill_console/screen_too_small/show_notice_on_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MainCompletedDrillsPage extends StatefulWidget {
  const MainCompletedDrillsPage({Key? key}) : super(key: key);

  @override
  State<MainCompletedDrillsPage> createState() =>
      _MainCompletedDrillsPageState();
}

class _MainCompletedDrillsPageState extends State<MainCompletedDrillsPage> {
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (responsiveVisibility(
                context: context,
                phone: false,
              ))
                WebNavBar(
                  navBGOne: FlutterFlowTheme.of(context).secondaryBackground,
                  navColorOne: FlutterFlowTheme.of(context).secondaryText,
                  navBgTwo: FlutterFlowTheme.of(context).secondaryBackground,
                  navColorTwo: FlutterFlowTheme.of(context).secondaryText,
                  navBgThree: FlutterFlowTheme.of(context).primaryBackground,
                  navColorThree: FlutterFlowTheme.of(context).primaryText,
                  navBGFour: FlutterFlowTheme.of(context).secondaryBackground,
                  navColorFour: FlutterFlowTheme.of(context).secondaryText,
                ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(4, 12, 0, 0),
                        child: Container(
                          width: double.infinity,
                          height: 80,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24, 12, 24, 24),
                            child: Container(
                              width: 330,
                              height: 100,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x2B090F13),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 12, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              8, 12, 8, 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 8, 0),
                                                child: Text(
                                                  'Completed Drills',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .title2,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 0, 6),
                                                child: Text(
                                                  '(1)',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .subtitle2
                                                      .override(
                                                        fontFamily:
                                                            'Space Grotesk',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              DRefreshButton(onTap: () {
                                                // TODO: Implement Dashboard Refresh Button `onTap`
                                                // ignore: avoid_print
                                                print('Button pressed ...');
                                              }),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    // if (false)
                                    //   Divider(
                                    //     height: 8,
                                    //     thickness: 2,
                                    //     color: FlutterFlowTheme.of(context)
                                    //         .tertiaryColor,
                                    //   ),
                                    Expanded(
                                      child: MasonryGridView.count(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        itemCount: 1,
                                        itemBuilder: (context, index) {
                                          return [
                                            () => const CompletedDrillCard(),
                                          ][index]();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
