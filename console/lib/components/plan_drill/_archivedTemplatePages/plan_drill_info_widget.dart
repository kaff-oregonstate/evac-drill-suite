import 'package:evac_drill_console/components/plan_drill/pd_app_bar.dart';
import 'package:evac_drill_console/components/plan_drill/pd_bottom_nav_buttons.dart';
import 'package:evac_drill_console/components/plan_drill/pd_progress_bar.dart';
import 'package:evac_drill_console/components/plan_drill/pd_steps_list.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_drop_down.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_util.dart';
// import 'package:evac_drill_console/components/dev_util/display_size.dart';
import 'package:evac_drill_console/screen_too_small/show_notice_on_small.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class PlanDrillInfoWidget extends StatefulWidget {
  const PlanDrillInfoWidget({Key? key}) : super(key: key);

  @override
  State<PlanDrillInfoWidget> createState() => _PlanDrillInfoWidgetState();
}

class _PlanDrillInfoWidgetState extends State<PlanDrillInfoWidget> {
  DateTime? datePicked;
  String? drillTypeValue;
  TextEditingController? drillLocationController;
  TextEditingController? drillTitleController;
  TextEditingController? blurbController;
  TextEditingController? descriptionController;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<int>? planningSteps;
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    blurbController = TextEditingController();
    drillLocationController = TextEditingController();
    drillTitleController = TextEditingController();
    descriptionController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    // double ratioComplete = currentStep / ((planningSteps?.length ?? 2) + 1.5);
    // print(ratioComplete);
  }

  @override
  void dispose() {
    blurbController?.dispose();
    drillLocationController?.dispose();
    drillTitleController?.dispose();
    descriptionController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShowNoticeOnSmall(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const PDAppBar(),
                      const PDProgressBar(0.12),
                      Stack(
                        children: [
                          const PDStepsList(0),
                          // Body
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 24, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        constraints: const BoxConstraints(
                                          maxWidth: 570,
                                        ),
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x33000000),
                                              offset: Offset(0, 3),
                                              spreadRadius: 2,
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(16, 16, 16, 16),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 16, 0, 0),
                                                child: Container(
                                                  width: double.infinity,
                                                  constraints:
                                                      const BoxConstraints(
                                                    maxWidth: 570,
                                                  ),
                                                  decoration:
                                                      const BoxDecoration(),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            16, 0, 16, 0),
                                                    child: SelectionArea(
                                                        child: Text(
                                                      'Info',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .title1,
                                                    )),
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                height: 24,
                                                thickness: 2,
                                                indent: 12,
                                                endIndent: 12,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryColor,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                        16, 16, 16, 0),
                                                child: TextFormField(
                                                  controller:
                                                      drillTitleController,
                                                  autofocus: true,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelText: 'Drill Title',
                                                    labelStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .title3
                                                        .override(
                                                          fontFamily:
                                                              'Space Grotesk',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                    hintText:
                                                        '["Seaside Tsunami Evacuation Drill"]',
                                                    hintStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .title2
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                        ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryColor,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryColor,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    filled: true,
                                                    fillColor: FlutterFlowTheme
                                                            .of(context)
                                                        .secondaryBackground,
                                                    contentPadding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            20, 32, 20, 12),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .title2,
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                        16, 16, 16, 0),
                                                child: TextFormField(
                                                  controller:
                                                      drillLocationController,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelText: 'Drill Location',
                                                    labelStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .title3
                                                        .override(
                                                          fontFamily:
                                                              'Space Grotesk',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                    hintText:
                                                        '[“Seaside, Oregon", “Klamath County, Oregon", etc…]',
                                                    hintStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .subtitle2
                                                            .override(
                                                              fontFamily:
                                                                  'Space Grotesk',
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                            ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryColor,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryColor,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    filled: true,
                                                    fillColor: FlutterFlowTheme
                                                            .of(context)
                                                        .secondaryBackground,
                                                    contentPadding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            20, 32, 20, 12),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .subtitle2,
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            16, 16, 0, 0),
                                                    child: FlutterFlowDropDown<
                                                        String>(
                                                      initialOption:
                                                          drillTypeValue ??=
                                                              'Tsunami',
                                                      options: const [
                                                        'Tsunami',
                                                        'Earthquake',
                                                        'Fire'
                                                      ],
                                                      onChanged: (val) =>
                                                          setState(() =>
                                                              drillTypeValue =
                                                                  val),
                                                      width: 160,
                                                      height: 50,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .subtitle2,
                                                      hintText:
                                                          'Please select...',
                                                      fillColor: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      elevation: 2,
                                                      borderColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiaryColor,
                                                      borderWidth: 2,
                                                      borderRadius: 8,
                                                      margin:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              12, 4, 12, 4),
                                                      hidesUnderline: true,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            16, 16, 16, 0),
                                                    child: InkWell(
                                                      onTap: () async {
                                                        if (kIsWeb) {
                                                          final datePickedDate =
                                                              await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                getCurrentTimestamp,
                                                            firstDate:
                                                                getCurrentTimestamp,
                                                            lastDate:
                                                                DateTime(2050),
                                                          );
                                                          if (datePickedDate !=
                                                              null) {
                                                            setState(
                                                              () => datePicked =
                                                                  DateTime(
                                                                datePickedDate
                                                                    .year,
                                                                datePickedDate
                                                                    .month,
                                                                datePickedDate
                                                                    .day,
                                                              ),
                                                            );
                                                          }
                                                        } else {
                                                          await DatePicker
                                                              .showDatePicker(
                                                            context,
                                                            showTitleActions:
                                                                true,
                                                            onConfirm: (date) {
                                                              setState(() =>
                                                                  datePicked =
                                                                      date);
                                                            },
                                                            currentTime:
                                                                getCurrentTimestamp,
                                                            minTime:
                                                                getCurrentTimestamp,
                                                          );
                                                        }
                                                      },
                                                      child: Container(
                                                        width: 312,
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .tertiaryColor,
                                                            width: 2,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  12, 5, 12, 5),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  dateTimeFormat(
                                                                    'MMMMEEEEd',
                                                                    datePicked,
                                                                    locale:
                                                                        LocaleType
                                                                            .en
                                                                            .name,
                                                                  ),
                                                                  'Start Date',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .subtitle2,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .date_range_outlined,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
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
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                        16, 16, 16, 0),
                                                child: TextFormField(
                                                  controller: blurbController,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelText: 'blurb',
                                                    labelStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyText1
                                                            .override(
                                                              fontFamily:
                                                                  'Space Grotesk',
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                            ),
                                                    hintText:
                                                        '[Enter blurb here... “Help us test evacuation infrastructure in Seaside!"]',
                                                    hintStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyText2,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryColor,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryColor,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    filled: true,
                                                    fillColor: FlutterFlowTheme
                                                            .of(context)
                                                        .secondaryBackground,
                                                    contentPadding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            20, 32, 20, 12),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1,
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                        16, 16, 16, 16),
                                                child: TextFormField(
                                                  controller:
                                                      descriptionController,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelText: 'description',
                                                    labelStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyText1
                                                            .override(
                                                              fontFamily:
                                                                  'Space Grotesk',
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                            ),
                                                    hintText:
                                                        '[Enter description here...]',
                                                    hintStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyText2,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryColor,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryColor,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    filled: true,
                                                    fillColor: FlutterFlowTheme
                                                            .of(context)
                                                        .secondaryBackground,
                                                    contentPadding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            20, 32, 20, 12),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1,
                                                  textAlign: TextAlign.start,
                                                  maxLines: 4,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: EdgeInsetsDirectional.fromSTEB(
                                      //       0, 0, 0, 24),
                                      //   child: Container(
                                      //     width: double.infinity,
                                      //     height: 0,
                                      //     constraints: BoxConstraints(
                                      //       maxWidth: 570,
                                      //     ),
                                      //     decoration: BoxDecoration(
                                      //       color: FlutterFlowTheme.of(context)
                                      //           .secondaryBackground,
                                      //       borderRadius:
                                      //           BorderRadius.circular(16),
                                      //       border: Border.all(
                                      //         color:
                                      //             FlutterFlowTheme.of(context)
                                      //                 .tertiaryColor,
                                      //         width: 2,
                                      //       ),
                                      //     ),
                                      //     child: Padding(
                                      //       padding:
                                      //           EdgeInsetsDirectional.fromSTEB(
                                      //               16, 0, 16, 0),
                                      //       child: Column(
                                      //         mainAxisSize: MainAxisSize.max,
                                      //         children: [
                                      //           Padding(
                                      //             padding: EdgeInsetsDirectional
                                      //                 .fromSTEB(16, 24, 16, 12),
                                      //             child: Row(
                                      //               mainAxisSize:
                                      //                   MainAxisSize.max,
                                      //               mainAxisAlignment:
                                      //                   MainAxisAlignment
                                      //                       .spaceBetween,
                                      //               children: [
                                      //                 SelectionArea(
                                      //                     child: Text(
                                      //                   'Procedure',
                                      //                   style:
                                      //                       FlutterFlowTheme.of(
                                      //                               context)
                                      //                           .title1,
                                      //                 )),
                                      //                 Row(
                                      //                   mainAxisSize:
                                      //                       MainAxisSize.max,
                                      //                   mainAxisAlignment:
                                      //                       MainAxisAlignment
                                      //                           .end,
                                      //                   children: [
                                      //                     Padding(
                                      //                       padding:
                                      //                           EdgeInsetsDirectional
                                      //                               .fromSTEB(
                                      //                                   0,
                                      //                                   0,
                                      //                                   8,
                                      //                                   0),
                                      //                       child:
                                      //                           FFButtonWidget(
                                      //                         onPressed: () {
                                      //                           print(
                                      //                               'Button pressed ...');
                                      //                         },
                                      //                         text:
                                      //                             'Reorder Tasks',
                                      //                         icon: Icon(
                                      //                           Icons
                                      //                               .reorder_rounded,
                                      //                           color: FlutterFlowTheme.of(
                                      //                                   context)
                                      //                               .tertiaryColor,
                                      //                           size: 15,
                                      //                         ),
                                      //                         options:
                                      //                             FFButtonOptions(
                                      //                           width: 164,
                                      //                           height: 40,
                                      //                           color: FlutterFlowTheme.of(
                                      //                                   context)
                                      //                               .secondaryText,
                                      //                           textStyle: FlutterFlowTheme.of(
                                      //                                   context)
                                      //                               .subtitle2
                                      //                               .override(
                                      //                                 fontFamily:
                                      //                                     'Space Grotesk',
                                      //                                 color: FlutterFlowTheme.of(
                                      //                                         context)
                                      //                                     .tertiaryColor,
                                      //                               ),
                                      //                           borderSide:
                                      //                               BorderSide(
                                      //                             width: 1,
                                      //                           ),
                                      //                           borderRadius:
                                      //                               BorderRadius
                                      //                                   .circular(
                                      //                                       8),
                                      //                         ),
                                      //                       ),
                                      //                     ),
                                      //                     Padding(
                                      //                       padding:
                                      //                           EdgeInsetsDirectional
                                      //                               .fromSTEB(
                                      //                                   0,
                                      //                                   0,
                                      //                                   1,
                                      //                                   0),
                                      //                       child:
                                      //                           FFButtonWidget(
                                      //                         onPressed: () {
                                      //                           print(
                                      //                               'Button pressed ...');
                                      //                         },
                                      //                         text: 'Add Task',
                                      //                         icon: Icon(
                                      //                           Icons
                                      //                               .add_rounded,
                                      //                           color: Colors
                                      //                               .white,
                                      //                           size: 15,
                                      //                         ),
                                      //                         options:
                                      //                             FFButtonOptions(
                                      //                           width: 128,
                                      //                           height: 40,
                                      //                           color: FlutterFlowTheme.of(
                                      //                                   context)
                                      //                               .primaryColor,
                                      //                           textStyle: FlutterFlowTheme.of(
                                      //                                   context)
                                      //                               .subtitle2
                                      //                               .override(
                                      //                                 fontFamily:
                                      //                                     'Space Grotesk',
                                      //                                 color: Colors
                                      //                                     .white,
                                      //                               ),
                                      //                           borderSide:
                                      //                               BorderSide(
                                      //                             width: 1,
                                      //                           ),
                                      //                           borderRadius:
                                      //                               BorderRadius
                                      //                                   .circular(
                                      //                                       8),
                                      //                         ),
                                      //                       ),
                                      //                     ),
                                      //                   ],
                                      //                 ),
                                      //               ],
                                      //             ),
                                      //           ),
                                      //           Divider(
                                      //             height: 4,
                                      //             thickness: 2,
                                      //             indent: 12,
                                      //             endIndent: 12,
                                      //             color: FlutterFlowTheme.of(
                                      //                     context)
                                      //                 .tertiaryColor,
                                      //           ),
                                      //           Container(
                                      //             height: MediaQuery.of(context)
                                      //                     .size
                                      //                     .height *
                                      //                 0.7,
                                      //             decoration: BoxDecoration(
                                      //               color: FlutterFlowTheme.of(
                                      //                       context)
                                      //                   .secondaryBackground,
                                      //             ),
                                      //             child: ListView(
                                      //               padding: EdgeInsets.zero,
                                      //               scrollDirection:
                                      //                   Axis.vertical,
                                      //               children: [
                                      //                 SurveyTaskFieldWidget(),
                                      //                 ReqLocPermsTaskFieldWidget(),
                                      //                 WaitForStartTaskFieldWidget(),
                                      //                 PracticeEvacTaskFieldWidget(),
                                      //                 SurveyTaskFieldWidget(),
                                      //                 UploadTaskFieldWidget(),
                                      //               ],
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // SizeDisplay(),
                        ],
                      ),
                    ],
                  ),
                  // plan drill BottomNavButtons
                  const PDBottomNavButtons(
                    backActive: false,
                    forwardIsReview: false,
                    forwardText: 'Procedure',
                    forwardRoute: 'planDrill-Procedure',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
