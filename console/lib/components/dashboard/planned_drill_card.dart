import 'package:evac_drill_console/components/dashboard/publish_drill_plan_dialog.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../models/drill_plan.dart';
import 'delete_drill_plan_dialog.dart';
import 'drill_plan_status_icon.dart';
import 'duplicate_drill_plan_result_dialog.dart';

class PlannedDrillCard extends StatefulWidget {
  const PlannedDrillCard(this.drillPlan, this.refreshDrillPlans, {super.key});

  final DrillPlan drillPlan;
  final Function refreshDrillPlans;

  @override
  State<PlannedDrillCard> createState() => _PlannedDrillCardState();
}

class _PlannedDrillCardState extends State<PlannedDrillCard>
    with TickerProviderStateMixin {
  final auth = FirebaseAuth.instanceFor(
    app: Firebase.app(),
    persistence: Persistence.INDEXED_DB,
  );
  bool userCreatedDrill = false;
  bool userIsCurrentEditor = false;

  @override
  void initState() {
    super.initState();
    final uid = auth.currentUser!.uid;
    userCreatedDrill = widget.drillPlan.creatorID == uid;
    userIsCurrentEditor = widget.drillPlan.currentlyPlanningID == uid;

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  static String onlyCap(String s) {
    String output = '';
    void addOnlyCap(char) {
      if (char.contains(RegExp(r'[A-Z]'))) output += char;
    }

    final chars = s.split('');
    chars.forEach(addOnlyCap);
    return output;
  }

  static String readableDateTime(DateTime dateTime) {
    // 'April 8th, 2023 at 10am '
    final weekday = DateFormat.EEEE().format(dateTime);
    final month = DateFormat.LLLL().format(dateTime);
    final day = DateFormat.d().format(dateTime);
    final year = DateFormat.y().format(dateTime);
    final hour24 = DateFormat.H().format(dateTime);
    final hourInt = int.parse(hour24);
    final hour = (hourInt > 12) ? (hourInt % 12).toString() : hour24;
    final amPm = (int.parse(hour24) > 11) ? 'pm' : 'am';
    final minutes = DateFormat.m().format(dateTime);
    final min = (int.parse(minutes) == 0) ? null : minutes;
    final timeZone = onlyCap(dateTime.timeZoneName);
    return '$weekday $month $day, $year at $hour${(min != null) ? ":$min" : ""} $amPm $timeZone';
  }

  /// These listeners get registered to the GoRouter whenever pushing a page on
  /// top of the Planned Drills page that this PlannedDrillCard lives on.
  /// It ensures that all of the PlannedDrillCards get refreshed on return to
  /// the Planned Drills Page.
  void updateDashLeavingEdit() {
    if (!GoRouter.of(context).location.contains('editDrillPlanJson')) {
      // ignore: avoid_print
      print('removing updateDashLeavingEdit listener');
      GoRouter.of(context).removeListener(updateDashLeavingEdit);
      // ignore: avoid_print
      print('refreshing drill plans');
      widget.refreshDrillPlans();
    } else {
      // ignore: avoid_print
      print('`updateDashLeavingEdit` still listening…');
    }
  }

  void updateDashLeavingView() {
    if (!GoRouter.of(context).location.contains('viewDrillPlanJson')) {
      // ignore: avoid_print
      print('removing updateDashLeavingView listener');
      GoRouter.of(context).removeListener(updateDashLeavingView);
      // ignore: avoid_print
      print('refreshing drill plans');
      widget.refreshDrillPlans();
    } else {
      // ignore: avoid_print
      print('`updateDashLeavingView` still listening…');
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
      widget.refreshDrillPlans();
    } else {
      // ignore: avoid_print
      print('`updateDashLeavingPlanDrill` still listening…');
    }
  }

  @override
  Widget build(BuildContext context) {
    final drillPlan = widget.drillPlan;
    final dateTime = drillPlan.meetingDateTime;
    void showDialogHere(Widget dialog) {
      showDialog(context: context, builder: ((context) => dialog));
    }

    // mAgIc NuMbErS
    String title = ((drillPlan.title == null || drillPlan.title!.isEmpty)
        ? 'no title yet'
        : drillPlan.title!);
    if (title.length > 42) {
      title = '${title.substring(0, 43)}…';
    }
    String locPlainText = (drillPlan.meetingLocationPlainText == null ||
            drillPlan.meetingLocationPlainText!.isEmpty)
        ? 'no location yet'
        : drillPlan.meetingLocationPlainText!;
    if (locPlainText.length > 42) {
      locPlainText = '${locPlainText.substring(0, 43)}…';
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          maxWidth: 500,
        ),
        decoration: BoxDecoration(
          color: FFTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: FFTheme.of(context).tertiaryColor,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12).add(const EdgeInsets.only(top: 4)),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectionArea(
                        child: Text(
                          title,
                          style: FFTheme.of(context).subtitle1.override(
                                fontFamily: 'Outfit',
                                color: FFTheme.of(context).primaryText,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // user owns indicator
                      if (userCreatedDrill)
                        const DrillPlanStatusIcon(
                          'You created this drill,\nand can edit it',
                          Icons.edit_rounded,
                        ),
                      if (!userCreatedDrill && userIsCurrentEditor)
                        const DrillPlanStatusIcon(
                          'You are the current editor\nof this drill',
                          Icons.edit_rounded,
                        ),
                      if (!userCreatedDrill && !userIsCurrentEditor)
                        const DrillPlanStatusIcon(
                          'You cannot edit this drill,\nbut you can duplicate it',
                          Icons.people_alt_rounded,
                        ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: SelectionArea(
                          child: Text(
                            (dateTime != null)
                                ? readableDateTime(dateTime)
                                : 'no meeting time yet',
                            // 'April 8th, 2023 at 10am ',
                            style: FFTheme.of(context).bodyText2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SelectionArea(
                        child: Text(
                          locPlainText,
                          style: FFTheme.of(context).bodyText2,
                        ),
                      ),
                      if (DrillType.values.length > 1)
                        Text(
                          ' - ',
                          style: FFTheme.of(context).bodyText2,
                        ),
                      if (DrillType.values.length > 1)
                        Text(
                          drillPlan.type.name,
                          style: FFTheme.of(context).bodyText2,
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  SelectionArea(
                    child: Text(
                      drillPlan.creatorEmail,
                      style: FFTheme.of(context).bodyText2,
                    ),
                  ),
                  if (drillPlan.currentlyPlanningEmail != null)
                    const SizedBox(height: 4),
                  if (drillPlan.currentlyPlanningEmail != null)
                    Text(
                      'Current Editor: ${drillPlan.currentlyPlanningEmail}',
                      style: FFTheme.of(context).bodyText2,
                    ),
                  Divider(
                    height: 24,
                    thickness: 2,
                    color: FFTheme.of(context).tertiaryColor,
                  ),
                  Row(children: [
                    if (userCreatedDrill)
                      Expanded(
                        flex: 5,
                        child: DefaultFFButton(
                          'Plan Drill',
                          () {
                            context.pushNamed('planDrill', params: {
                              'drillID': drillPlan.drillID,
                            });
                            GoRouter.of(context)
                                .addListener(updateDashLeavingPlanDrill);
                          },
                          icon: Icon(
                            Icons.edit_document,
                            color: FFTheme.of(context).primaryBtnText,
                            size: 24,
                          ),
                          width: double.infinity,
                        ),
                      ),
                    if (userCreatedDrill) const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: DefaultFFButton(
                        (userCreatedDrill) ? 'Review' : 'View Drill Plan',
                        () {
                          context.pushNamed('viewDrillPlan',
                              params: {'drillID': drillPlan.drillID});
                          GoRouter.of(context)
                              .addListener(updateDashLeavingView);
                        },
                        icon: Icon(
                          Icons.description_rounded,
                          color: FFTheme.of(context).primaryBtnText,
                          size: 24,
                        ),
                        width: double.infinity,
                        // color: FFTheme.of(context).awesomeOrange,
                      ),
                    ),
                  ]),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8.0),
                  clipBehavior: Clip.antiAlias,
                  child: PopupMenuButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: FFTheme.of(context).secondaryText,
                    ),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      if (userCreatedDrill)
                        PopupMenuItem(
                          onTap: () {
                            context.pushNamed('editDrillPlanJson',
                                params: {'drillID': drillPlan.drillID});
                            // ignore: avoid_print
                            print('Edit JSON');
                            GoRouter.of(context)
                                .addListener(updateDashLeavingEdit);
                          },
                          child: const Text('Edit JSON'),
                        ),
                      if (userCreatedDrill)
                        PopupMenuItem(
                          onTap: () {
                            context.pushNamed('planDrill', params: {
                              'drillID': drillPlan.drillID,
                            });
                            GoRouter.of(context)
                                .addListener(updateDashLeavingPlanDrill);
                          },
                          child: const Text('Plan Drill'),
                        ),
                      PopupMenuItem(
                        onTap: () {
                          context.pushNamed('viewDrillPlan',
                              params: {'drillID': drillPlan.drillID});
                        },
                        child: const Text('View Drill Plan'),
                      ),
                      if (userCreatedDrill)
                        PopupMenuItem(
                          onTap: () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              showDialog(
                                context: context,
                                builder: (context) => PublishDrillDialog(
                                  drillPlan.drillID,
                                  onSuccess: widget.refreshDrillPlans,
                                ),
                              );
                            });
                            // ignore: avoid_print
                            print('Publish drill');
                          },
                          child: const Text('Publish'),
                        ),
                      if (!userCreatedDrill)
                        PopupMenuItem(
                          onTap: () {
                            context.pushNamed('viewDrillPlanJson',
                                params: {'drillID': drillPlan.drillID});
                            // ignore: avoid_print
                            print('View JSON');
                            GoRouter.of(context)
                                .addListener(updateDashLeavingView);
                          },
                          child: const Text('View JSON'),
                        ),
                      const PopupMenuDivider(),
                      PopupMenuItem(
                        onTap: () {
                          drillPlan
                              .duplicate(auth.currentUser!.uid,
                                  auth.currentUser!.email!)
                              .then((value) {
                            showDialogHere(
                                DuplicateDrillPlanResultDialog(value));
                            widget.refreshDrillPlans();
                          });
                        },
                        child: const Text('Duplicate'),
                      ),
                      if (userCreatedDrill)
                        PopupMenuItem(
                          onTap: () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    ConfirmDeleteDrillPlanDialog(
                                  drillPlan,
                                  onSuccess: widget.refreshDrillPlans,
                                ),
                              );
                            });
                          },
                          child: const Text('Delete'),
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
