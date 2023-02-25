// // import 'package:evac_drill_console/flutter_flow/flutter_flow_place_picker.dart';
// import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
// import 'package:evac_drill_console/flutter_flow/flutter_flow_widgets.dart';
// // import 'package:evac_drill_console/flutter_flow/place.dart';
// import 'package:flutter/material.dart';

// class TravelTaskField extends StatefulWidget {
//   const TravelTaskField({Key? key}) : super(key: key);

//   @override
//   _TravelTaskFieldState createState() => _TravelTaskFieldState();
// }

// class _TravelTaskFieldState extends State<TravelTaskField> {
//   TextEditingController? textController1;
//   TextEditingController? textController2;
//   var placePickerValue = FFPlace();

//   @override
//   void initState() {
//     super.initState();
//     textController1 = TextEditingController();
//     textController2 = TextEditingController();
//     WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
//   }

//   @override
//   void dispose() {
//     textController1?.dispose();
//     textController2?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
//       child: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: FFTheme.of(context).primaryBackground,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: FFTheme.of(context).secondaryBackground,
//             width: 2,
//           ),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Padding(
//               padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
//               child: Row(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
//                     child: SelectionArea(
//                         child: Text(
//                       'Location name:',
//                       style: FFTheme.of(context).bodyText1,
//                     )),
//                   ),
//                   Expanded(
//                     child: TextFormField(
//                       controller: textController1,
//                       autofocus: true,
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         hintText: '[Some hint text...]',
//                         hintStyle: FFTheme.of(context).bodyText2,
//                         enabledBorder: UnderlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Color(0x00000000),
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         focusedBorder: UnderlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Color(0x00000000),
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         errorBorder: UnderlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Color(0x00000000),
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         focusedErrorBorder: UnderlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Color(0x00000000),
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         filled: true,
//                         fillColor:
//                             FFTheme.of(context).secondaryBackground,
//                       ),
//                       style: FFTheme.of(context).bodyText1,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
//               child: Row(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
//                     child: SelectionArea(
//                         child: Text(
//                       'Location name:',
//                       style: FFTheme.of(context).bodyText1,
//                     )),
//                   ),
//                   Expanded(
//                     child: TextFormField(
//                       controller: textController2,
//                       autofocus: true,
//                       obscureText: false,
//                       decoration: InputDecoration(
//                         hintText: '[Some hint text...]',
//                         hintStyle: FFTheme.of(context).bodyText2,
//                         enabledBorder: UnderlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Color(0x00000000),
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         focusedBorder: UnderlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Color(0x00000000),
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         errorBorder: UnderlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Color(0x00000000),
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         focusedErrorBorder: UnderlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Color(0x00000000),
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         filled: true,
//                         fillColor:
//                             FFTheme.of(context).secondaryBackground,
//                       ),
//                       style: FFTheme.of(context).bodyText1,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             FlutterFlowPlacePicker(
//               iOSGoogleMapsApiKey: '',
//               androidGoogleMapsApiKey: '',
//               webGoogleMapsApiKey: '',
//               onSelect: (place) async {
//                 setState(() => placePickerValue = place);
//               },
//               defaultText: 'Select Location',
//               icon: const Icon(
//                 Icons.place,
//                 color: Colors.white,
//                 size: 16,
//               ),
//               buttonOptions: FFButtonOptions(
//                 width: 200,
//                 height: 40,
//                 color: FFTheme.of(context).primaryColor,
//                 textStyle: FFTheme.of(context).subtitle2.override(
//                       fontFamily: 'Space Grotesk',
//                       color: Colors.white,
//                     ),
//                 borderSide: const BorderSide(
//                   color: Colors.transparent,
//                   width: 1,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
