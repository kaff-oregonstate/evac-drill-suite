import 'package:evac_app/components/utility/styled_dialog.dart';
import 'package:evac_app/extra_dialog_contents/confirm_drill_details_content.dart';
import 'package:evac_app/models/drill_details/drill_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

/// These Waves are fullscreen sized, and can present the details of an
/// Evacuation Drill for confirmation on FirstPage. They also look nice at the
/// bottom of DrillPage.

class Waves extends StatelessWidget {
  const Waves({
    Key? key,
    required this.topOffset,
    required this.onDrillConfirmed,
    required this.wavesShowDrillDetails,
    required this.drillDetails,
  }) : super(key: key);

  final double topOffset;
  final Function onDrillConfirmed;
  final bool wavesShowDrillDetails;
  final DrillDetails? drillDetails;

  @override
  Widget build(BuildContext context) {
    final Size pageSize = MediaQuery.of(context).size;
    final double safePaddingTop = MediaQuery.of(context).padding.top;
    final double safePaddingBottom = MediaQuery.of(context).padding.bottom;
    return Hero(
      tag: 'waves',
      child: Stack(children: [
        SvgPicture.asset(
          'assets/images/waves/lightWaves.svg',
          width: pageSize.width,
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
          theme: SvgTheme(currentColor: Colors.blue[600]!),
        ),
        SvgPicture.asset(
          'assets/images/waves/mediumWaves.svg',
          width: pageSize.width,
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
          theme: SvgTheme(currentColor: Colors.blue[700]!),
        ),
        SvgPicture.asset(
          'assets/images/waves/darkWaves.svg',
          width: pageSize.width,
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
          theme: SvgTheme(currentColor: Colors.blue[800]!),
        ),
        Container(
          alignment: Alignment.center,
          width: pageSize.width,
          height: pageSize.height - safePaddingBottom - safePaddingTop,
          padding: EdgeInsets.only(bottom: topOffset),
          child: Center(
            child: StyledDialog(
                child: wavesShowDrillDetails
                    ? ConfirmDrillDetailsContent(
                        onDrillConfirmed: onDrillConfirmed,
                        drillDetails: drillDetails,
                        pageSizeHeight: pageSize.height,
                      )
                    : const LoadingDialogContent()),
          ),
        ),
      ]),
    );
  }
}

class LoadingDialogContent extends StatelessWidget {
  const LoadingDialogContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: SizedBox(
            child: CircularProgressIndicator(),
            height: 128,
            width: 128,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'loading…',
          style: GoogleFonts.getFont(
            'Open Sans',
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 36,
          ),
        ),
      ],
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
