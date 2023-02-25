import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../plan_drill/plan_drill_controller.dart';

class PDBottomNavButtons extends StatelessWidget {
  const PDBottomNavButtons({
    Key? key,
    required this.pdController,
  }) : super(key: key);

  final PDController pdController;

  static const _sideSpacing = 24.0;
  static const _bottomSpacing = 32.0;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'PDBottomNavButtonsHeroTag',
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  _sideSpacing, 0, 0, _bottomSpacing),
              child: (pdController.currentPage > 0)
                  ? ActiveLeftNavButton(
                      pdController.steps[pdController.currentPage - 1],
                      () => pdController.navToPrev(),
                    )
                  : const InactiveLeftNavButton(),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  0, 0, _sideSpacing, _bottomSpacing),
              child: (pdController.currentPage == pdController.steps.length - 1)
                  ? ReviewNavButton(
                      onPressed: () async {
                        if (pdController.unsavedChanges) {
                          await pdController.syncChanges().then((value) {
                            context.goNamed(
                              'viewDrillPlan',
                              params: {
                                'drillID': pdController.drillPlan.drillID
                              },
                              extra: {
                                kTransitionInfoKey: const TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                ),
                              },
                            );
                          });
                        } else {
                          context.goNamed(
                            'viewDrillPlan',
                            params: {'drillID': pdController.drillPlan.drillID},
                            extra: {
                              kTransitionInfoKey: const TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.fade,
                                duration: Duration(milliseconds: 0),
                              ),
                            },
                          );
                        }
                      },
                    )
                  : RightNavButton(
                      pdController.steps[pdController.currentPage + 1],
                      () => pdController.navToNext(),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class RightNavButton extends StatelessWidget {
  const RightNavButton(
    this.forwardText,
    this.goToNextPage, {
    Key? key,
  }) : super(key: key);

  final String forwardText;
  final Function goToNextPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: FFTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            goToNextPage();
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Next step:',
                      style: FFTheme.of(context).bodyText2,
                    ),
                    Text(
                      forwardText,
                      style: FFTheme.of(context).subtitle1.override(
                            fontFamily: 'Outfit',
                            color: FFTheme.of(context).secondaryText,
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.keyboard_arrow_right_rounded,
                color: FFTheme.of(context).secondaryText,
                size: 48,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewNavButton extends StatelessWidget {
  const ReviewNavButton({required this.onPressed, super.key});

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      text: 'Save & Review',
      onPressed: onPressed,
      icon: Icon(
        Icons.inventory_rounded,
        color: FFTheme.of(context).primaryBtnText,
        size: 32,
      ),
      options: FFButtonOptions(
        height: 66,
        width: 190,
        padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
        color: FFTheme.of(context).primaryColor,
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
    );
  }
}

class ActiveLeftNavButton extends StatelessWidget {
  const ActiveLeftNavButton(
    this.backText,
    this.goToPrevPage, {
    Key? key,
  }) : super(key: key);

  final String backText;
  final Function goToPrevPage;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          goToPrevPage();
        },
        child: Container(
          decoration: BoxDecoration(
            // color: FFTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.keyboard_arrow_left_rounded,
                color: FFTheme.of(context).secondaryText,
                size: 48,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Previous step:',
                      style: FFTheme.of(context).bodyText2.override(
                            fontFamily: 'Space Grotesk',
                            color: FFTheme.of(context).secondaryText,
                          ),
                    ),
                    Text(
                      backText,
                      style: FFTheme.of(context).subtitle1.override(
                            fontFamily: 'Outfit',
                            color: FFTheme.of(context).secondaryText,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InactiveLeftNavButton extends StatelessWidget {
  const InactiveLeftNavButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FFTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.keyboard_arrow_left_rounded,
            color: FFTheme.of(context).tertiaryColor,
            size: 48,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Previous step:',
                  style: FFTheme.of(context).bodyText2.override(
                        fontFamily: 'Space Grotesk',
                        color: FFTheme.of(context).tertiaryColor,
                      ),
                ),
                Text(
                  '…',
                  style: FFTheme.of(context).subtitle1.override(
                        fontFamily: 'Outfit',
                        color: FFTheme.of(context).tertiaryColor,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PublishNavButton extends StatelessWidget {
  const PublishNavButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FFTheme.of(context).primaryColor,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x33000000),
            offset: Offset(0, 3),
            spreadRadius: 2,
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
              child: Icon(
                Icons.cloud_upload_rounded,
                color: FFTheme.of(context).primaryBtnText,
                size: 38,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 8, 0),
              child: Text(
                'Publish Drill',
                style: FFTheme.of(context).title1.override(
                      fontFamily: 'Outfit',
                      color: FFTheme.of(context).primaryBtnText,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
