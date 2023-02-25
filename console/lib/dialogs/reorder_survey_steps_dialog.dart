import 'package:evac_drill_console/flutter_flow/flutter_flow_icon_button.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import '../models/survey_step_plans/survey_step_plan.dart';
import '../models/task_details_plans/survey_details_plan.dart';
import '../plan_drill/plan_drill_controller.dart';

class ReorderSurveyStepsDialog extends StatefulWidget {
  const ReorderSurveyStepsDialog(this.pdController, this.taskID, this.taskIndex,
      {super.key});
  // const ReorderSurveyStepsDialog(this.tasks, {super.key});

  final PDController pdController;
  final String taskID;
  final int taskIndex;

  @override
  State<ReorderSurveyStepsDialog> createState() =>
      _ReorderSurveyStepsDialogState();
}

class _ReorderSurveyStepsDialogState extends State<ReorderSurveyStepsDialog> {
  List<SurveyStepPlan> steps = [];
  @override
  void initState() {
    super.initState();
    for (final step in (widget.pdController.drillPlan.tasks[widget.taskIndex]
            .details as SurveyDetailsPlan)
        .surveySteps) {
      steps.add(step);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          // width: double.infinity,
          decoration: BoxDecoration(
            color: FFTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          constraints: BoxConstraints.loose(const Size(600, 800)),
          padding:
              const EdgeInsets.all(16).add(const EdgeInsets.only(bottom: 8)),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title bar
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 24),
                      child: SelectionArea(
                          child: Text(
                        'Reorder Survey Steps',
                        style: FFTheme.of(context).title2.override(
                              fontFamily: 'Outfit',
                              color: FFTheme.of(context).secondaryText,
                            ),
                      )),
                    ),
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 12,
                      borderWidth: 2,
                      buttonSize: 48,
                      icon: Icon(
                        Icons.close_rounded,
                        color: FFTheme.of(context).secondaryText,
                        size: 24,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),

                // Center(
                //   child: ConstrainedBox(
                //     constraints: BoxConstraints(maxWidth: 400),

                // Expanded(
                // child:
                Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.transparent,
                    // shadowColor: Colors.transparent,
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 400,
                      height: 600,
                      child: ReorderableListView.builder(
                          shrinkWrap: true,
                          onReorder: (oldIndex, newIndex) {
                            // wtf…oh ok newIndex counts the moved item as before it
                            if (newIndex > steps.length) {
                              newIndex = steps.length;
                            }
                            if (oldIndex < newIndex) newIndex -= 1;

                            setState(() {
                              final item = steps[oldIndex];
                              steps.removeAt(oldIndex);
                              steps.insert(newIndex, item);
                            });
                          },
                          itemCount: steps.length,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          itemBuilder: (context, index) {
                            final tileText1 = steps[index].type.fullName;
                            String tileText2 =
                                steps[index].title ?? 'no title yet';
                            if (tileText2.length > 26) {
                              tileText2 = '${tileText2.substring(0, 26)}…';
                            }
                            // How did you hear about this evacuation drill?
                            // you hear about this evacua
                            return Material(
                              key: Key(steps[index].stepID['id'] ??
                                  index.toString()),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: FFTheme.of(context).tertiaryColor,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SelectionArea(
                                        child: Text(
                                      tileText1,
                                      style: FFTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Space Grotesk',
                                            color: FFTheme.of(context)
                                                .secondaryText,
                                          ),
                                    )),
                                    const SizedBox(width: 4),
                                    SelectionArea(
                                        child: Text(
                                      tileText2,
                                      style: FFTheme.of(context).bodyText1,
                                    )),
                                  ],
                                ),
                              ),
                            );
                            // final tileName =
                            //     '${tasks[index].taskType.fullName}: "${tasks[index].title ?? 'no title yet'}"';
                            // return Material(
                            //   key: Key(tasks[index].taskID),
                            //   borderRadius: BorderRadius.circular(8),
                            //   child: ListTile(
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(8),
                            //     ),
                            //     title: Text(tileName),
                            //     tileColor:
                            //         // (index % 2 == 1)
                            //         //     ?
                            //         FFTheme.of(context).secondaryBackground
                            //     // : null
                            //     ,
                            //   ),
                            // );
                          }),
                    ),
                  ),
                ),
                // ),

                // bottom buttons
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: FFButtonWidget(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          text: 'Cancel',
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            color: const Color(0x95C00000),
                            textStyle: FFTheme.of(context).subtitle2.override(
                                  fontFamily: 'Space Grotesk',
                                  color: FFTheme.of(context).primaryText,
                                ),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () {
                          widget.pdController
                              .setSurveySteps(widget.taskID, steps);
                          Navigator.of(context).pop();
                          // Navigator.of(context).pop(tasks);
                        },
                        text: 'Apply',
                        options: FFButtonOptions(
                          width: 130,
                          height: 40,
                          color: FFTheme.of(context).primaryColor,
                          textStyle: FFTheme.of(context).subtitle2.override(
                                fontFamily: 'Space Grotesk',
                                color: Colors.white,
                              ),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
