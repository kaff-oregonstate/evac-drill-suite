import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../../models/survey_step_plans/scale_q_plan.dart';
import '../../plan_drill/plan_drill_controller.dart';

class ScaleQField extends StatefulWidget {
  const ScaleQField(
    this.pdController,
    this.taskID,
    this.scaleQ, {
    super.key,
  });

  final PDController pdController;
  final String taskID;
  final ScaleQPlan scaleQ;

  @override
  State<ScaleQField> createState() => _ScaleQFieldState();
}

class _ScaleQFieldState extends State<ScaleQField> {
  TextEditingController? titleController;
  TextEditingController? textController;
  TextEditingController? minValueController;
  bool invalidMinValue = false;
  TextEditingController? maxValueController;
  bool invalidMaxValue = false;
  TextEditingController? defaultValueController;
  bool invalidDefaultValue = false;
  TextEditingController? stepValueController;
  bool invalidStepValue = false;
  TextEditingController? minDescriptionController;
  TextEditingController? maxDescriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.scaleQ.title);
    textController = TextEditingController(text: widget.scaleQ.text);
    minValueController = TextEditingController(
        text: (widget.scaleQ.minimumValue != null)
            ? widget.scaleQ.minimumValue.toString()
            : null);
    maxValueController = TextEditingController(
        text: (widget.scaleQ.maximumValue != null)
            ? widget.scaleQ.maximumValue.toString()
            : null);
    defaultValueController = TextEditingController(
        text: (widget.scaleQ.defaultValue != null)
            ? widget.scaleQ.defaultValue.toString()
            : null);
    stepValueController = TextEditingController(
        text: (widget.scaleQ.step != null)
            ? widget.scaleQ.step.toString()
            : null);
    minDescriptionController =
        TextEditingController(text: widget.scaleQ.minimumValueDescription);
    maxDescriptionController =
        TextEditingController(text: widget.scaleQ.maximumValueDescription);
    // WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    titleController?.dispose();
    textController?.dispose();
    minValueController?.dispose();
    maxValueController?.dispose();
    defaultValueController?.dispose();
    stepValueController?.dispose();
    minDescriptionController?.dispose();
    maxDescriptionController?.dispose();
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
                      'Scale Question',
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
                            widget.scaleQ.stepID['id']!,
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
                            .setSurveyStepParam(widget.taskID,
                                widget.scaleQ.stepID['id']!, 'title', value),
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText:
                              '[How confident are you in completing the practice evacuation?…]',
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
                      width: 112,
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
                            .setSurveyStepParam(widget.taskID,
                                widget.scaleQ.stepID['id']!, 'text', value),
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText:
                              '[1 is not confident at all, 5 is completely confident.…]',
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
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                      child: SelectionArea(
                          child: Text(
                        'Minimum Value:',
                        style: FFTheme.of(context).bodyText1,
                      )),
                    ),
                    Expanded(
                      child: TextField(
                        controller: minValueController,
                        onChanged: (value) {
                          final parsedVal = int.tryParse(value);
                          if (parsedVal != null) {
                            setState(() => invalidMinValue = false);
                            widget.pdController.setSurveyStepParam(
                              widget.taskID,
                              widget.scaleQ.stepID['id']!,
                              'minimumValue',
                              parsedVal,
                            );
                          } else {
                            setState(() => invalidMinValue = true);
                          }
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: '[`0`, `1`, etc.…]',
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
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                      child: SelectionArea(
                          child: Text(
                        'Maximum Value:',
                        style: FFTheme.of(context).bodyText1,
                      )),
                    ),
                    Expanded(
                      child: TextField(
                        controller: maxValueController,
                        onChanged: (value) {
                          final parsedVal = int.tryParse(value);
                          if (parsedVal != null) {
                            setState(() => invalidMaxValue = false);
                            widget.pdController.setSurveyStepParam(
                              widget.taskID,
                              widget.scaleQ.stepID['id']!,
                              'maximumValue',
                              parsedVal,
                            );
                          } else {
                            setState(() => invalidMaxValue = true);
                          }
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: '[`5`, `10`, etc.…]',
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
              if (invalidMinValue)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 4),
                  child: Text(
                    'invalid minimum value, must be an integer number',
                    style: FFTheme.of(context)
                        .bodyText2
                        .copyWith(color: Colors.red[800]),
                  ),
                ),
              if (invalidMaxValue)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 4),
                  child: Text(
                    'invalid maximum value, must be an integer number',
                    style: FFTheme.of(context)
                        .bodyText2
                        .copyWith(color: Colors.red[800]),
                  ),
                ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: const BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 112,
                        decoration: const BoxDecoration(),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                          child: SelectionArea(
                              child: Text(
                            'Default Value:',
                            style: FFTheme.of(context).bodyText1,
                          )),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          enabled: (int.tryParse(maxValueController!.text) !=
                                  null &&
                              int.tryParse(minValueController!.text) != null),
                          controller: defaultValueController,
                          onChanged: (value) {
                            final parsedVal = double.tryParse(value);
                            final maxVal = int.parse(maxValueController!.text);
                            final minVal = int.parse(minValueController!.text);
                            if (parsedVal != null &&
                                parsedVal < maxVal &&
                                parsedVal > minVal) {
                              setState(() => invalidDefaultValue = false);
                              widget.pdController.setSurveyStepParam(
                                widget.taskID,
                                widget.scaleQ.stepID['id']!,
                                'defaultValue',
                                parsedVal,
                              );
                            } else {
                              setState(() => invalidDefaultValue = true);
                            }
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: '[`3`, `5`, etc.…]',
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
              ),
              if (invalidDefaultValue)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 4),
                  child: Text(
                    'invalid default value, must be a number less than the maximum value and less than the minimum value',
                    style: FFTheme.of(context)
                        .bodyText2
                        .copyWith(color: Colors.red[800]),
                  ),
                ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: const BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 112,
                        decoration: const BoxDecoration(),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                          child: SelectionArea(
                              child: Text(
                            'Step Value:',
                            style: FFTheme.of(context).bodyText1,
                          )),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          enabled: (int.tryParse(maxValueController!.text) !=
                                  null &&
                              int.tryParse(minValueController!.text) != null),
                          controller: stepValueController,
                          onChanged: (value) {
                            final parsedVal = double.tryParse(value);
                            final diffMaxMin =
                                int.parse(maxValueController!.text) -
                                    int.parse(minValueController!.text);
                            if (parsedVal != null &&
                                parsedVal < diffMaxMin &&
                                parsedVal > 0) {
                              setState(() => invalidStepValue = false);
                              widget.pdController.setSurveyStepParam(
                                widget.taskID,
                                widget.scaleQ.stepID['id']!,
                                'step',
                                parsedVal,
                              );
                            } else {
                              setState(() => invalidStepValue = true);
                            }
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: '[`0.1`, `1`, etc.…]',
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
              ),
              if (invalidStepValue)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 4),
                  child: Text(
                    'invalid step value, must be a number less than the difference between the maximum value and minimum value and greater than zero',
                    style: FFTheme.of(context)
                        .bodyText2
                        .copyWith(color: Colors.red[800]),
                  ),
                ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 164,
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                        child: SelectionArea(
                            child: Text(
                          'Min. Value Description [optional]:',
                          style: FFTheme.of(context).bodyText1,
                        )),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: minDescriptionController,
                        onChanged: (value) => widget.pdController
                            .setSurveyStepParam(
                                widget.taskID,
                                widget.scaleQ.stepID['id']!,
                                'minimumValueDescription',
                                value),
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: '[Not confident…]',
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
                  children: [
                    Container(
                      width: 164,
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                        child: SelectionArea(
                            child: Text(
                          'Max. Value Description [optional]:',
                          style: FFTheme.of(context).bodyText1,
                        )),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: maxDescriptionController,
                        onChanged: (value) => widget.pdController
                            .setSurveyStepParam(
                                widget.taskID,
                                widget.scaleQ.stepID['id']!,
                                'maximumValueDescription',
                                value),
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: '[Completely confident…]',
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
            ],
          ),
        ),
      ),
    );
  }
}
