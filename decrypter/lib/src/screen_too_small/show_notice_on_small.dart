import 'package:flutter/material.dart';
import 'screen_too_small.dart';

class ShowNoticeOnSmall extends StatelessWidget {
  const ShowNoticeOnSmall({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return (constraints.maxWidth < 460 || constraints.maxHeight < 460)
          ? const ScreenTooSmall()
          : child;
    });
  }
}
