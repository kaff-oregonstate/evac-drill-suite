import 'package:flutter/material.dart';

import '../components/survey_step_fields/bool_q_field.dart';
import '../components/survey_step_fields/completion_step_field.dart';
import '../components/survey_step_fields/date_q_field.dart';
import '../components/survey_step_fields/introduction_step_field.dart';
import '../components/survey_step_fields/int_q_field.dart';
import '../components/survey_step_fields/scale_q_field.dart';
import '../components/survey_step_fields/single_choice_q_field.dart';
import '../components/survey_step_fields/text_q_field.dart';
import '../dialogs/insert_survey_step_dialog.dart';
import '../dialogs/reorder_survey_steps_dialog.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../models/task_details_plans/survey_details_plan.dart';
import '../models/survey_step_plans/survey_step_plan.dart';
import 'plan_drill_controller.dart';

class PDSurvey extends StatefulWidget {
  const PDSurvey(this.pdController, this.taskID, {super.key});

  final PDController pdController;
  final String taskID;

  @override
  State<PDSurvey> createState() => _PDSurveyState();
}

class _PDSurveyState extends State<PDSurvey> {
  int taskIndex = -1;
  final _stepsScrollControl = ScrollController();

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
    _stepsScrollControl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
        // PDSurvey Body
        Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        // PDSurvey Body title
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 32, 16, 4),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectionArea(
                  child: Text(
                'Survey',
                style: FFTheme.of(context).title1,
              )),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FFButtonWidget(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: ((context) => ReorderSurveyStepsDialog(
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
                        borderSide: const BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: ((context) => InsertSurveyStepDialog(
                              widget.pdController, widget.taskID)));
                    },
                    text: 'Add Question',
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
                      borderSide: const BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // PDSurvey Body subtitle
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
          child: Row(children: [
            SelectionArea(
              child: Tooltip(
                message: 'edit this title on the Procedure page',
                child: Text(
                  widget.pdController.drillPlan.tasks[taskIndex].title ??
                      '[no survey title yet]',
                  // 'Survey',
                  style: FFTheme.of(context).subtitle1.override(
                        fontFamily: 'Outfit',
                        color: FFTheme.of(context).primaryText,
                      ),
                ),
              ),
            ),
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
            controller: _stepsScrollControl,
            thumbVisibility: true,
            child: ListView(
              padding: EdgeInsets.zero,
              controller: _stepsScrollControl,
              children: List.generate(
                  (widget.pdController.drillPlan.tasks[taskIndex].details
                          as SurveyDetailsPlan)
                      .surveySteps
                      .length, (index) {
                final surveyStep = (widget.pdController.drillPlan
                        .tasks[taskIndex].details as SurveyDetailsPlan)
                    .surveySteps[index];
                switch (surveyStep.type) {
                  case SurveyStepType.introduction:
                    return IntroductionStepField(
                      widget.pdController,
                      widget.taskID,
                      surveyStep as IntroductionStepPlan,
                    );
                  case SurveyStepType.boolean:
                    return BoolQField(
                      widget.pdController,
                      widget.taskID,
                      surveyStep as BoolQPlan,
                    );
                  case SurveyStepType.integer:
                    return IntQField(
                      widget.pdController,
                      widget.taskID,
                      surveyStep as IntQPlan,
                    );
                  case SurveyStepType.scale:
                    return ScaleQField(
                      widget.pdController,
                      widget.taskID,
                      surveyStep as ScaleQPlan,
                    );
                  case SurveyStepType.singleChoice:
                    return SingleChoiceQField(
                      widget.pdController,
                      widget.taskID,
                      surveyStep as SingleChoiceQPlan,
                    );
                  case SurveyStepType.text:
                    return TextQField(
                      widget.pdController,
                      widget.taskID,
                      surveyStep as TextQPlan,
                    );
                  case SurveyStepType.date:
                    return DateQField(
                      widget.pdController,
                      widget.taskID,
                      surveyStep as DateQPlan,
                    );
                  case SurveyStepType.completion:
                    return CompletionStepField(
                      widget.pdController,
                      widget.taskID,
                      surveyStep as CompletionStepPlan,
                    );
                  default:
                    throw Exception(
                        'Internal: Bad SurveyStepType on PDSurvey List generation');
                }
              }),
            ),
          ),
        ),
      ],
    );
  }
}
