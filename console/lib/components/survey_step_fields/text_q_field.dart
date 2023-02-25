import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../../models/survey_step_plans/text_q_plan.dart';
import '../../plan_drill/plan_drill_controller.dart';

class TextQField extends StatefulWidget {
  const TextQField(
    this.pdController,
    this.taskID,
    this.textQ, {
    super.key,
  });

  final PDController pdController;
  final String taskID;
  final TextQPlan textQ;

  @override
  State<TextQField> createState() => _TextQFieldState();
}

class _TextQFieldState extends State<TextQField> {
  TextEditingController? titleController;
  TextEditingController? textController;
  TextEditingController? maxLinesController;
  bool invalidMaxLinesValue = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.textQ.title);
    textController = TextEditingController(text: widget.textQ.text);
    maxLinesController = TextEditingController(
        text: (widget.textQ.maxLines != null)
            ? widget.textQ.maxLines.toString()
            : null);
    // WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    titleController?.dispose();
    textController?.dispose();
    maxLinesController?.dispose();
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
                      'Text Question',
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
                            widget.textQ.stepID['id']!,
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
                                widget.textQ.stepID['id']!, 'title', value),
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText:
                              '[How did you hear about this evacuation drill?…]',
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
                            .setSurveyStepParam(widget.taskID,
                                widget.textQ.stepID['id']!, 'text', value),
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText:
                              '[Please do not include any personal identifiers…]',
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
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: const BoxDecoration(),
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
                            'Max Lines:',
                            style: FFTheme.of(context).bodyText1,
                          )),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: maxLinesController,
                          onChanged: (value) {
                            final parsedVal = int.tryParse(value);
                            if (parsedVal != null && parsedVal > 0) {
                              setState(() => invalidMaxLinesValue = false);
                              widget.pdController.setSurveyStepParam(
                                widget.taskID,
                                widget.textQ.stepID['id']!,
                                'maxLines',
                                parsedVal,
                              );
                            } else {
                              setState(() => invalidMaxLinesValue = true);
                            }
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText:
                                '[Number of lines to provide for response,`1`, `4`, etc.…]',
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
              if (invalidMaxLinesValue)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 4),
                  child: Text(
                    'invalid max lines value, must be an integer number greater than zero',
                    style: FFTheme.of(context)
                        .bodyText2
                        .copyWith(color: Colors.red[800]),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
