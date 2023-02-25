import 'package:evac_drill_console/flutter_flow/flutter_flow_icon_button.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../models/evac_action_plans/evac_action_plan.dart';
import '../plan_drill/plan_drill_controller.dart';

class InsertEvacActionDialog extends StatefulWidget {
  const InsertEvacActionDialog(this.pdController, this.taskID, {super.key});

  final PDController pdController;
  final String taskID;

  @override
  State<InsertEvacActionDialog> createState() => _InsertEvacActionDialogState();
}

class _InsertEvacActionDialogState extends State<InsertEvacActionDialog> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: FFTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          constraints: BoxConstraints.loose(const Size(800, 880)),
          padding: const EdgeInsets.all(16),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 24),
                    child: Text(
                      'Insert Task',
                      style: FFTheme.of(context).title2.override(
                            fontFamily: 'Outfit',
                            color: FFTheme.of(context).secondaryText,
                          ),
                    ),
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
              // task type buttons
              Expanded(
                child: GridView(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.8,
                  ),
                  primary: false,
                  scrollDirection: Axis.vertical,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          widget.pdController.addAction(
                              widget.taskID, EvacActionType.waitForStart);
                          Navigator.of(context).pop();
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 120,
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: FFTheme.of(context).tertiaryColor,
                              width: 3,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.watch_later_outlined,
                                  color: FFTheme.of(context).secondaryText,
                                  size: 96,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    'Wait For Start',
                                    textAlign: TextAlign.center,
                                    style: FFTheme.of(context).title3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          widget.pdController.addAction(
                              widget.taskID, EvacActionType.instruction);
                          Navigator.of(context).pop();
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 120,
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: FFTheme.of(context).tertiaryColor,
                              width: 3,
                            ),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                color: FFTheme.of(context).secondaryText,
                                size: 96,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  'Instruction',
                                  textAlign: TextAlign.center,
                                  style: FFTheme.of(context).title3,
                                ),
                              ),
                            ],
                          ),
                        ),
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
