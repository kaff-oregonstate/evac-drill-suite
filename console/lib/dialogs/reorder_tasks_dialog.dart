import 'package:evac_drill_console/flutter_flow/flutter_flow_icon_button.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import '../models/drill_task_plan.dart';
import '../plan_drill/plan_drill_controller.dart';

// extension on DrillTaskType {
//   String get fullName {
//     switch (this) {
//       case DrillTaskType.survey:
//         return 'Survey';
//       case DrillTaskType.reqLocPerms:
//         return 'Request Location Permissions';
//       case DrillTaskType.practiceEvac:
//         return 'Practice Evacuation';
//       case DrillTaskType.travel:
//         return 'Travel';
//       case DrillTaskType.upload:
//         return 'Upload';
//       default:
//         throw Exception('Internal: bad DrillTaskType on .fullName');
//     }
//   }
// }

class ReorderTasksDialog extends StatefulWidget {
  const ReorderTasksDialog(this.pdController, {super.key});
  // const ReorderTasksDialog(this.tasks, {super.key});

  final PDController pdController;
  // final List<DrillTaskPlan> tasks;

  @override
  State<ReorderTasksDialog> createState() => _ReorderTasksDialogState();
}

class _ReorderTasksDialogState extends State<ReorderTasksDialog> {
  List<DrillTaskPlan> tasks = [];
  @override
  void initState() {
    super.initState();
    for (final task in widget.pdController.drillPlan.tasks) {
      tasks.add(task);
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
          constraints: BoxConstraints.loose(const Size(600, 640)),
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
                        'Reorder Drill Tasks',
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
                      height: 300,
                      child: ReorderableListView.builder(
                          shrinkWrap: true,
                          onReorder: (oldIndex, newIndex) {
                            // wtf…oh ok newIndex counts the moved item as before it
                            if (newIndex > tasks.length) {
                              newIndex = tasks.length;
                            }
                            if (oldIndex < newIndex) newIndex -= 1;

                            setState(() {
                              final item = tasks[oldIndex];
                              tasks.removeAt(oldIndex);
                              tasks.insert(newIndex, item);
                            });
                          },
                          itemCount: tasks.length,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          itemBuilder: (context, index) {
                            final tileText1 = tasks[index].taskType.fullName;
                            String tileText2 =
                                tasks[index].title ?? 'no title yet';
                            if (tileText2.length > 19) {
                              // An example Location
                              tileText2 = '${tileText2.substring(0, 19)}…';
                            }
                            return Material(
                              key: Key(tasks[index].taskID),
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
                          widget.pdController.setTasks(tasks);
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
