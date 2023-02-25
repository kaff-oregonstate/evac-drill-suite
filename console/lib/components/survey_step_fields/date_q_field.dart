import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../models/survey_step_plans/date_q_plan.dart';
import '../../plan_drill/plan_drill_controller.dart';

class DateQField extends StatefulWidget {
  const DateQField(
    this.pdController,
    this.taskID,
    this.dateQ, {
    super.key,
  });

  final PDController pdController;
  final String taskID;
  final DateQPlan dateQ;

  @override
  State<DateQField> createState() => _DateQFieldState();
}

class _DateQFieldState extends State<DateQField> {
  TextEditingController? titleController;
  TextEditingController? textController;
  DateTime? datePickedMin;
  bool invalidMinDate = false;
  DateTime? datePickedMax;
  bool invalidMaxDate = false;
  DateTime? datePickedDefault;
  bool resetMin = false;
  bool resetMax = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.dateQ.title);
    textController = TextEditingController(text: widget.dateQ.text);
    datePickedMin = widget.dateQ.minDate;
    datePickedMax = widget.dateQ.maxDate;
    datePickedDefault = widget.dateQ.defaultDate;
    // WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
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
          padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                      'Date Question',
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
                            widget.dateQ.stepID['id']!,
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
                                widget.dateQ.stepID['id']!, 'title', value),
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText:
                              '[When was the last time you visited this location?…]',
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
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                      child: Container(
                        width: 106,
                        decoration: const BoxDecoration(),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: SelectionArea(
                              child: Text(
                            'Description [optional]:',
                            style: FFTheme.of(context).bodyText1,
                          )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: textController,
                        onChanged: (value) => widget.pdController
                            .setSurveyStepParam(widget.taskID,
                                widget.dateQ.stepID['id']!, 'text', value),
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText:
                              '[If you have never visited before, please enter today\'s date.…]',
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
              DateQDatePickerField(
                datePicked: datePickedDefault,
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: datePickedDefault ?? getCurrentTimestamp,
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2050),
                  ).then((datePickedDefaultDate) {
                    if (datePickedDefaultDate != null) {
                      setState(
                        () => datePickedDefault = DateTime(
                          datePickedDefaultDate.year,
                          datePickedDefaultDate.month,
                          datePickedDefaultDate.day,
                        ),
                      );
                      widget.pdController.setSurveyStepParam(
                        widget.taskID,
                        widget.dateQ.stepID['id']!,
                        'defaultDate',
                        datePickedDefault,
                      );
                      // error check for passed bound of min or max:
                      if (datePickedMin != null &&
                          datePickedMin!.difference(datePickedDefault!).inDays >
                              0) {
                        // need to reset min
                        setState(() => datePickedMin = null);
                        setState(() => resetMin = true);
                        widget.pdController.setSurveyStepParam(
                          widget.taskID,
                          widget.dateQ.stepID['id']!,
                          'minDate',
                          null,
                        );
                      }
                      if (datePickedMax != null &&
                          datePickedMax!.difference(datePickedDefault!).inDays <
                              0) {
                        // need to reset max
                        setState(() => datePickedMax = null);
                        setState(() => resetMax = true);
                        widget.pdController.setSurveyStepParam(
                          widget.taskID,
                          widget.dateQ.stepID['id']!,
                          'maxDate',
                          null,
                        );
                      }
                    }
                  });
                },
                labelText: 'Default value:',
                datePickerText: valueOrDefault<String>(
                  dateTimeFormat(
                    'yMMMMEEEEd',
                    datePickedDefault,
                    locale: LocaleType.en.name,
                  ),
                  'Default',
                ),
              ),
              if (resetMin)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 4),
                  child: Text(
                    'new default value is before previous minimum value: minimum value reset to empty',
                    style: FFTheme.of(context)
                        .bodyText2
                        .copyWith(color: Colors.amber[800]),
                  ),
                ),
              if (resetMax)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 4),
                  child: Text(
                    'new default value is after previous maximum value: maximum value reset to empty',
                    style: FFTheme.of(context)
                        .bodyText2
                        .copyWith(color: Colors.amber[800]),
                  ),
                ),
              DateQDatePickerField(
                datePicked: datePickedMin,
                onTap: (datePickedDefault != null)
                    ? () {
                        showDatePicker(
                          context: context,
                          initialDate: datePickedMin ?? getCurrentTimestamp,
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2050),
                        ).then((datePickedMinDate) {
                          if (datePickedMinDate == null) return;
                          if (datePickedMinDate
                                  .difference(datePickedDefault!)
                                  .inDays <=
                              0) {
                            setState(() => invalidMinDate = false);
                            setState(() => resetMin = false);
                            setState(
                              () => datePickedMin = DateTime(
                                datePickedMinDate.year,
                                datePickedMinDate.month,
                                datePickedMinDate.day,
                              ),
                            );
                            widget.pdController.setSurveyStepParam(
                              widget.taskID,
                              widget.dateQ.stepID['id']!,
                              'minDate',
                              datePickedMin,
                            );
                          } else {
                            setState(() => invalidMinDate = true);
                          }
                        });
                      }
                    : null,
                labelText: 'Minimum value\n[optional]:',
                datePickerText: (datePickedDefault != null)
                    ? valueOrDefault<String>(
                        dateTimeFormat(
                          'yMMMMEEEEd',
                          datePickedMin,
                          locale: LocaleType.en.name,
                        ),
                        'Minimum',
                      )
                    : 'Pick default first…',
              ),
              if (invalidMinDate)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 4),
                  child: Text(
                    'invalid min date selected: must be on or before default date',
                    style: FFTheme.of(context)
                        .bodyText2
                        .copyWith(color: Colors.red[800]),
                  ),
                ),
              DateQDatePickerField(
                datePicked: datePickedMax,
                onTap: (datePickedDefault != null)
                    ? () {
                        showDatePicker(
                          context: context,
                          initialDate: datePickedMax ?? getCurrentTimestamp,
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2050),
                        ).then((datePickedMaxDate) {
                          if (datePickedMaxDate == null) return;
                          if (datePickedMaxDate
                                  .difference(datePickedDefault!)
                                  .inDays >=
                              0) {
                            setState(() => invalidMaxDate = false);
                            setState(() => resetMax = false);
                            setState(
                              () => datePickedMax = DateTime(
                                datePickedMaxDate.year,
                                datePickedMaxDate.month,
                                datePickedMaxDate.day,
                              ),
                            );
                            widget.pdController.setSurveyStepParam(
                              widget.taskID,
                              widget.dateQ.stepID['id']!,
                              'maxDate',
                              datePickedMax,
                            );
                          } else {
                            setState(() => invalidMaxDate = true);
                          }
                        });
                      }
                    : null,
                labelText: 'Maximum value\n[optional]:',
                datePickerText: (datePickedDefault != null)
                    ? valueOrDefault<String>(
                        dateTimeFormat(
                          'yMMMMEEEEd',
                          datePickedMax,
                          locale: LocaleType.en.name,
                        ),
                        'Maximum',
                      )
                    : 'Pick default first…',
              ),
              if (invalidMaxDate)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 4),
                  child: Text(
                    'invalid max date selected: must be on or after default date',
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateQDatePickerField extends StatelessWidget {
  const DateQDatePickerField({
    required this.datePicked,
    required this.onTap,
    required this.labelText,
    required this.datePickerText,
    super.key,
  });

  final DateTime? datePicked;
  final Function()? onTap;
  final String labelText;
  final String datePickerText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
      child: Row(
        children: [
          SelectionArea(
            child: Container(
                width: 120,
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  labelText,
                  textAlign: TextAlign.start,
                  style: FFTheme.of(context).bodyText1,
                )),
          ),
          Material(
            borderRadius: BorderRadius.circular(8),
            color: FFTheme.of(context).secondaryBackground,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: onTap,
              child: Container(
                width: 310,
                height: 50,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 5, 12, 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        datePickerText,
                        style: FFTheme.of(context).bodyText2,
                      ),
                      Icon(
                        Icons.date_range_outlined,
                        color: FFTheme.of(context).secondaryText,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
