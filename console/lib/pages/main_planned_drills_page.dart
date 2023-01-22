import 'package:evac_drill_console/components/dashboard/d_refresh_button.dart';
import 'package:evac_drill_console/components/dashboard/planned_drill_card.dart';
// import 'package:evac_drill_console/components/web_nav_bar_collapsed.dart';
import 'package:evac_drill_console/components/web_nav_bar.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_util.dart';
import 'package:evac_drill_console/screen_too_small/show_notice_on_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MainPlannedDrillsPage extends StatefulWidget {
  const MainPlannedDrillsPage({Key? key}) : super(key: key);

  @override
  State<MainPlannedDrillsPage> createState() => _MainPlannedDrillsPageState();
}

class _MainPlannedDrillsPageState extends State<MainPlannedDrillsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _plannedDrillsScrollControl = ScrollController();

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
        floatingActionButton: FloatingActionButton(
          tooltip: 'New drill plan',
          onPressed: () async {
            context.pushNamed('planDrill-Info');
          },
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          elevation: 8,
          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 36,
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  // if (false)
                  //   WebNavBarCollapsed(
                  //     navBGOne: FlutterFlowTheme.of(context).tertiaryColor,
                  //     navColorOne: FlutterFlowTheme.of(context).primaryText,
                  //     navBgTwo:
                  //         FlutterFlowTheme.of(context).secondaryBackground,
                  //     navColorTwo: FlutterFlowTheme.of(context).secondaryText,
                  //     navBgThree:
                  //         FlutterFlowTheme.of(context).secondaryBackground,
                  //     navColorThree: FlutterFlowTheme.of(context).secondaryText,
                  //     navBGFour:
                  //         FlutterFlowTheme.of(context).secondaryBackground,
                  //     navColorFour: FlutterFlowTheme.of(context).secondaryText,
                  //   ),
                  if (true)
                    WebNavBar(
                      navBGOne: FlutterFlowTheme.of(context).primaryBackground,
                      navColorOne: FlutterFlowTheme.of(context).primaryText,
                      navBgTwo:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      navColorTwo: FlutterFlowTheme.of(context).secondaryText,
                      navBgThree:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      navColorThree: FlutterFlowTheme.of(context).secondaryText,
                      navBGFour:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      navColorFour: FlutterFlowTheme.of(context).secondaryText,
                    ),
                ],
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
                                borderRadius: BorderRadius.circular(12),
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
                                                  'Planned Drills',
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
                                                  '(5)',
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
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 1),
                                        child: Scrollbar(
                                          controller:
                                              _plannedDrillsScrollControl,
                                          thumbVisibility: true,
                                          child: MasonryGridView.count(
                                            controller:
                                                _plannedDrillsScrollControl,
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                            itemCount: 5,
                                            itemBuilder: (context, index) {
                                              return [
                                                () => const PlannedDrillCard(),
                                                () => const PlannedDrillCard(),
                                                () => const PlannedDrillCard(),
                                                () => const PlannedDrillCard(),
                                                () => const PlannedDrillCard(),
                                              ][index]();
                                            },
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
