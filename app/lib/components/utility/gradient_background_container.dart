import 'package:flutter/material.dart';

class GradientBackgroundContainer extends StatelessWidget {
  const GradientBackgroundContainer({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final pageSize = MediaQuery.of(context).size;
    return Container(
      height: pageSize.height,
      width: pageSize.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 243, 99, 59),
              Color.fromARGB(255, 243, 99, 59),
              Color.fromARGB(255, 240, 152, 65),
              Color.fromARGB(255, 243, 99, 59),
            ]),
      ),
      child: child,
    );
  }
}
