import 'dart:async';
import 'package:evac_app/components/instruction_display.dart';
import 'package:evac_app/components/utility/styled_alert_dialog.dart';
import 'package:evac_app/location_tracking/location_tracker.dart';
import 'package:evac_app/models/drill_details/drill_tasks/task_details/practice_evac_details.dart';
import 'package:evac_app/models/drill_stopwatch.dart';
import 'package:evac_app/models/instructions/instructions.dart';
import 'package:evac_app/styles.dart';
import 'package:flutter/material.dart';

class PracticeEvacDisplay extends StatefulWidget {
  PracticeEvacDisplay({
    Key? key,
    required this.practiceEvacDetails,
    required this.userID,
    required this.setPracticeEvacResult,
  }) : super(key: key);

  final PracticeEvacDetails practiceEvacDetails;
  final String userID;
  final Function setPracticeEvacResult;

  static const valueKey = ValueKey('PracticeEvacDisplay');
  final DateTime startDateTime = DateTime.now();

  @override
  _PracticeEvacDisplayState createState() => _PracticeEvacDisplayState();
}

class _PracticeEvacDisplayState extends State<PracticeEvacDisplay> {
  // TODO: Handle if user does not allow location tracking permissions

  var showColors = false;

  final DateTime startTime = DateTime.now();

  double? distance;
  int? elevation;
  // String representation of time elapsed
  String minutesStr = '00', secondsStr = '00';
  DrillStopwatch stopwatch = DrillStopwatch();
  late StreamSubscription stopwatchSubscription;

  LocationTracker locTracker = LocationTracker();

  @override
  void initState() {
    super.initState();

    // start stopwatch
    stopwatchSubscription = stopwatch.getStream().listen((int counter) {
      setState(() {
        minutesStr = ((counter / 60).floor() % 60).toString().padLeft(2, '0');
        secondsStr = (counter % 60).toString().padLeft(2, '0');
      });
    });

    // start tracking location
    locTracker.startLogging();
  }

  // TODO: round elevation

  Future<void> completeDrill(BuildContext context, bool completed) async {
    // get time:
    final DateTime endTime = DateTime.now();

    // get difference between end and start
    final Duration duration = endTime.difference(startTime);

    // stop tracking location
    await locTracker.stopLogging();

    // cancel stopwatch stream subscription
    stopwatchSubscription.cancel();

    // create gpxFile
    final gpxFileNameFuture = locTracker.createTrajectory(
        widget.userID + '-' + widget.practiceEvacDetails.taskID);

    // handle results:
    widget.setPracticeEvacResult(
        startTime, endTime, duration, distance, gpxFileNameFuture, completed);

    Map<String, dynamic> results = {
      'result': true,
      'gpxFileNameFuture': gpxFileNameFuture,
    };

    // pop navigator
    Navigator.pop(context, results);
  }

  @override
  Widget build(BuildContext context) {
    var topContext = context;

    return Scaffold(
      // title: 'example drill',
      // backButton: true,
      // backButtonFunc: confirmEndDrillEarly,
      backgroundColor: Colors.blue[400],
      body: SafeArea(
        child: Stack(
          children: [
            LayoutBuilder(builder: (BuildContext context, constraints) {
              var height = constraints.maxHeight;
              var width = constraints.maxWidth;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: height * .034),
                  Container(
                    height: height * (0.55 - .034),
                    child: InstructionDisplay(
                      width: width,
                      completeDrill: completeDrill,
                      instructions: Instructions.fromJson(
                          widget.practiceEvacDetails.instructionsJson),
                    ),
                  ),
                  Container(
                    height: height * 0.25,
                    color: showColors ? Colors.white12 : null,
                    child: Center(
                      child: Text(
                        '$minutesStr:$secondsStr',
                        style: Styles.timerText,
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.2,
                    color: showColors ? Colors.white24 : null,
                    child: Row(
                      children: [
                        Container(
                          width: width * 0.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // worried that walking icon is ableist, or insensitive
                                  // but still probably a better icon choice out there than "redo"
                                  Icon(Icons.redo_rounded),
                                  SizedBox(width: 8),
                                  Text(
                                    'Distance',
                                    style: Styles.duringDrillDashLabel,
                                  ),
                                ],
                              ),
                              Text(
                                locTracker.distanceTravelled.toStringAsFixed(2),
                                style: Styles.duringDrillDashData,
                              ),
                              Text(
                                'mi',
                                style: Styles.duringDrillDashLabel,
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: width * 0.5,
                          color: showColors ? Colors.white24 : null,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.landscape_rounded),
                                  SizedBox(width: 8),
                                  Text(
                                    'Elevation',
                                    style: Styles.duringDrillDashLabel,
                                  ),
                                ],
                              ),
                              Text(
                                '~' + locTracker.currentElevation.toString(),
                                style: Styles.duringDrillDashData,
                              ),
                              Text(
                                'ft',
                                style: Styles.duringDrillDashLabel,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
            Align(
              alignment: Alignment.topLeft,
              child: BackButton(
                color: Colors.white.withAlpha(142),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StyledAlertDialog(
                        context: context,
                        title: 'Wait!',
                        subtitle:
                            'Are you sure that you want to exit the drill early? This action cannot be undone.',
                        cancelText: 'Continue Drill',
                        cancelFunc: () {
                          Navigator.pop(context);
                        },
                        confirmText: 'Exit Drill',
                        confirmFunc: () async {
                          // gather and save results, pop this dialog
                          await completeDrill(context, false);
                          // pop during drill page
                          Navigator.pop(topContext, {'result': false});
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
