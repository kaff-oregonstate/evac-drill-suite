/// A data model to hold the "field" path for parameters required for DrillPlan
/// publication

class MissingPlanParam {
  // TODO: Implement MissingPlanParam
  final String field;
  MissingPlanParam(this.field);

  @override
  String toString() => '{MissingPlanParam: $field}';
}
