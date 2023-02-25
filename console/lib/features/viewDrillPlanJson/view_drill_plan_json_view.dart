import 'package:evac_drill_console/flutter_flow/flutter_flow_util.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../models/drill_plan.dart';

class ViewDrillPlanJsonView extends StatefulWidget {
  const ViewDrillPlanJsonView(this.drillPlan, {super.key});

  final DrillPlan drillPlan;

  @override
  State<ViewDrillPlanJsonView> createState() => _ViewDrillPlanJsonViewState();
}

class _ViewDrillPlanJsonViewState extends State<ViewDrillPlanJsonView> {
  TextEditingController drillPlanJsonController = TextEditingController();
  String jsonError = '';
  bool jsonIsLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() => drillPlanJsonController.text = widget.drillPlan.copyJson());
  }

  @override
  void dispose() {
    drillPlanJsonController.dispose();
    super.dispose();
  }

  void setJSONIsLoading() {
    setState(() {
      jsonIsLoading = !jsonIsLoading;
    });
  }

  Future<String?> importDrillPlanFromJSON(String text, String drillID) async {
    // ignore: avoid_print
    print('importDrillPlanFromJSON @ ${_timestamp()}');
    // ignore: avoid_print
    print('duplicating drill…');
    final newDrillID = await duplicateDrillPlan(widget.drillPlan);
    if (newDrillID != null) {
      // ignore: avoid_print
      print('duplicated drill, getting from backend…');
      final newDrillPlan = await DrillPlan.fromDrillID(newDrillID);
      if (newDrillPlan != null) {
        // ignore: avoid_print
        print('got duplicated drill, parsing input…');
        final auth = FirebaseAuth.instanceFor(
          app: Firebase.app(),
          persistence: Persistence.INDEXED_DB,
        );
        final updatedDrillPlan = await _handleDrillPlanJSONException(
          DrillPlan.fromUserInputJson,
          text,
          newDrillID,
          auth.currentUser!.uid,
          auth.currentUser!.email!,
        );
        if (updatedDrillPlan != null) {
          // ignore: avoid_print
          print('parsed input, syncing changes.');
          await updateDrillPlanDoc(updatedDrillPlan);
          return newDrillID;
        } else {
          // ignore: avoid_print
          print('null output from DrillPlan.fromUserInputJson');
          return null;
        }
      }
    } else {
      // ignore: avoid_print
      print('could not duplicated drill');
      return null;
    }
    return null;
  }

  Future<DrillPlan?> _handleDrillPlanJSONException(
    Future<DrillPlan?> Function(
      Map<String, dynamic> json,
      String drillID,
      String userID,
      String userEmail,
    )
        function,
    String jsonText,
    String drillID,
    String userID,
    String userEmail,
  ) async {
    setJSONIsLoading();
    try {
      final json = jsonDecode(jsonText);
      final result = await function(json, drillID, userID, userEmail);
      return result;
    } on FormatException catch (e) {
      // log += 'FirebaseAuthException e: ${e.toString()}' + '\n';
      // ignore: avoid_print
      print(e.message);
      setState(() {
        // ignore: avoid_print
        jsonError = e.message;
      });
    } catch (e) {
      // log += 'regular e: ${e.toString()}' + '\n';
      // ignore: avoid_print
      print('$e');
      setState(() {
        jsonError = '$e';
      });
    } finally {
      setJSONIsLoading();
    }
    return null;
  }

  Future<String?> duplicateDrillPlan(DrillPlan d) async {
    // ignore: avoid_print
    print('updateDrillPlanDoc @ ${_timestamp()} on ${d.drillID}');
    final auth = FirebaseAuth.instanceFor(
      app: Firebase.app(),
      persistence: Persistence.INDEXED_DB,
    );
    final res =
        await d.duplicate(auth.currentUser!.uid, auth.currentUser!.email!);
    if (res != null) {
      // ignore: avoid_print
      print('successfully duplicated Drill Plan: ${d.drillID}');
      // ignore: avoid_print
      print('new drillID: $res');
      return res;
    } else {
      // ignore: avoid_print
      print('failed to update DrillPlan ${d.drillID}');
      return null;
    }
  }

  Future<void> updateDrillPlanDoc(DrillPlan d) async {
    // ignore: avoid_print
    print('updateDrillPlanDoc @ ${_timestamp()} on ${d.drillID}');
    final res = await d.updateDoc();
    if (res != null) {
      // ignore: avoid_print
      print('successfully updated Drill Plan: ${d.drillID}');
    } else {
      // ignore: avoid_print
      print('failed to update DrillPlan ${d.drillID}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _ViewDrillPlanJsonWrapper(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // controls (buttons)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // DefaultFFButton(
              //   'get json',
              //   () async => jsonIsLoading
              //       ? null
              //       : drillPlanJsonController.text =
              //           await getDrillPlanJSON(drillID) ?? '',
              // ),
              Tooltip(
                message: 'this is not your drill, duplicate to edit',
                child: DefaultFFButton(
                    'duplicate plan and save changes',
                    () => jsonIsLoading
                        ? null
                        : {
                            importDrillPlanFromJSON(
                              drillPlanJsonController.text,
                              widget.drillPlan.drillID,
                            ).then((value) {
                              if (value != null) {
                                context.goNamed(
                                  'editDrillPlanJson',
                                  params: {'drillID': value},
                                );
                              }
                            })
                          }),
              ),
            ],
          ),
          // error banner
          Visibility(
              visible: jsonError.isNotEmpty,
              child: MaterialBanner(
                backgroundColor: Theme.of(context).colorScheme.error,
                content: Text(jsonError),
                actions: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          jsonError = '';
                        });
                      },
                      child: const Text(
                        'dismiss',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
                contentTextStyle: const TextStyle(color: Colors.white),
                padding: const EdgeInsets.all(10),
              )),
          // actual TextField for DrillPlan json
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
            child: TextField(
              controller: drillPlanJsonController,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Drill Plan JSON',
                labelStyle: FFTheme.of(context).bodyText1.override(
                      fontFamily: 'Space Grotesk',
                      color: FFTheme.of(context).secondaryText,
                    ),
                hintText: 'Drill Plan in JSON goes here...',
                hintStyle: FFTheme.of(context).bodyText2,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FFTheme.of(context).tertiaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FFTheme.of(context).tertiaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: FFTheme.of(context).secondaryBackground,
                contentPadding:
                    const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
              ),
              style: FFTheme.of(context).bodyText1,
              textAlign: TextAlign.start,
              maxLines: 30,
              keyboardType: TextInputType.multiline,
            ),
          ),
        ],
      ),
    );
  }
}

class _ViewDrillPlanJsonWrapper extends StatelessWidget {
  const _ViewDrillPlanJsonWrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(
                    maxWidth: 570,
                  ),
                  decoration: BoxDecoration(
                    color: FFTheme.of(context).primaryBackground,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33000000),
                        offset: Offset(0, 3),
                        spreadRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

String _timestamp() {
  final now = DateTime.now();
  final hour = now.hour;
  final min = now.minute;
  final sec = now.second;
  return '${(hour / 10 >= 1) ? hour.toString() : '0${hour.toString()}'}:${(min / 10 >= 1) ? min.toString() : '0${min.toString()}'};${(sec / 10 >= 1) ? sec.toString() : '0${sec.toString()}'}';
}
