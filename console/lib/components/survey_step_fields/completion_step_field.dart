import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../../models/survey_step_plans/completion_step_plan.dart';
import '../../plan_drill/plan_drill_controller.dart';

class CompletionStepField extends StatefulWidget {
  const CompletionStepField(
    this.pdController,
    this.taskID,
    this.completionStep, {
    super.key,
  });

  final PDController pdController;
  final String taskID;
  final CompletionStepPlan completionStep;

  @override
  State<CompletionStepField> createState() => _CompletionStepFieldState();
}

class _CompletionStepFieldState extends State<CompletionStepField> {
  TextEditingController? titleController;
  TextEditingController? textController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.completionStep.title);
    textController = TextEditingController(text: widget.completionStep.text);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    titleController?.dispose();
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
                      'Survey Completion Step',
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
                          widget.pdController.removeStep(
                            widget.taskID,
                            widget.completionStep.stepID['id']!,
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
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                      child: SelectionArea(
                          child: Text(
                        'Title: ',
                        style: FFTheme.of(context).bodyText1,
                      )),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: titleController,
                        onChanged: (value) => widget.pdController
                            .setSurveyStepParam(
                                widget.taskID,
                                widget.completionStep.stepID['id']!,
                                'title',
                                value),
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: '[Please complete our Pre-Drill survey…]',
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
                        'Description [optional]:',
                        style: FFTheme.of(context).bodyText1,
                      )),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: textController,
                        onChanged: (value) => widget.pdController
                            .setSurveyStepParam(
                                widget.taskID,
                                widget.completionStep.stepID['id']!,
                                'text',
                                value),
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText:
                              '[This survey will help us to better understand the efficacy of our tsunami evacuation infrastructure…]',
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
