import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../../models/evac_action_plans/instruction_action_plan.dart';
import '../../plan_drill/plan_drill_controller.dart';

class EvacInstructionField extends StatefulWidget {
  const EvacInstructionField(
    this.pdController,
    this.taskID,
    this.instructionAction, {
    super.key,
  });

  final PDController pdController;
  final String taskID;
  final InstructionActionPlan instructionAction;

  @override
  State<EvacInstructionField> createState() => _EvacInstructionFieldState();
}

class _EvacInstructionFieldState extends State<EvacInstructionField> {
  TextEditingController? textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.instructionAction.text);
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
          padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
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
                      'Evacuation Instruction',
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
                          widget.pdController.removeAction(
                            widget.taskID,
                            widget.instructionAction.actionID,
                          );
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
                padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 8, 0),
                      child: SelectionArea(
                          child: Text(
                        'Instruction:',
                        style: FFTheme.of(context).bodyText1,
                      )),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: textController,
                        onChanged: (value) => widget.pdController
                            .setActionParam(
                                widget.taskID,
                                widget.instructionAction.actionID,
                                'text',
                                value),
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText:
                              '[Get to high ground! Minimum elevation is 40 feet…]',
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
                        maxLines: 5,
                      ),
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
