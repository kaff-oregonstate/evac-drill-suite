// ignore_for_file: avoid_print

import 'package:evac_drill_console/models/drill_task_plan.dart';
import 'package:evac_drill_console/models/evac_action_plans/evac_action_plan.dart';
import 'package:evac_drill_console/models/task_details_plans/task_details_plan.dart';
import 'package:flutter/material.dart';

import '../models/drill_plan.dart';
import '../models/survey_step_plans/survey_step_plan.dart';

class PDController extends ChangeNotifier {
  int currentPage = 0;

  DrillPlan drillPlan;

  bool unsavedChanges = false;

  void markAndNotify() {
    unsavedChanges = true;
    notifyListeners();
  }

  Future<void> syncChanges() async {
    if (unsavedChanges) await drillPlan.updateDoc();
    unsavedChanges = false;
    notifyListeners();
  }

  void setParameter(String param, dynamic value) {
    // print('setting param: $param');
    switch (param) {
      case 'title':
        if (value.runtimeType == String) drillPlan.title = value;
        break;
      case 'type':
        if (value.runtimeType == DrillType) drillPlan.type = value;
        break;
      case 'description':
        if (value.runtimeType == String) drillPlan.description = value;
        break;
      case 'blurb':
        if (value.runtimeType == String) drillPlan.blurb = value;
        break;
      case 'meetingLocationPlainText':
        if (value.runtimeType == String) {
          drillPlan.meetingLocationPlainText = value;
        }
        break;
      case 'meetingDateTime':
        if (value.runtimeType == DateTime) drillPlan.meetingDateTime = value;
        break;
      case 'publicKey':
        if (value.runtimeType == String) drillPlan.publicKey = value;
        break;
      default:
    }
    markAndNotify();
  }

  // useful for reordering tasks
  void setTasks(List<DrillTaskPlan> tasks) {
    print('setting tasks after reorder');
    drillPlan.tasks = tasks;
    initViewsAndSteps();
    markAndNotify();
  }

  void addTask(DrillTaskType type, [int? index]) {
    print('adding task type: ${type.name}');
    TaskDetailsPlan? details;
    switch (type) {
      case DrillTaskType.practiceEvac:
        details = PracticeEvacDetailsPlan();
        break;
      case DrillTaskType.reqLocPerms:
        details = ReqLocPermsDetailsPlan();
        break;
      case DrillTaskType.survey:
        details = SurveyDetailsPlan();
        break;
      case DrillTaskType.upload:
        details = UploadDetailsPlan();
        break;
      case DrillTaskType.travel:
        details = TravelDetailsPlan();
        break;
      default:
        throw const FormatException('Internal: bad DrillTaskType');
    }
    if (index != null) {
      print('@ index: $index');
      drillPlan.tasks.insert(
        index,
        DrillTaskPlan(taskID: details.taskID, taskType: type, details: details),
      );
    } else {
      drillPlan.tasks.add(
        DrillTaskPlan(taskID: details.taskID, taskType: type, details: details),
      );
    }
    initViewsAndSteps();
    markAndNotify();
  }

  void removeTask(String taskID) {
    print('removing DrillTask with id $taskID');
    drillPlan.tasks.removeWhere((element) => element.taskID == taskID);
    initViewsAndSteps();
    markAndNotify();
  }

  void setTaskParameter(
      String taskID, DrillTaskType type, String param, dynamic value) {
    final taskIndex =
        drillPlan.tasks.indexWhere((element) => element.taskID == taskID);
    switch (param) {
      case 'title':
        if (value.runtimeType == String) {
          drillPlan.tasks[taskIndex].title = value;
          if (type == DrillTaskType.practiceEvac) {
            final details =
                drillPlan.tasks[taskIndex].details as PracticeEvacDetailsPlan;
            details.title = value;
          }
          if (type == DrillTaskType.survey) {
            final details =
                drillPlan.tasks[taskIndex].details as SurveyDetailsPlan;
            details.title = value;
          }
        }
        break;
      default:
    }
    markAndNotify();
  }

  // useful for reordering steps and actions
  void setTask(DrillTaskPlan task) {
    print('setting DrillTask with id ${task.taskID}');
    final replaceIndex =
        drillPlan.tasks.indexWhere((element) => element.taskID == task.taskID);
    if (replaceIndex == -1) {
      throw Exception('Internal: bad DrillTask.taskID on setTask');
    }
    if (drillPlan.tasks[replaceIndex].taskType == task.taskType) {
      throw Exception(
          'Internal: attempting to overwrite task with task of different type');
    }
    drillPlan.tasks[replaceIndex] = task;
    markAndNotify();
  }

  void addStep(String taskID, SurveyStepType type, [int? index]) {
    print(
        'adding SurveyStepPlan with type: ${type.name} to Survey with id: $taskID');
    SurveyStepPlan? stepPlan;
    switch (type) {
      case SurveyStepType.boolean:
        stepPlan = BoolQPlan();
        break;
      case SurveyStepType.completion:
        stepPlan = CompletionStepPlan();
        break;
      case SurveyStepType.date:
        stepPlan = DateQPlan();
        break;
      case SurveyStepType.integer:
        stepPlan = IntQPlan();
        break;
      case SurveyStepType.introduction:
        stepPlan = IntroductionStepPlan();
        break;
      case SurveyStepType.scale:
        stepPlan = ScaleQPlan();
        break;
      case SurveyStepType.singleChoice:
        stepPlan = SingleChoiceQPlan();
        break;
      case SurveyStepType.text:
        stepPlan = TextQPlan();
        break;
      default:
        throw const FormatException('Internal: bad SurveyStepType');
    }
    if (index != null) {
      print('@ index: $index');
      (drillPlan.tasks.firstWhere((element) => element.taskID == taskID).details
              as SurveyDetailsPlan)
          .surveySteps
          .insert(index, stepPlan);
    } else {
      (drillPlan.tasks.firstWhere((element) => element.taskID == taskID).details
              as SurveyDetailsPlan)
          .surveySteps
          .add(stepPlan);
    }
    markAndNotify();
  }

  void removeStep(String taskID, String stepID) {
    print('removing SurveyStep with id $stepID from survey with $taskID');
    (drillPlan.tasks.firstWhere((element) => element.taskID == taskID).details
            as SurveyDetailsPlan)
        .surveySteps
        .removeWhere((element) => element.stepID['id'] == stepID);
    markAndNotify();
  }

  void setTrackingLocation(String taskID, bool value) {
    final taskIndex =
        drillPlan.tasks.indexWhere((element) => element.taskID == taskID);
    final details =
        drillPlan.tasks[taskIndex].details as PracticeEvacDetailsPlan;
    details.trackingLocation = value;
    markAndNotify();
  }

  void setSurveyStepParam(
    String taskID,
    String stepID,
    String param,
    dynamic value,
  ) {
    // we want all the identifiers we can get here…
    // print('setting survey step param $param on step with id $stepID');
    final taskIndex =
        drillPlan.tasks.indexWhere((element) => element.taskID == taskID);
    final details = drillPlan.tasks[taskIndex].details as SurveyDetailsPlan;
    final stepIndex = details.surveySteps
        .indexWhere((element) => element.stepID['id'] == stepID);
    final stepType = details.surveySteps[stepIndex].type;

    switch (param) {
      // all stepTypes have title and text, so check that first
      case 'title':
        if (value.runtimeType == String) {
          (drillPlan.tasks[taskIndex].details as SurveyDetailsPlan)
              .surveySteps[stepIndex]
              .title = value;
        }
        break;
      case 'text':
        if (value.runtimeType == String) {
          (drillPlan.tasks[taskIndex].details as SurveyDetailsPlan)
              .surveySteps[stepIndex]
              .text = value;
        }
        break;
      default:
        // otherwise, check the stepType and then the param type
        switch (stepType) {
          case SurveyStepType.boolean:
            if (param == 'positiveAnswer') {
              if (value.runtimeType == String) {
                ((drillPlan.tasks[taskIndex].details as SurveyDetailsPlan)
                        .surveySteps[stepIndex] as BoolQPlan)
                    .positiveAnswer = value;
              }
            } else if (param == 'negativeAnswer') {
              if (value.runtimeType == String) {
                ((drillPlan.tasks[taskIndex].details as SurveyDetailsPlan)
                        .surveySteps[stepIndex] as BoolQPlan)
                    .negativeAnswer = value;
              }
            }
            break;
          case SurveyStepType.integer:
            if (param == 'hint' && value.runtimeType == String) {
              ((drillPlan.tasks[taskIndex].details as SurveyDetailsPlan)
                      .surveySteps[stepIndex] as IntQPlan)
                  .hint = value;
            }
            break;
          case SurveyStepType.scale:
            switch (param) {
              case 'minimumValue':
                if (value.runtimeType == int) {
                  ((drillPlan.tasks[taskIndex].details as SurveyDetailsPlan)
                          .surveySteps[stepIndex] as ScaleQPlan)
                      .minimumValue = value;
                }
                break;
              case 'maximumValue':
                if (value.runtimeType == int) {
                  ((drillPlan.tasks[taskIndex].details as SurveyDetailsPlan)
                          .surveySteps[stepIndex] as ScaleQPlan)
                      .maximumValue = value;
                }
                break;
              case 'defaultValue':
                if (value.runtimeType == double || value.runtimeType == int) {
                  ((drillPlan.tasks[taskIndex].details as SurveyDetailsPlan)
                          .surveySteps[stepIndex] as ScaleQPlan)
                      .defaultValue = value;
                } else {
                  print('bad runtimeType: ${value.runtimeType}');
                }
                break;
              case 'step':
                if (value.runtimeType == double || value.runtimeType == int) {
                  ((drillPlan.tasks[taskIndex].details as SurveyDetailsPlan)
                          .surveySteps[stepIndex] as ScaleQPlan)
                      .step = value;
                }
                break;
              case 'minimumValueDescription':
                if (value.runtimeType == String) {
                  ((drillPlan.tasks[taskIndex].details as SurveyDetailsPlan)
                          .surveySteps[stepIndex] as ScaleQPlan)
                      .minimumValueDescription = value;
                }
                break;
              case 'maximumValueDescription':
                if (value.runtimeType == String) {
                  ((drillPlan.tasks[taskIndex].details as SurveyDetailsPlan)
                          .surveySteps[stepIndex] as ScaleQPlan)
                      .maximumValueDescription = value;
                }
                break;
              default:
            }
            break;
          case SurveyStepType.singleChoice:
            if (param == 'yesChoice') {
              if (value.runtimeType == String) {
                ((drillPlan.tasks[taskIndex].details as SurveyDetailsPlan)
                        .surveySteps[stepIndex] as SingleChoiceQPlan)
                    .yesChoice = value;
              }
            } else if (param == 'noChoice') {
              if (value.runtimeType == String) {
                ((drillPlan.tasks[taskIndex].details as SurveyDetailsPlan)
                        .surveySteps[stepIndex] as SingleChoiceQPlan)
                    .noChoice = value;
              }
            }
            break;
          case SurveyStepType.text:
            if (param == 'maxLines' && value.runtimeType == int) {
              ((drillPlan.tasks[taskIndex].details as SurveyDetailsPlan)
                      .surveySteps[stepIndex] as TextQPlan)
                  .maxLines = value;
            }
            break;
          case SurveyStepType.date:
            switch (param) {
              case 'minDate':
                if (value == null || value.runtimeType == DateTime) {
                  ((drillPlan.tasks[taskIndex].details as SurveyDetailsPlan)
                          .surveySteps[stepIndex] as DateQPlan)
                      .minDate = value;
                }
                break;
              case 'maxDate':
                if (value == null || value.runtimeType == DateTime) {
                  ((drillPlan.tasks[taskIndex].details as SurveyDetailsPlan)
                          .surveySteps[stepIndex] as DateQPlan)
                      .maxDate = value;
                }
                break;
              case 'defaultDate':
                if (value.runtimeType == DateTime) {
                  ((drillPlan.tasks[taskIndex].details as SurveyDetailsPlan)
                          .surveySteps[stepIndex] as DateQPlan)
                      .defaultDate = value;
                }
                break;
              default:
            }
            break;
          default:
        }
    }

    markAndNotify();
  }

  void setSurveySteps(String taskID, List<SurveyStepPlan> steps) {
    print('setting survey steps for task with id $taskID');
    (drillPlan.tasks.firstWhere((element) => element.taskID == taskID).details
            as SurveyDetailsPlan)
        .surveySteps = steps;
    markAndNotify();
  }

  void addAction(String taskID, EvacActionType type, [int? index]) {
    print(
        'adding Evac Action type: ${type.name} to Practice Evac with id $taskID');
    EvacActionPlan? evacActionPlan;
    switch (type) {
      case EvacActionType.instruction:
        evacActionPlan = InstructionActionPlan();
        break;
      case EvacActionType.waitForStart:
        evacActionPlan = WaitForStartActionPlan();
        break;
      default:
        throw const FormatException('Internal: bad EvacActionType');
    }
    final practiceEvacDetailsPlan = drillPlan.tasks
        .firstWhere((element) => element.taskID == taskID)
        .details as PracticeEvacDetailsPlan;
    if (index != null) {
      print('@ index: $index');
      practiceEvacDetailsPlan.actions.insert(index, evacActionPlan);
    } else {
      practiceEvacDetailsPlan.actions.add(evacActionPlan);
    }
    markAndNotify();
  }

  void removeAction(String taskID, String actionID) {
    print(
        'removing EvacAction with id $actionID from practice evac with $taskID');
    final practiceEvacDetailsPlan = drillPlan.tasks
        .firstWhere((element) => element.taskID == taskID)
        .details as PracticeEvacDetailsPlan;
    practiceEvacDetailsPlan.actions
        .removeWhere((element) => element.actionID == actionID);
    markAndNotify();
  }

  void setActionParam(
    String taskID,
    String actionID,
    String param,
    dynamic value,
  ) {
    final taskIndex =
        drillPlan.tasks.indexWhere((element) => element.taskID == taskID);
    final details =
        drillPlan.tasks[taskIndex].details as PracticeEvacDetailsPlan;
    final actionIndex =
        details.actions.indexWhere((element) => element.actionID == actionID);
    if (param == 'text') {
      // dealing with InstructionActionPlan.text
      if (value == null || value.runtimeType == String) {
        ((drillPlan.tasks[taskIndex].details as PracticeEvacDetailsPlan)
                .actions[actionIndex] as InstructionActionPlan)
            .text = value;
      }
    }
    if (param == 'waitType') {
      // dealing with WaitForStartActionPlan.waitType
      if (value.runtimeType == WaitType) {
        ((drillPlan.tasks[taskIndex].details as PracticeEvacDetailsPlan)
                .actions[actionIndex] as WaitForStartActionPlan)
            .waitType = value;
      }
    }
    markAndNotify();
  }

  void setActions(String taskID, List<EvacActionPlan> actions) {
    print('setting evac actions for task with id $taskID');
    (drillPlan.tasks.firstWhere((element) => element.taskID == taskID).details
            as PracticeEvacDetailsPlan)
        .actions = actions;
    markAndNotify();
  }

  PageController pageController = PageController(initialPage: 0);

  List<Map<String, dynamic>> views = [];

  List<String> steps = [];

  void navToPage(index) {
    currentPage = index;
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    notifyListeners();
  }

  void navToNext() {
    final nextPageIndex = currentPage + 1;
    if (nextPageIndex < steps.length) {
      currentPage = nextPageIndex;
      pageController.animateToPage(nextPageIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      notifyListeners();
    } else {
      // HACK: could prompt go to Final Review here…
    }
  }

  void navToPrev() {
    final prevPageIndex = currentPage - 1;
    if (prevPageIndex >= 0) {
      currentPage = prevPageIndex;
      pageController.animateToPage(prevPageIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      notifyListeners();
    }
  }

  void initViewsAndSteps([String? initialView]) {
    views = [
      {'name': 'info'},
      {'name': 'procedure'}
    ];
    steps = [
      'Info',
      'Procedure',
    ];
    int surveyIndex = 1;
    int evacIndex = 1;
    // get the tasks of the drill plan
    for (final task in drillPlan.tasks) {
      if (task.taskType == DrillTaskType.survey) {
        views.add({'name': 'survey-$surveyIndex', 'taskID': task.taskID});
        steps.add('Survey Questions ($surveyIndex)');
        surveyIndex++;
      }
      if (task.taskType == DrillTaskType.practiceEvac) {
        views.add({'name': 'evacuation-$evacIndex', 'taskID': task.taskID});
        steps.add('Evacuation Actions ($evacIndex)');
        evacIndex++;
      }
    }
    print(views);
    if (initialView != null) {
      final viewIndex =
          views.indexWhere((element) => element['name'] == initialView);
      if (viewIndex != -1) currentPage = viewIndex;
    }
  }

  factory PDController.init(DrillPlan drillPlan, String? initialView) {
    print('init plan drill controller');
    PDController pdController = PDController._(drillPlan);
    pdController.initViewsAndSteps(initialView);
    return pdController;
  }

  PDController._(this.drillPlan);
}
