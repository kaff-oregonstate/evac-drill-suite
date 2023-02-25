import 'package:evac_drill_console/flutter_flow/flutter_flow_widgets.dart';
import 'package:evac_drill_console/plan_drill/plan_drill_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../models/drill_plan.dart';

class PDInfo extends StatefulWidget {
  const PDInfo(this.pdController, {super.key});

  final PDController pdController;

  @override
  State<PDInfo> createState() => _PDInfoState();
}

// TODO: PubKEy
class _PDInfoState extends State<PDInfo> {
  DateTime? datePicked;
  DrillType? drillTypeValue;
  TextEditingController? drillLocationController;
  TextEditingController? drillTitleController;
  TextEditingController? blurbController;
  TextEditingController? descriptionController;

  @override
  void initState() {
    super.initState();
    drillTypeValue = widget.pdController.drillPlan.type;
    datePicked = widget.pdController.drillPlan.meetingDateTime;
    blurbController = TextEditingController(
      text: widget.pdController.drillPlan.blurb,
    );
    drillLocationController = TextEditingController(
      text: widget.pdController.drillPlan.meetingLocationPlainText,
    );
    drillTitleController = TextEditingController(
      text: widget.pdController.drillPlan.title,
    );
    descriptionController = TextEditingController(
      text: widget.pdController.drillPlan.description,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
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
    return
        // PDInfo Body
        Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // title
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 32, 16, 12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectionArea(
                child: Text('Info', style: FFTheme.of(context).title1),
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
        PDInfoTextField(
          true,
          widget.pdController,
          drillTitleController,
          'title',
          'Drill Title',
          '["Seaside Tsunami Evacuation Drill"]',
          autofocus: true,
        ),
        PDInfoTextField(
          true,
          widget.pdController,
          drillLocationController,
          'meetingLocationPlainText',
          'Drill Location',
          '[“Seaside, Oregon", “Klamath County, Oregon", etc…]',
          med: true,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PDInfoPickerField(
              datePicked: datePicked,
              onTap: () {
                if (kIsWeb) {
                  showDatePicker(
                    context: context,
                    initialDate: datePicked ?? getCurrentTimestamp,
                    firstDate: getCurrentTimestamp,
                    lastDate: DateTime(2050),
                  ).then((datePickedDate) {
                    if (datePickedDate != null) {
                      setState(
                        () => datePicked = DateTime(
                          datePickedDate.year,
                          datePickedDate.month,
                          datePickedDate.day,
                        ),
                      );
                      widget.pdController
                          .setParameter('meetingDateTime', datePicked);
                    }
                  });
                }
              },
              text: valueOrDefault<String>(
                dateTimeFormat(
                  'yMMMMEEEEd',
                  datePicked,
                  locale: LocaleType.en.name,
                ),
                'Start Date',
              ),
              iconData: Icons.date_range_outlined,
              color: FFTheme.of(context).secondaryBackground,
              left: true,
            ),
            const SizedBox(width: 16),
            PDInfoPickerField(
              datePicked: datePicked,
              onTap: () {
                if (datePicked != null && kIsWeb) {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(
                        datePicked ?? getCurrentTimestamp),
                  ).then((timePicked) {
                    if (timePicked != null) {
                      setState(
                        () => datePicked = DateTime(
                          datePicked!.year,
                          datePicked!.month,
                          datePicked!.day,
                          timePicked.hour,
                          timePicked.minute,
                        ),
                      );
                      widget.pdController
                          .setParameter('meetingDateTime', datePicked);
                    }
                  });
                }
              },
              text: (datePicked != null)
                  ? valueOrDefault<String>(
                      dateTimeFormat(
                        'hh:mm a',
                        datePicked,
                        locale: LocaleType.en.name,
                      ),
                      'Start Time',
                    )
                  : 'Pick day first',
              iconData: Icons.access_time_rounded,
              color: (datePicked != null)
                  ? FFTheme.of(context).secondaryBackground
                  : Colors.transparent,
              left: false,
            ),
          ],
        ),
        if (widget.pdController.drillPlan.publicKey == null ||
            widget.pdController.drillPlan.publicKey!.isEmpty)
          Container(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
            child: FFButtonWidget(
              text: 'Paste Public Key for Encryption from Clipboard',
              onPressed: () async {
                final publicKey = (await Clipboard.getData('text/plain'))?.text;
                try {
                  // TODO: implement paste pubkey from clipboard
                  print('got clipboard: $publicKey');

                  if (publicKey == null) {
                    return;
                  }
                  if (!publicKey.startsWith('-----')) {
                    throw const FormatException(
                        'Invalid PEM key format on Public Key paste from clipboard');
                  }
                  if (publicKey.startsWith('-----BEGIN PRIVATE KEY-----')) {
                    throw const FormatException(
                        'Attempting to input Private Key when Public Key required');
                  }
                  if (!publicKey.startsWith('-----BEGIN PUBLIC KEY-----')) {
                    throw const FormatException(
                        'Invlaid PEM Public Key format');
                  }
                  print('made it past publicKey formatting checks');

                  widget.pdController.setParameter('publicKey', publicKey);
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      icon: const Icon(Icons.error_outline_rounded),
                      title: const Text('Error pasting Public Key:'),
                      content: Text(
                          'The following error was returned:\n$e\nHere\'s what was pasted:\n$publicKey'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Ok'),
                        )
                      ],
                    ),
                  );
                }
              },
              icon: Icon(
                Icons.key_rounded,
                color: FFTheme.of(context).primaryBtnText,
                size: 32,
              ),
              options: FFButtonOptions(
                height: 44,
                width: double.infinity,
                padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                color: FFTheme.of(context).tertiaryColor,
                textStyle: FFTheme.of(context).subtitle1.override(
                      fontFamily: 'Outfit',
                      color: FFTheme.of(context).primaryBtnText,
                    ),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        if (widget.pdController.drillPlan.publicKey != null &&
            widget.pdController.drillPlan.publicKey!.isNotEmpty)
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
            child: Center(
                child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text:
                        'A valid public key has been added to this drill plan. ',
                  ),
                  TextSpan(
                    text: 'Remove it.',
                    style: FFTheme.of(context).bodyText1.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () =>
                          widget.pdController.setParameter('publicKey', ''),
                  )
                ],
                style: FFTheme.of(context).bodyText1,
              ),
            )),
          ),
        PDInfoTextField(
          false,
          widget.pdController,
          blurbController,
          'blurb',
          'blurb (optional)',
          '[Enter blurb here... “Help us test evacuation infrastructure in Seaside!"]',
        ),
        PDInfoTextField(
          false,
          widget.pdController,
          descriptionController,
          'description',
          'description (optional)',
          '[Enter description here...]',
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

// // Type choosing (only tsunami for now, leave out)
// Padding(
//   padding: const EdgeInsetsDirectional.fromSTEB(
//       16, 16, 0, 0),
//   child: FlutterFlowDropDown<String>(
//     initialOption: drillTypeValue?.name ??
//         DrillType.tsunami.name,
//     options: [
//       DrillType.tsunami.name,
//       // 'Earthquake',
//       // 'Fire'
//     ],
//     onChanged: (val) => setState(() {
//       drillTypeValue = DrillType.values
//           .where((element) => element.name == val)
//           .first;
//       widget.pdController
//           .setParameter('type', drillTypeValue);
//     }),
//     width: 160,
//     height: 50,
//     textStyle:
//         FFTheme.of(context).subtitle2,
//     hintText: 'Please select...',
//     fillColor: FFTheme.of(context)
//         .secondaryBackground,
//     elevation: 2,
//     borderColor:
//         FFTheme.of(context).tertiaryColor,
//     borderWidth: 2,
//     borderRadius: 8,
//     margin: const EdgeInsetsDirectional.fromSTEB(
//         12, 4, 12, 4),
//     hidesUnderline: true,
//   ),
// ),

class PDInfoTextField extends StatelessWidget {
  const PDInfoTextField(
    this.big,
    this.pdController,
    this.textFieldController,
    this.param,
    this.labelText,
    this.hintText, {
    this.med,
    this.autofocus,
    super.key,
  });

  final bool big;
  final bool? med;
  final bool? autofocus;
  final PDController pdController;
  final TextEditingController? textFieldController;
  final String param; // 'title'
  final String labelText; // 'Drill Title'
  final String hintText; // '["Seaside Tsunami Evacuation Drill"]'

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
      child: TextField(
        controller: textFieldController,
        onChanged: (value) => pdController.setParameter(param, value),
        autofocus: autofocus ?? false,
        obscureText: false,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: (big)
              ? FFTheme.of(context).title3.override(
                    fontFamily: 'Space Grotesk',
                    color: FFTheme.of(context).secondaryText,
                    fontWeight: FontWeight.normal,
                  )
              : FFTheme.of(context).bodyText1.override(
                    fontFamily: 'Space Grotesk',
                    color: FFTheme.of(context).secondaryText,
                  ),
          hintText: hintText,
          hintStyle: (big)
              ? ((med ?? false)
                      ? FFTheme.of(context).subtitle2
                      : FFTheme.of(context).title2)
                  .override(
                  fontFamily: 'Outfit',
                  color: FFTheme.of(context).secondaryText,
                )
              : FFTheme.of(context).bodyText2,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: FFTheme.of(context).tertiaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: FFTheme.of(context).tertiaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: FFTheme.of(context).secondaryBackground,
          contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
        ),
        style: (big)
            ? (med ?? false)
                ? FFTheme.of(context).subtitle2
                : FFTheme.of(context).title2
            : FFTheme.of(context).bodyText1,
        textAlign: TextAlign.start,
      ),
    );
  }
}

class PDInfoPickerField extends StatelessWidget {
  const PDInfoPickerField({
    required this.datePicked,
    required this.onTap,
    required this.text,
    required this.iconData,
    required this.color,
    required this.left,
    super.key,
  });

  final DateTime? datePicked;
  final Function() onTap;
  final String text;
  final IconData iconData;
  final Color color;
  final bool left;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: (left)
          ? const EdgeInsets.only(left: 16)
          : const EdgeInsets.only(right: 16),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: color,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Container(
            width: (left) ? 312 : 160,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: FFTheme.of(context).tertiaryColor,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 5, 12, 5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: FFTheme.of(context).subtitle2,
                  ),
                  Icon(
                    iconData,
                    color: FFTheme.of(context).secondaryText,
                    size: 24,
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
