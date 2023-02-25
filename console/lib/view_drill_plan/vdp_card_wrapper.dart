import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class VDPCardWrapper extends StatelessWidget {
  const VDPCardWrapper({
    required this.drillID,
    required this.isCreator,
    required this.title,
    required this.pdView,
    required this.hintText,
    required this.children,
    super.key,
  });

  final String drillID;
  final bool isCreator;
  final String title;
  final String pdView;
  final String hintText;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: FFTheme.of(context).tertiaryColor,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 8, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          title,
                          style: FFTheme.of(context).title3.override(
                                fontFamily: 'Outfit',
                                color: FFTheme.of(context).secondaryText,
                              ),
                        ),
                      ),
                    ),
                    if (isCreator)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8.0),
                          clipBehavior: Clip.antiAlias,
                          child: IconButton(
                            onPressed: () => context.goNamed(
                              'planDrill',
                              params: {'drillID': drillID},
                              extra: {
                                kTransitionInfoKey: const TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                ),
                                'planDrillView': pdView,
                              },
                            ),
                            icon: Icon(
                              Icons.edit_rounded,
                              color: FFTheme.of(context).secondaryText,
                            ),
                            tooltip: (isCreator) ? hintText : null,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Divider(
                height: 4,
                thickness: 2,
                indent: 12,
                endIndent: 12,
                color: FFTheme.of(context).tertiaryColor,
              ),
              const SizedBox(height: 10),
              SelectionArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
