import 'package:flutter/material.dart';

import '../components/drill_task_fields/index.dart';
import '../dialogs/insert_drill_task_dialog.dart';
import '../dialogs/reorder_tasks_dialog.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../models/drill_task_plan.dart';
import 'plan_drill_controller.dart';

class PDProcedure extends StatefulWidget {
  const PDProcedure(this.pdController, {super.key});

  final PDController pdController;

  @override
  State<PDProcedure> createState() => _PDProcedureState();
}

class _PDProcedureState extends State<PDProcedure> {
  final ScrollController _tasksScrollControl = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _tasksScrollControl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
        // PDProcedure Body
        Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 32, 16, 12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectionArea(
                  child: Text(
                'Procedure',
                style: FFTheme.of(context).title1,
              )),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                    child: FFButtonWidget(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: ((context) =>
                                ReorderTasksDialog(widget.pdController)));
                      },
                      text: 'Reorder Tasks',
                      icon: Icon(
                        Icons.reorder_rounded,
                        color: FFTheme.of(context).primaryBackground,
                        size: 15,
                      ),
                      options: FFButtonOptions(
                        height: 40,
                        color: FFTheme.of(context).secondaryText,
                        textStyle: FFTheme.of(context).subtitle2.override(
                              fontFamily: 'Space Grotesk',
                              color: FFTheme.of(context).primaryBackground,
                            ),
                        borderSide: const BorderSide(
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: ((context) =>
                              InsertDrillTaskDialog(widget.pdController)));
                    },
                    text: 'Add Task',
                    icon: const Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                      size: 15,
                    ),
                    options: FFButtonOptions(
                      width: 128,
                      height: 40,
                      color: FFTheme.of(context).primaryColor,
                      textStyle: FFTheme.of(context).subtitle2.override(
                            fontFamily: 'Space Grotesk',
                            color: Colors.white,
                          ),
                      borderSide: const BorderSide(
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 2,
          thickness: 2,
          indent: 12,
          endIndent: 12,
          color: FFTheme.of(context).tertiaryColor,
        ),
        Expanded(
          child: Scrollbar(
            controller: _tasksScrollControl,
            thumbVisibility: true,
            child: ListView(
              padding: EdgeInsets.zero,
              controller: _tasksScrollControl,
              children: List.generate(
                  widget.pdController.drillPlan.tasks.length, (index) {
                final thisTask = widget.pdController.drillPlan.tasks[index];
                switch (thisTask.taskType) {
                  case DrillTaskType.practiceEvac:
                    return PracticeEvacTaskField(
                      thisTask,
                      widget.pdController,
                    );
                  case DrillTaskType.survey:
                    return SurveyTaskField(
                      thisTask,
                      widget.pdController,
                    );
                  case DrillTaskType.reqLocPerms:
                    return ReqLocPermsTaskField(
                      thisTask,
                      widget.pdController,
                    );
                  case DrillTaskType.upload:
                    return UploadTaskField(
                      thisTask,
                      widget.pdController,
                    );
                  // case DrillTaskType.travel:
                  //   TravelTaskField();
                  //   break;
                  default:
                    throw Exception(
                        'internal: bad DrillTaskType on Procedure Tasks List');
                }
              }),
              //  [
              //   // SurveyTaskField(),
              //   // ReqLocPermsTaskField(),
              //   // PracticeEvacTaskField(),
              //   // SurveyTaskField(),
              //   // UploadTaskField(),
              // ],
            ),
          ),
        ),
      ],
    );
  }
}
