import 'package:evac_app/components/utility/styled_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WaitForStartDisplay extends StatefulWidget {
  const WaitForStartDisplay(
      {Key? key,
      required this.pushPracticeEvac,
      required this.setWaitForStartResult})
      : super(key: key);

  final Function pushPracticeEvac;
  final Function setWaitForStartResult;

  @override
  State<WaitForStartDisplay> createState() => _WaitForStartDisplayState();
}

class _WaitForStartDisplayState extends State<WaitForStartDisplay> {
  late List<Widget> displayedContent;

  @override
  void initState() {
    displayedContent = stillWaitingContent();
    changeDisplayedContent();
    super.initState();
  }

  void changeDisplayedContent() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      displayedContent = waitCompleteContent();
    });
  }

  @override
  Widget build(BuildContext context) {
    final topContext = context;
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: SafeArea(
        child: Stack(children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: displayedContent,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: BackButton(
              color: Colors.white.withAlpha(142),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StyledAlertDialog(
                      context: context,
                      title: 'Exit to Tasks?',
                      subtitle:
                          'You will not be able to start performing the drill from that menu.',
                      cancelText: 'Keep Waiting',
                      cancelFunc: () {
                        Navigator.pop(context);
                      },
                      confirmText: 'Exit to Tasks',
                      confirmFunc: () {
                        widget.setWaitForStartResult(false);
                        Navigator.pop(context);
                        Navigator.pop(topContext);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ]),
      ),
    );
  }

  List<Widget> stillWaitingContent() {
    return [
      SizedBox(
        child: CupertinoActivityIndicator(
          radius: 64,
        ),
        height: 128,
        width: 128,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Text(
          'Acquiring GPS Signal...',
          style: GoogleFonts.openSans(
            color: Colors.grey[800],
            fontWeight: FontWeight.w700,
            fontSize: 28,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ];
  }

  List<Widget> waitCompleteContent() {
    return [
      Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Text(
          'Acquired GPS Signal',
          style: GoogleFonts.openSans(
            color: Colors.grey[800],
            fontWeight: FontWeight.w700,
            fontSize: 28,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withAlpha(51),
                blurRadius: 6,
                offset: Offset(0, 2))
          ],
        ),
        child: CupertinoButton.filled(
          child: Text(
            'Let\'s get started!',
            style: GoogleFonts.openSans(),
          ),
          onPressed: () {
            widget.setWaitForStartResult(true);
            widget.pushPracticeEvac();
          },
        ),
      ),
    ];
  }
}
