import 'package:flutter/material.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../models/drill_plan.dart';
import '../models/drill_task_plan.dart';
import '../models/task_details_plans/task_details_plan.dart';
import 'vdp_card_info.dart';
import 'vdp_card_practice_evac.dart';
import 'vdp_card_procedure.dart';
import 'vdp_card_survey.dart';

class VDPView extends StatefulWidget {
  VDPView(this.drillPlan, this.isCreator, {super.key});

  final DrillPlan drillPlan;
  final bool isCreator;

  @override
  State<VDPView> createState() => _VDPViewState();
}

class _VDPViewState extends State<VDPView> {
  final _reviewCardsController1 = ScrollController();
  bool atTop1 = true;
  bool atBot1 = true;
  final _reviewCardsController2 = ScrollController();
  bool atTop2 = true;
  bool atBot2 = true;

  @override
  void initState() {
    super.initState();
    _reviewCardsController1.addListener(scroll1Listener);
    _reviewCardsController2.addListener(scroll2Listener);

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          if (_reviewCardsController1.hasClients) {
            atBot1 = _reviewCardsController1.position.extentAfter == 0;
          }
          if (_reviewCardsController2.hasClients) {
            atBot2 = _reviewCardsController2.position.extentAfter == 0;
          }
        }));
  }

  void scroll1Listener() {
    setState(() {
      atTop1 = (_reviewCardsController1.position.atEdge &&
          _reviewCardsController1.position.pixels == 0);
      atBot1 = _reviewCardsController1.position.extentAfter == 0;
    });
  }

  void scroll2Listener() {
    setState(() {
      atTop2 = (_reviewCardsController2.position.atEdge &&
          _reviewCardsController2.position.pixels == 0);
      atBot2 = _reviewCardsController2.position.extentAfter == 0;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _reviewCardsController1.removeListener(scroll1Listener);
    _reviewCardsController1.dispose();
    _reviewCardsController2.removeListener(scroll2Listener);
    _reviewCardsController2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<DrillTaskPlan> surveysAndEvacs = [];
    List<int> surveyAndEvacIndexes = [];
    int surveyIndex = 1;
    int evacIndex = 1;
    for (final task in widget.drillPlan.tasks) {
      if (task.taskType == DrillTaskType.survey) {
        surveysAndEvacs.add(task);
        surveyAndEvacIndexes.add(surveyIndex);
        surveyIndex += 1;
      }
      if (task.taskType == DrillTaskType.practiceEvac) {
        surveysAndEvacs.add(task);
        surveyAndEvacIndexes.add(evacIndex);
        evacIndex += 1;
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              Divider(
                height: 2,
                thickness: 2,
                indent: 8,
                endIndent: 8,
                color: (atTop1)
                    ? Colors.transparent
                    : FFTheme.of(context).tertiaryColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Scrollbar(
                    controller: _reviewCardsController1,
                    thumbVisibility: true,
                    child: ListView(
                      controller: _reviewCardsController1,
                      children: [
                        VDPCardInfo(widget.drillPlan, widget.isCreator),
                        VDPCardProcedure(widget.drillPlan, widget.isCreator),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                height: 2,
                thickness: 2,
                indent: 8,
                endIndent: 8,
                color: (atBot1)
                    ? Colors.transparent
                    : FFTheme.of(context).tertiaryColor,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Divider(
                height: 2,
                thickness: 2,
                indent: 8,
                endIndent: 8,
                color: (atTop2)
                    ? Colors.transparent
                    : FFTheme.of(context).tertiaryColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Scrollbar(
                    controller: _reviewCardsController2,
                    thumbVisibility: true,
                    child: ListView.builder(
                      controller: _reviewCardsController2,
                      itemCount: surveysAndEvacs.length,
                      itemBuilder: (context, index) {
                        final task = surveysAndEvacs[index];
                        if (task.taskType == DrillTaskType.survey) {
                          return VDPCardSurvey(
                            drillID: widget.drillPlan.drillID,
                            surveyDetails: task.details as SurveyDetailsPlan,
                            isCreator: widget.isCreator,
                            surveyIndex: surveyAndEvacIndexes[index],
                          );
                        } else {
                          return VDPCardPracticeEvac(
                            drillID: widget.drillPlan.drillID,
                            practiceEvacDetails:
                                task.details as PracticeEvacDetailsPlan,
                            isCreator: widget.isCreator,
                            evacIndex: surveyAndEvacIndexes[index],
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              Divider(
                height: 2,
                thickness: 2,
                indent: 8,
                endIndent: 8,
                color: (atBot2)
                    ? Colors.transparent
                    : FFTheme.of(context).tertiaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
