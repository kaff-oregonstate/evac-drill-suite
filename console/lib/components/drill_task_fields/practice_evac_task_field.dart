import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/models/task_details_plans/task_details_plan.dart';
import 'package:evac_drill_console/plan_drill/plan_drill_controller.dart';
import 'package:flutter/material.dart';

import '../../models/drill_task_plan.dart';

class PracticeEvacTaskField extends StatefulWidget {
  const PracticeEvacTaskField(this.drillTask, this.pdController, {super.key});

  final DrillTaskPlan drillTask;
  final PDController pdController;

  @override
  State<PracticeEvacTaskField> createState() => _PracticeEvacTaskFieldState();
}

class _PracticeEvacTaskFieldState extends State<PracticeEvacTaskField> {
  TextEditingController? textController;
  bool? switchValue;

  @override
  void initState() {
    super.initState();
    final practiceEvacDetails =
        widget.drillTask.details as PracticeEvacDetailsPlan;
    textController = TextEditingController(
      text: practiceEvacDetails.title,
    );
    switchValue = practiceEvacDetails.trackingLocation;
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FFTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: FFTheme.of(context).tertiaryColor,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 12, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SelectionArea(
                        child: Text(
                      'Practice Evacuation',
                      style: FFTheme.of(context).title3.override(
                            fontFamily: 'Outfit',
                            color: FFTheme.of(context).secondaryText,
                          ),
                    )),
                    Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: () {
                          widget.pdController
                              .removeTask(widget.drillTask.taskID);
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.close_rounded,
                            color: Color(0xBF95A1AC),
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 24,
                thickness: 2,
                indent: 12,
                endIndent: 12,
                color: FFTheme.of(context).tertiaryColor,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                      child: SelectionArea(
                          child: Text(
                        'Title:',
                        style: FFTheme.of(context).bodyText1,
                      )),
                    ),
                    Expanded(
                      child: TextField(
                        controller: textController,
                        onChanged: (value) => widget.pdController
                            .setTaskParameter(widget.drillTask.taskID,
                                widget.drillTask.taskType, 'title', value),
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: '[Escape Tsunami Inundation Zone…]',
                          hintStyle: FFTheme.of(context).bodyText2,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: FFTheme.of(context).secondaryBackground,
                        ),
                        style: FFTheme.of(context).bodyText1,
                      ),
                    ),
                  ],
                ),
              ),
              // const WaitForStartTaskField(),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                      child: SelectionArea(
                          child: Text(
                        'Track location:',
                        style: FFTheme.of(context).bodyText1,
                      )),
                    ),
                    Switch(
                      value: switchValue ??= true,
                      onChanged: (newValue) {
                        setState(() => switchValue = newValue);
                        widget.pdController.setTrackingLocation(
                            widget.drillTask.taskID, newValue);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 4),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: SelectionArea(
                          child: Text(
                        '(Evacuation instructions will be planned in an ',
                        style: FFTheme.of(context).bodyText1.override(
                              fontFamily: 'Space Grotesk',
                              color: FFTheme.of(context).secondaryText,
                            ),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: SelectionArea(
                          child: Text(
                        'upcoming step',
                        style: FFTheme.of(context).bodyText1.override(
                              fontFamily: 'Space Grotesk',
                              color: FFTheme.of(context).secondaryText,
                              decoration: TextDecoration.underline,
                            ),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: SelectionArea(
                          child: Text(
                        ')',
                        style: FFTheme.of(context).bodyText1.override(
                              fontFamily: 'Space Grotesk',
                              color: FFTheme.of(context).secondaryText,
                            ),
                      )),
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
