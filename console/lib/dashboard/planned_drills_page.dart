import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evac_drill_console/components/dashboard/d_refresh_button.dart';
import 'package:evac_drill_console/components/dashboard/planned_drill_card.dart';
// import 'package:evac_drill_console/components/web_nav_bar_collapsed.dart';
import 'package:evac_drill_console/components/web_nav_bar.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_util.dart';
import 'package:evac_drill_console/screen_too_small/show_notice_on_small.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/drill_plan.dart';

class PlannedDrillsPage extends StatefulWidget {
  const PlannedDrillsPage({Key? key}) : super(key: key);

  @override
  State<PlannedDrillsPage> createState() => _PlannedDrillsPageState();
}

class _PlannedDrillsPageState extends State<PlannedDrillsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _plannedDrillsScrollControl = ScrollController();

  bool _loadingDrillPlans = true;

  List<DrillPlan> drillPlans = [];

  void setLoading([bool? val]) {
    if (mounted) {
      setState(() => _loadingDrillPlans = val ?? !_loadingDrillPlans);
    }
  }

  void updateDashLeavingPlanDrill() {
    if (!GoRouter.of(context).location.contains('planDrill') &&
        !GoRouter.of(context).location.contains('viewDrillPlan')) {
      // ignore: avoid_print
      print('removing updateDashLeavingPlanDrill listener');
      GoRouter.of(context).removeListener(updateDashLeavingPlanDrill);
      // ignore: avoid_print
      print('refreshing drill plans');
      refreshDrillPlans();
    } else {
      // ignore: avoid_print
      print('`updateDashLeavingPlanDrill` still listening…');
    }
  }

  @override
  void initState() {
    super.initState();

    refreshDrillPlans();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _plannedDrillsScrollControl.dispose();
  }

  /// No need to listen for changes, force them to refresh if they want it
  /// IMPORTANT: Make sure that when we're loading a Plan Drill or
  ///       EditDrillPlanJson Page, that we're strictly passing it the drillID, so
  ///       that the potentially stale data represented in local state doesn't
  ///       impact anything.
  Future<void> refreshDrillPlans() async {
    setLoading(true);

    drillPlans = [];

    // get the relevant documents from firestore
    final drillPlanCol = FirebaseFirestore.instance.collection('DrillPlan');
    final plannedDrillsQ = drillPlanCol.where('published', isEqualTo: false);
    final plannedDrillDocs = await plannedDrillsQ.get();

    // consume the documents, populating the local DrillPlans
    for (final snap in plannedDrillDocs.docs) {
      DrillPlan? thisDrillPlan;
      try {
        thisDrillPlan = DrillPlan.fromDoc(snap);
        if (mounted) {
          setState(() => drillPlans.add(thisDrillPlan!));
          // final missingParams = thisDrillPlan.paramsMissing();
          // print('Missing Params for drill: ${thisDrillPlan.drillID}');
          // for (final param in missingParams) {
          //   print(param);
          // }
          // if (missingParams.isEmpty) {
          //   try {
          //     thisDrillPlan.validate();
          //     print('validate passed for drill ${thisDrillPlan.drillID}');
          //   } catch (e) {
          //     print(e);
          //   }
          // }
        }
      } catch (e) {
        // FIXME: better error handling on parse of DrillPlan snaps
        // ignore: avoid_print
        print('Error parsing DrillPlan from DocumentSnapshot…');
        // ignore: avoid_print
        print('drillID: ${snap.id}');
        // ignore: avoid_print
        print('Error Type: ${e.runtimeType}');
        // ignore: avoid_print
        print(e);
      }
    }

    // setState sort drillPlans by ??

    setLoading();
    return;
  }

  @override
  Widget build(BuildContext context) {
    return ShowNoticeOnSmall(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FFTheme.of(context).primaryBackground,
        // floatingActionButton: FloatingActionButton(
        //   tooltip: 'New drill plan',
        //   onPressed: () async {
        //     // FIXME: create new DrillPLan and link to PlanDrillPage once implemented
        //     context.pushNamed('planDrill-Info');
        //   },
        //   backgroundColor: FFTheme.of(context).primaryColor,
        //   elevation: 8,
        //   child: const Icon(
        //     Icons.add_rounded,
        //     color: Colors.white,
        //     size: 36,
        //   ),
        // ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              // web nav bar
              Stack(
                children: [
                  // if (false)
                  //   WebNavBarCollapsed(
                  //     navBGOne: FFTheme.of(context).tertiaryColor,
                  //     navColorOne: FFTheme.of(context).primaryText,
                  //     navBgTwo:
                  //         FFTheme.of(context).secondaryBackground,
                  //     navColorTwo: FFTheme.of(context).secondaryText,
                  //     navBgThree:
                  //         FFTheme.of(context).secondaryBackground,
                  //     navColorThree: FFTheme.of(context).secondaryText,
                  //     navBGFour:
                  //         FFTheme.of(context).secondaryBackground,
                  //     navColorFour: FFTheme.of(context).secondaryText,
                  //   ),
                  if (true)
                    WebNavBar(
                      navBGOne: FFTheme.of(context).primaryBackground,
                      navColorOne: FFTheme.of(context).primaryText,
                      navBgTwo: FFTheme.of(context).secondaryBackground,
                      navColorTwo: FFTheme.of(context).secondaryText,
                      navBgThree: FFTheme.of(context).secondaryBackground,
                      navColorThree: FFTheme.of(context).secondaryText,
                      navBGFour: FFTheme.of(context).secondaryBackground,
                      navColorFour: FFTheme.of(context).secondaryText,
                      updateDashLeavingPlanDrill: updateDashLeavingPlanDrill,
                    ),
                ],
              ),
              // dashboard body
              Expanded(
                  child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FFTheme.of(context).primaryBackground,
                ),
                padding:
                    const EdgeInsetsDirectional.fromSTEB(24 + 4, 24, 24, 24),
                // main dashboard content
                child: Container(
                  width: 330,
                  height: 100,
                  decoration: BoxDecoration(
                    color: FFTheme.of(context).secondaryBackground,
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
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // title bar
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 12, 8, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // title text
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Text(
                                      'Planned Drills',
                                      style: FFTheme.of(context).title2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Text(
                                      '(${drillPlans.length.toString()})',
                                      style: FFTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Space Grotesk',
                                            color: FFTheme.of(context)
                                                .secondaryText,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              // title buttons
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  DRefreshButton(onTap: () {
                                    refreshDrillPlans();
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // drill plan cards
                        Expanded(
                          child: (_loadingDrillPlans)
                              ? const Center(
                                  child: CircularProgressIndicator.adaptive())
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 1),
                                  child: Scrollbar(
                                    controller: _plannedDrillsScrollControl,
                                    thumbVisibility: true,
                                    child: MasonryGridView.count(
                                      controller: _plannedDrillsScrollControl,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      itemCount: drillPlans.length,
                                      itemBuilder: (context, index) {
                                        return PlannedDrillCard(
                                          drillPlans[index],
                                          refreshDrillPlans,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                        ),
                        Divider(
                          height: 4,
                          thickness: 2,
                          color: FFTheme.of(context).tertiaryColor,
                        ),
                        // help text
                        Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 12.0),
                            child: RichText(
                              text: TextSpan(
                                style: FFTheme.of(context).bodyText2,
                                children: [
                                  const TextSpan(
                                    text:
                                        'Looking for a published drill? Try the ',
                                  ),
                                  TextSpan(
                                    text: 'Published Drills page',
                                    style: FFTheme.of(context)
                                        .bodyText2
                                        .copyWith(
                                          // color: FFTheme.of(context)
                                          //     .primaryText,
                                          decoration: TextDecoration.underline,
                                        ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => context
                                          .goNamed('Dash_publishedDrills'),
                                  ),
                                  const TextSpan(
                                    text: ' or the ',
                                  ),
                                  TextSpan(
                                    text: 'Completed Drills page',
                                    style: FFTheme.of(context)
                                        .bodyText2
                                        .copyWith(
                                          // color: FFTheme.of(context)
                                          //     .primaryText,
                                          decoration: TextDecoration.underline,
                                        ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => context
                                          .goNamed('Dash_completedDrills'),
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
              )),
            ],
          ),
        ),
      ),
    );
  }
}
