import 'package:flutter/material.dart';

import '../dialogs/insert_evac_action_dialog.dart';
import '../dialogs/reorder_evac_actions_dialog.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../components/evac_action_fields/evac_instruction_field.dart';
import '../components/evac_action_fields/wait_for_start_field.dart';
import '../models/evac_action_plans/evac_action_plan.dart';
import '../models/task_details_plans/practice_evac_details_plan.dart';
import 'plan_drill_controller.dart';

class PDEvacuation extends StatefulWidget {
  const PDEvacuation(this.pdController, this.taskID, {super.key});

  final PDController pdController;
  final String taskID;

  @override
  State<PDEvacuation> createState() => _PDEvacuationState();
}

class _PDEvacuationState extends State<PDEvacuation> {
  int taskIndex = -1;
  final _actionsScrollControl = ScrollController();

  @override
  void initState() {
    super.initState();
    taskIndex = widget.pdController.drillPlan.tasks
        .indexWhere((element) => element.taskID == widget.taskID);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _actionsScrollControl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
        // PDEvacuation Body
        Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 32, 16, 4),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectionArea(
                  child: Text(
                'Evacuation',
                style: FFTheme.of(context).title1,
              )),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FFButtonWidget(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: ((context) => ReorderEvacActionsDialog(
                                widget.pdController,
                                widget.taskID,
                                taskIndex,
                              )));
                    },
                    text: 'Reorder',
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
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                    child: FFButtonWidget(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: ((context) => InsertEvacActionDialog(
                                widget.pdController, widget.taskID)));
                      },
                      text: 'Add Evac. Action',
                      icon: const Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                        size: 15,
                      ),
                      options: FFButtonOptions(
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
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
          child: Row(children: [
            SelectionArea(
                child: Tooltip(
              message: 'edit this title on the Procedure page',
              child: Text(
                widget.pdController.drillPlan.tasks[taskIndex].title ??
                    '[no practice evacuation title yet]',
                style: FFTheme.of(context).subtitle1.override(
                      fontFamily: 'Outfit',
                      color: FFTheme.of(context).primaryText,
                    ),
              ),
            )),
          ]),
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
            controller: _actionsScrollControl,
            thumbVisibility: true,
            child: ListView(
              controller: _actionsScrollControl,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: List.generate(
                (widget.pdController.drillPlan.tasks[taskIndex].details
                        as PracticeEvacDetailsPlan)
                    .actions
                    .length,
                (index) {
                  final action = (widget.pdController.drillPlan.tasks[taskIndex]
                          .details as PracticeEvacDetailsPlan)
                      .actions[index];
                  switch (action.actionType) {
                    case EvacActionType.instruction:
                      return EvacInstructionField(
                        widget.pdController,
                        widget.taskID,
                        action as InstructionActionPlan,
                      );
                    case EvacActionType.waitForStart:
                      return WaitForStartField(
                        widget.pdController,
                        widget.taskID,
                        action as WaitForStartActionPlan,
                      );
                    default:
                      throw Exception(
                          'Internal: Bad EvacActionType on PDEvacuation list generation');
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
