import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../../models/survey_step_plans/single_choice_q_plan.dart';
import '../../plan_drill/plan_drill_controller.dart';

class SingleChoiceQField extends StatefulWidget {
  const SingleChoiceQField(
    this.pdController,
    this.taskID,
    this.singleChoiceQ, {
    super.key,
  });

  final PDController pdController;
  final String taskID;
  final SingleChoiceQPlan singleChoiceQ;

  @override
  State<SingleChoiceQField> createState() => _SingleChoiceQueceQState();
}

class _SingleChoiceQueceQState extends State<SingleChoiceQField> {
  TextEditingController? titleController;
  TextEditingController? textController;
  TextEditingController? firstChoiceController;
  TextEditingController? secondChoiceController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.singleChoiceQ.title);
    textController = TextEditingController(text: widget.singleChoiceQ.text);
    firstChoiceController =
        TextEditingController(text: widget.singleChoiceQ.yesChoice);
    secondChoiceController =
        TextEditingController(text: widget.singleChoiceQ.noChoice);
    // WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    titleController?.dispose();
    textController?.dispose();
    firstChoiceController?.dispose();
    secondChoiceController?.dispose();
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
                      'Single Choice Question',
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
                            widget.singleChoiceQ.stepID['id']!,
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
                        'Question:\n(title)',
                        style: FFTheme.of(context).bodyText1,
                      )),
                    ),
                    Expanded(
                      child: TextField(
                        controller: titleController,
                        onChanged: (value) => widget.pdController
                            .setSurveyStepParam(
                                widget.taskID,
                                widget.singleChoiceQ.stepID['id']!,
                                'title',
                                value),
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText:
                              '[Do you prefer to vacation at the beach or the mountains?…]',
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
                    Container(
                      width: 120,
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 8, 8, 0),
                        child: SelectionArea(
                            child: Text(
                          'Description [optional]:',
                          style: FFTheme.of(context).bodyText1,
                        )),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: textController,
                        onChanged: (value) => widget.pdController
                            .setSurveyStepParam(
                                widget.taskID,
                                widget.singleChoiceQ.stepID['id']!,
                                'text',
                                value),
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: '[Yes, you have to pick one. …]',
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
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 120,
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                        child: SelectionArea(
                            child: Text(
                          'First Choice:',
                          style: FFTheme.of(context).bodyText1,
                        )),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: firstChoiceController,
                        onChanged: (value) => widget.pdController
                            .setSurveyStepParam(
                                widget.taskID,
                                widget.singleChoiceQ.stepID['id']!,
                                'yesChoice',
                                value),
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: '[The beach…]',
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
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 120,
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                        child: SelectionArea(
                            child: Text(
                          'Second Choice:',
                          style: FFTheme.of(context).bodyText1,
                        )),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: secondChoiceController,
                        onChanged: (value) => widget.pdController
                            .setSurveyStepParam(
                                widget.taskID,
                                widget.singleChoiceQ.stepID['id']!,
                                'noChoice',
                                value),
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: '[The mountains…]',
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
                        keyboardType: TextInputType.number,
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
