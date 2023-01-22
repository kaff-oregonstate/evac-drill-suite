import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class PDBottomNavButtons extends StatelessWidget {
  const PDBottomNavButtons(
      {Key? key,
      required this.backActive,
      this.backText,
      this.backRoute,
      required this.forwardIsReview,
      this.forwardText,
      this.forwardRoute,
      this.forwardIsPublish})
      : super(key: key);

  final bool backActive;
  final String? backText;
  final String? backRoute;
  final bool forwardIsReview;
  final String? forwardText;
  final String? forwardRoute;
  final bool? forwardIsPublish;

  final _sideSpacing = 24.0;
  final _bottomSpacing = 32.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                _sideSpacing, 0, 0, _bottomSpacing),
            child: backActive
                ? ActiveLeftNavButton(
                    backText!,
                    backRoute!,
                  )
                : InactiveLeftNavButton(),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                0, 0, _sideSpacing, _bottomSpacing),
            child: forwardIsReview
                ? ReviewNavButton()
                : (forwardIsPublish != null && forwardIsPublish!)
                    ? PublishNavButton()
                    : RightNavButton(
                        forwardText!,
                        forwardRoute!,
                      ),
          ),
        ),
      ],
    );
  }
}

class RightNavButton extends StatelessWidget {
  const RightNavButton(
    this.forwardText,
    this.forwardRoute, {
    Key? key,
  }) : super(key: key);

  final String forwardText;
  final String forwardRoute;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () async {
          context.goNamed(forwardRoute);
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Next step:',
                    style: FlutterFlowTheme.of(context).bodyText2,
                  ),
                  Text(
                    forwardText,
                    style: FlutterFlowTheme.of(context).subtitle1.override(
                          fontFamily: 'Outfit',
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 48,
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewNavButton extends StatelessWidget {
  const ReviewNavButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.goNamed('planDrill-Review');
      },
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x33000000),
              offset: Offset(0, 3),
              spreadRadius: 2,
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Save & Review',
                    style: FlutterFlowTheme.of(context).subtitle1.override(
                          fontFamily: 'Outfit',
                          color: FlutterFlowTheme.of(context).primaryBtnText,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              color: FlutterFlowTheme.of(context).primaryBtnText,
              size: 48,
            ),
          ],
        ),
      ),
    );
  }
}

class ActiveLeftNavButton extends StatelessWidget {
  const ActiveLeftNavButton(
    this.backText,
    this.backRoute, {
    Key? key,
  }) : super(key: key);

  final String backText;
  final String backRoute;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () async {
        context.goNamed(backRoute);
      },
      child: Container(
        decoration: BoxDecoration(
          // color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              Icons.keyboard_arrow_left_rounded,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 48,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Previous step:',
                    style: FlutterFlowTheme.of(context).bodyText2.override(
                          fontFamily: 'Space Grotesk',
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                  ),
                  Text(
                    backText,
                    style: FlutterFlowTheme.of(context).subtitle1.override(
                          fontFamily: 'Outfit',
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                  ),
                ],
              ),
            ),
          ],
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
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.keyboard_arrow_left_rounded,
            color: FlutterFlowTheme.of(context).tertiaryColor,
            size: 48,
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Previous step:',
                  style: FlutterFlowTheme.of(context).bodyText2.override(
                        fontFamily: 'Space Grotesk',
                        color: FlutterFlowTheme.of(context).tertiaryColor,
                      ),
                ),
                Text(
                  '…',
                  style: FlutterFlowTheme.of(context).subtitle1.override(
                        fontFamily: 'Outfit',
                        color: FlutterFlowTheme.of(context).tertiaryColor,
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
        color: FlutterFlowTheme.of(context).primaryColor,
        boxShadow: [
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
        padding: EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
              child: Icon(
                Icons.cloud_upload_rounded,
                color: FlutterFlowTheme.of(context).primaryBtnText,
                size: 38,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 8, 0),
              child: Text(
                'Publish Drill',
                style: FlutterFlowTheme.of(context).title1.override(
                      fontFamily: 'Outfit',
                      color: FlutterFlowTheme.of(context).primaryBtnText,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
