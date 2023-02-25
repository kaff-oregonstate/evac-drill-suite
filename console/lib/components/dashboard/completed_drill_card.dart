import 'package:cloud_functions/cloud_functions.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_util.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import '../../models/drill_plan.dart';
import 'download_results_dialog.dart';
import 'drill_plan_status_icon.dart';
import 'duplicate_drill_plan_result_dialog.dart';

class CompletedDrillCard extends StatefulWidget {
  const CompletedDrillCard(this.drillPlan, this.refreshDrillPlans, {super.key});

  final DrillPlan drillPlan;
  final Function refreshDrillPlans;

  @override
  State<CompletedDrillCard> createState() => _CompletedDrillCardState();
}

class _CompletedDrillCardState extends State<CompletedDrillCard>
    with TickerProviderStateMixin {
  final auth = FirebaseAuth.instanceFor(
    app: Firebase.app(),
    persistence: Persistence.INDEXED_DB,
  );
  bool userCreatedDrill = false;

  int _numOfParticipants = 0;
  int _numParticipantsUploaded = 0;

  List<Future> futures = [];
  bool _loadingNumParticipants = true;
  void setLoading([bool? val]) {
    if (mounted) {
      setState(() => _loadingNumParticipants = val ?? !_loadingNumParticipants);
    }
  }

  static const emulating = false;

  @override
  void initState() {
    super.initState();
    final uid = auth.currentUser!.uid;
    userCreatedDrill = widget.drillPlan.creatorID == uid;

    // FIXME: use numOfParticipants once implemented
    // (need app to be creating Participants collection for DrillPlan)
    futures.add(numOfParticipantResults());
    futures.add(resultsDigest());

    Future.wait(futures).then((value) => setLoading(false));

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  Future<void> numOfParticipantResults() async {
    try {
      final functionsInstance = FirebaseFunctions.instance;

      final debug = FFAppState().debug && emulating;
      const host = '127.0.0.1';
      const port = 5001;
      if (debug) {
        functionsInstance.useFunctionsEmulator(host, port);
      }

      final result = await functionsInstance
          .httpsCallable('numOfParticipantResults')
          .call({'drillID': widget.drillPlan.drillID});

      // // ignore: avoid_print
      // print(result.data?.toString() ?? 'no data');
      // // ignore: avoid_print
      // print(result.data?['numOfParticipantResults'].toString() ?? 'no data');
      if (mounted) {
        setState(() {
          _numOfParticipants = result.data?['numOfParticipantResults'] ?? 0;
        });
      }
    } on FirebaseFunctionsException catch (error) {
      // ignore: avoid_print
      print('Error: ${error.code}');
      // ignore: avoid_print
      print('Error: ${error.details ?? 'no details'}');
      // ignore: avoid_print
      print('Error: ${error.message ?? 'no message'}');
    }
  }

  Future<void> resultsDigest() async {
    try {
      final functionsInstance = FirebaseFunctions.instance;

      final debug = FFAppState().debug && emulating;
      if (debug) {
        const host = '127.0.0.1';
        const port = 5001;
        functionsInstance.useFunctionsEmulator(host, port);
      }

      final result = await functionsInstance
          .httpsCallable('resultsDigest')
          .call({'drillID': widget.drillPlan.drillID});

      if (result.data['error'] != null) {
        // ignore: avoid_print
        print('Error:');
        // ignore: avoid_print
        print(result.data?['error'] ?? 'no data');
        // ignore: avoid_print
        print(result.data?['errorText'] ?? 'no data');
      } else {
        // // ignore: avoid_print
        // print(result.data?.toString() ?? 'no data');
        // // ignore: avoid_print
        // print(result.data?['success'] ?? 'no data');
        // // ignore: avoid_print
        // print(result.data?['resultsDigest'].toString() ?? 'no data');

        final results = result.data?['resultsDigest'] as List?;

        if (mounted) {
          setState(() {
            _numParticipantsUploaded = results?.length ?? 0;
          });
        }
      }
    } on FirebaseFunctionsException catch (error) {
      // ignore: avoid_print
      print('Error: ${error.code}');
      // ignore: avoid_print
      print('Error: ${error.details ?? 'no details'}');
      // ignore: avoid_print
      print('Error: ${error.message ?? 'no message'}');
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
      // ignore: avoid_print
      print('Error Type: ${e.runtimeType}');
    }
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

  static String readableDayTime(DateTime dateTime) {
    // yesterday, today, or tomorrow?
    final now = DateTime.now();
    if (dateTime.difference(now).inDays > 1) {
      throw const FormatException(
          'Internal: attempting to parse date differences on dates too far apart');
    }
    final lastMidnight = DateTime(now.year, now.month, now.day);
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    final diffLast = dateTime.difference(lastMidnight).inHours;
    final diffNext = dateTime.difference(nextMidnight).inHours;
    String dayString = '';
    if (diffLast < 0) {
      dayString = 'Yesterday';
    } else if (diffNext < 0) {
      dayString = 'Today';
    } else {
      dayString = 'Tomorrow';
    }
    final hour24 = DateFormat.H().format(dateTime);
    final hourInt = int.parse(hour24);
    final hour = (hourInt > 12) ? (hourInt % 12).toString() : hour24;
    final amPm = (int.parse(hour24) > 11) ? 'pm' : 'am';
    final minutes = DateFormat.m().format(dateTime);
    final min = (int.parse(minutes) == 0) ? null : minutes;
    final timeZone = onlyCap(dateTime.timeZoneName);
    return '$dayString at $hour${(min != null) ? ":$min" : ""} $amPm $timeZone';
  }

  /// These listeners get registered to the GoRouter whenever pushing a page on
  /// top of the Planned Drills page that this PlannedDrillCard lives on.
  /// It ensures that all of the PlannedDrillCards get refreshed on return to
  /// the Planned Drills Page.
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
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
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
          padding: const EdgeInsetsDirectional.fromSTEB(12, 16, 12, 12),
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
                        ),
                      ),
                      // user owns indicator
                      if (userCreatedDrill)
                        const DrillPlanStatusIcon(
                          'You created this drill,\nand can access results',
                          Icons.lock_open_rounded,
                        ),
                      if (!userCreatedDrill)
                        const DrillPlanStatusIcon(
                          'You did not create this drill,\nbut can access encrypted results',
                          // 'You did not create this drill,\nand cannot access results',
                          Icons.lock_outline_rounded,
                        ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                        child: SelectionArea(
                          child: Text(
                            (dateTime != null)
                                ? (dateTime
                                            .difference(DateTime.now())
                                            .inDays
                                            .abs() <
                                        1)
                                    ? readableDayTime(dateTime)
                                    : readableDateTime(dateTime)
                                : 'ERROR: no meeting time yet',
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

                  Divider(
                    height: 24,
                    thickness: 2,
                    color: FFTheme.of(context).tertiaryColor,
                  ),

                  /// FIXME: can't get this to expand to bounds dynamically
                  /// but don't want to do the whole "measure widget after laid out" shenanigan, as it's quite disgusting in Flutter…
                  if (_numOfParticipants > 0)
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                      child: LinearPercentIndicator(
                        percent: _numParticipantsUploaded / _numOfParticipants,
                        width: 310,
                        lineHeight: 16,
                        animation: true,
                        progressColor: FFTheme.of(context).primaryColor,
                        backgroundColor: FFTheme.of(context).primaryBackground,
                        barRadius: const Radius.circular(16),
                        padding: EdgeInsets.zero,
                      ),
                    ),

                  if (_numOfParticipants > 0)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            _numParticipantsUploaded.toString(),
                            style: FFTheme.of(context).subtitle1.override(
                                fontFamily: 'Outfit',
                                color: FFTheme.of(context).primaryText),
                          ),
                          Text(
                            ' of ${_numOfParticipants.toString()} participants uploaded results so far',
                            style: FFTheme.of(context).subtitle1.override(
                                fontFamily: 'Outfit',
                                color: FFTheme.of(context).secondaryText),
                          ),
                        ],
                      ),
                    ),
                  if (!_loadingNumParticipants && _numOfParticipants == 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 6, bottom: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            '(no participants joined this drill?)',
                            style: FFTheme.of(context).subtitle1.override(
                                fontFamily: 'Outfit',
                                color: FFTheme.of(context).secondaryText),
                          ),
                        ],
                      ),
                    ),
                  if (_loadingNumParticipants)
                    Padding(
                      padding: const EdgeInsets.only(top: 6, bottom: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'loading participant data…',
                            style: FFTheme.of(context).subtitle1.override(
                                fontFamily: 'Outfit',
                                color: FFTheme.of(context).secondaryText),
                          ),
                        ],
                      ),
                    ),

                  // if (userCreatedDrill && _numParticipantsUploaded > 0)
                  if (_numParticipantsUploaded > 0)
                    Divider(
                      height: 24,
                      thickness: 2,
                      color: FFTheme.of(context).tertiaryColor,
                    ),
                  // if (userCreatedDrill && _numParticipantsUploaded > 0)
                  if (_numParticipantsUploaded > 0)
                    Center(
                      child: DefaultFFButton(
                        (_numOfParticipants > _numParticipantsUploaded)
                            ? 'Download results early'
                            : 'Download current results',
                        () => drillPlan
                            .accessResults(auth.currentUser!.uid)
                            .then((zipURL) {
                          if (zipURL != null) {
                            // prompt download in user's web browser
                            html.AnchorElement(href: zipURL)
                              ..setAttribute('download',
                                  'DrillResults-${drillPlan.drillID}.zip')
                              ..click();
                          } else {
                            // FIXME: Error handling on accessResults failure
                            // ignore: avoid_print
                            print(
                                'accessResults on drill with title "${(drillPlan.title == null || drillPlan.title!.isEmpty) ? 'no title yet' : drillPlan.title!}" and ID ${drillPlan.drillID} failed');
                          }
                        }),
                        icon: Icon(
                          Icons.download_rounded,
                          color: FFTheme.of(context).secondaryText,
                          size: 24,
                        ),
                        width: double.infinity,
                      ),
                    ),
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
                      if (userCreatedDrill && _numParticipantsUploaded > 0)
                        PopupMenuItem(
                          onTap: () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              showDialog(
                                context: context,
                                builder: (context) => DownloadResultsDialog(
                                  drillPlan,
                                  auth.currentUser!.uid,
                                ),
                              );
                            });
                          },
                          child: const Text('Download Results'),
                        ),
                      const PopupMenuDivider(),
                      PopupMenuItem(
                        onTap: () {
                          context.pushNamed('viewDrillPlan',
                              params: {'drillID': drillPlan.drillID});
                        },
                        child: const Text('View Drill Plan'),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          context.pushNamed('viewDrillPlanJson',
                              params: {'drillID': drillPlan.drillID});
                          GoRouter.of(context)
                              .addListener(updateDashLeavingView);
                          // ignore: avoid_print
                          print('View JSON');
                        },
                        child: const Text('View JSON'),
                      ),
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
                        child: const Text('Duplicate Drill'),
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
