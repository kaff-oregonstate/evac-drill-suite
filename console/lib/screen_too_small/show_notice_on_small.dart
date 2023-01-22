import 'package:evac_drill_console/screen_too_small/screen_too_small.dart';
import 'package:flutter/material.dart';

class ShowNoticeOnSmall extends StatelessWidget {
  const ShowNoticeOnSmall({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return (constraints.maxWidth < 1150 || constraints.maxHeight < 650)
          ? const ScreenTooSmall()
          : child;
    });
  }
}
