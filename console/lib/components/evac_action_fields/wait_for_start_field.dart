import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_drop_down.dart';
import '../../models/evac_action_plans/wait_for_start_action_plan.dart';
import '../../plan_drill/plan_drill_controller.dart';

class WaitForStartField extends StatefulWidget {
  const WaitForStartField(
    this.pdController,
    this.taskID,
    this.waitForStartAction, {
    super.key,
  });

  final PDController pdController;
  final String taskID;
  final WaitForStartActionPlan waitForStartAction;

  @override
  State<WaitForStartField> createState() => _WaitForStartFieldState();
}

class _WaitForStartFieldState extends State<WaitForStartField> {
  WaitType? waitType;

  @override
  void initState() {
    super.initState();
    waitType = widget.waitForStartAction.waitType;
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
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
                      'Wait For Start Action',
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
                            widget.waitForStartAction.actionID,
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
                padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                      child: SelectionArea(
                          child: Text(
                        'Type of wait:',
                        style: FFTheme.of(context).bodyText1,
                      )),
                    ),
                    FlutterFlowDropDown<WaitType>(
                      initialOption: waitType,
                      options: WaitType.values,
                      onChanged: (value) {
                        setState(() => waitType = value);
                        widget.pdController.setActionParam(
                          widget.taskID,
                          widget.waitForStartAction.actionID,
                          'text',
                          value,
                        );
                      },
                      width: 180,
                      height: 50,
                      textStyle: FFTheme.of(context).bodyText1.override(
                            fontFamily: 'Space Grotesk',
                            color: FFTheme.of(context).primaryText,
                          ),
                      hintText: 'Please select...',
                      fillColor: FFTheme.of(context).secondaryBackground,
                      elevation: 2,
                      borderColor: Colors.transparent,
                      borderWidth: 0,
                      borderRadius: 12,
                      margin:
                          const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                      hidesUnderline: true,
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
