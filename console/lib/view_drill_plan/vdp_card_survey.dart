import 'package:flutter/material.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../models/survey_step_plans/survey_step_plan.dart';
import '../models/task_details_plans/survey_details_plan.dart';
import 'vdp_card_wrapper.dart';

class VDPCardSurvey extends StatelessWidget {
  const VDPCardSurvey({
    required this.drillID,
    required this.surveyDetails,
    required this.isCreator,
    required this.surveyIndex,
    super.key,
  });

  final String drillID;
  final SurveyDetailsPlan surveyDetails;
  final bool isCreator;
  final int surveyIndex;

  @override
  Widget build(BuildContext context) {
    return VDPCardWrapper(
      drillID: drillID,
      isCreator: isCreator,
      title: 'Survey: ${surveyDetails.title ?? '[no task title yet]'}',
      pdView: 'survey-$surveyIndex',
      hintText: 'Plan the survey steps',
      children: List.generate(
        surveyDetails.surveySteps.length,
        (index) => VDPCSurveyRow(
          index: index,
          value:
              '${surveyDetails.surveySteps[index].type.fullName}:  ${surveyDetails.surveySteps[index].title ?? '[no step title/question yet]'}',
        ),
      ),
    );
  }
}

class VDPCSurveyRow extends StatelessWidget {
  const VDPCSurveyRow({
    required this.index,
    required this.value,
    super.key,
  });

  final int index;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (index % 2 == 1) ? FFTheme.of(context).primaryBackground : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            padding: const EdgeInsets.only(right: 4),
            child: Text(
              '${index + 1}.',
              textAlign: TextAlign.end,
              style: FFTheme.of(context).bodyText2,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: FFTheme.of(context).bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
