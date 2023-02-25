// For `validate()` functions:
import 'package:evac_drill_console/models/missing_plan_param.dart';

// Make this the only needed import to handle all SurveyStepPlan implementations
import 'package:evac_drill_console/models/survey_step_plans/bool_q_plan.dart';
import 'package:evac_drill_console/models/survey_step_plans/completion_step_plan.dart';
import 'package:evac_drill_console/models/survey_step_plans/date_q_plan.dart';
import 'package:evac_drill_console/models/survey_step_plans/int_q_plan.dart';
import 'package:evac_drill_console/models/survey_step_plans/introduction_step_plan.dart';
import 'package:evac_drill_console/models/survey_step_plans/scale_q_plan.dart';
import 'package:evac_drill_console/models/survey_step_plans/single_choice_q_plan.dart';
import 'package:evac_drill_console/models/survey_step_plans/text_q_plan.dart';
export 'package:evac_drill_console/models/survey_step_plans/bool_q_plan.dart';
export 'package:evac_drill_console/models/survey_step_plans/completion_step_plan.dart';
export 'package:evac_drill_console/models/survey_step_plans/date_q_plan.dart';
export 'package:evac_drill_console/models/survey_step_plans/int_q_plan.dart';
export 'package:evac_drill_console/models/survey_step_plans/introduction_step_plan.dart';
export 'package:evac_drill_console/models/survey_step_plans/scale_q_plan.dart';
export 'package:evac_drill_console/models/survey_step_plans/single_choice_q_plan.dart';
export 'package:evac_drill_console/models/survey_step_plans/text_q_plan.dart';

export 'package:uuid/uuid.dart' show Uuid;

/// Enumerates the types of SurveyKit Steps

enum SurveyStepType {
  introduction,
  boolean,
  integer,
  scale,
  singleChoice,
  text,
  date,
  completion,
}

extension SurveyStepName on SurveyStepType {
  String get fullName {
    switch (this) {
      case SurveyStepType.introduction:
        return 'Introduction Step';
      case SurveyStepType.boolean:
        return 'Boolean Question';
      case SurveyStepType.integer:
        return 'Integer Question';
      case SurveyStepType.scale:
        return 'Scale Question';
      case SurveyStepType.singleChoice:
        return 'Single Choice Question';
      case SurveyStepType.text:
        return 'Text Question';
      case SurveyStepType.date:
        return 'Date Question';
      case SurveyStepType.completion:
        return 'Completion Step';
      default:
        throw Exception('Internal: bad SurveyStepType on .fullName');
    }
  }
}

/// Describes a SurveyKit Step, wrapped for our own purposes+extensibility

abstract class SurveyStepPlan {
  Map<String, dynamic> toJson();
  List<MissingPlanParam> paramsMissing();

  SurveyStepType get type;
  Map<String, String> get stepID;
  String? get title;
  set title(String? value);
  String get text;
  set text(String value);

  factory SurveyStepPlan.fromJson(Map<String, dynamic> stepJson) {
    switch (stepJson['type'] as String) {
      case 'intro':
        return IntroductionStepPlan.fromJson(stepJson);
      case 'completion':
        return CompletionStepPlan.fromJson(stepJson);
      case 'question':
        switch (stepJson['answerFormat']['type'] as String) {
          case 'bool':
            return BoolQPlan.fromJson(stepJson);
          case 'integer':
            return IntQPlan.fromJson(stepJson);
          case 'text':
            return TextQPlan.fromJson(stepJson);
          case 'date':
            return DateQPlan.fromJson(stepJson);
          case 'single':
            return SingleChoiceQPlan.fromJson(stepJson);
          case 'scale':
            return ScaleQPlan.fromJson(stepJson);
          default:
            // Error: Unrecognized SurveyStepType
            throw const FormatException('Unrecognized SurveyStepType');
        }
      default:
        // Error: Unrecognized SurveyStepType
        throw const FormatException('Unrecognized SurveyStepType');
    }
  }
}
