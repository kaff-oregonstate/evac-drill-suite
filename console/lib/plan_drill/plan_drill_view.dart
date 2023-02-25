import 'package:flutter/material.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'pd_evacuation.dart';
import 'pd_info.dart';
import 'pd_procedure.dart';
import 'pd_survey.dart';
import 'plan_drill_controller.dart';

class PDView extends StatefulWidget {
  const PDView(this.pdController, {super.key});

  final PDController? pdController;

  @override
  State<PDView> createState() => _PDViewState();
}

class _PDViewState extends State<PDView> {
  @override
  void initState() {
    super.initState();
    if (widget.pdController != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => widget
          .pdController!.pageController
          .jumpToPage(widget.pdController!.currentPage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return (widget.pdController == null)
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : PageView.builder(
            controller: widget.pdController!.pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.pdController!.views.length,
            itemBuilder: (context, index) {
              final thisView = widget.pdController!.views[index];
              final String viewName = thisView['name'];
              if (viewName == 'info') {
                return PDViewWrapper(child: PDInfo(widget.pdController!));
              }
              if (viewName == 'procedure') {
                return PDViewWrapper(child: PDProcedure(widget.pdController!));
              }
              if (viewName.startsWith('survey')) {
                return PDViewWrapper(
                  child: PDSurvey(widget.pdController!, thisView['taskID']),
                );
              }
              if (viewName.startsWith('evac')) {
                return PDViewWrapper(
                  child: PDEvacuation(widget.pdController!, thisView['taskID']),
                );
              }
              throw Exception(
                  'internal: bad viewName on PDView Page View builder');
            },
          );
  }
}

class PDViewWrapper extends StatelessWidget {
  const PDViewWrapper({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 24),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 570),
            decoration: BoxDecoration(
              color: FFTheme.of(context).primaryBackground,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x33000000),
                  offset: Offset(0, 3),
                  spreadRadius: 2,
                )
              ],
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: child,
          ),
        ),
      ],
    );
  }
}
