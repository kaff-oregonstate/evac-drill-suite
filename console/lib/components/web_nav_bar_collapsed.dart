import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

// HACK: This collapsed version should be contained within the WebNavBar Widget.

class WebNavBarCollapsed extends StatefulWidget {
  const WebNavBarCollapsed({
    Key? key,
    this.navBGOne,
    this.navColorOne,
    this.navBgTwo,
    this.navColorTwo,
    this.navBgThree,
    this.navColorThree,
    this.navBGFour,
    this.navColorFour,
  }) : super(key: key);

  final Color? navBGOne;
  final Color? navColorOne;
  final Color? navBgTwo;
  final Color? navColorTwo;
  final Color? navBgThree;
  final Color? navColorThree;
  final Color? navBGFour;
  final Color? navColorFour;

  @override
  State<WebNavBarCollapsed> createState() => _WebNavBarCollapsedState();
}

class _WebNavBarCollapsedState extends State<WebNavBarCollapsed> {
  bool? switchValue;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      height: double.infinity,
      decoration: BoxDecoration(
        color: FFTheme.of(context).secondaryBackground,
        boxShadow: const [
          BoxShadow(
            blurRadius: 3,
            color: Color(0x33000000),
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/evacuationDrillParticipationAppThumbnail.png',
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Divider(
              height: 24,
              thickness: 2,
              color: FFTheme.of(context).lineColor,
            ),
            // if (false)
            //   Padding(
            //     padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
            //     child: SvgPicture.asset(
            //       'assets/images/OSU_transparent_horizontal_1C_W.svg',
            //       fit: BoxFit.fitWidth,
            //     ),
            //   ),
            // if (false)
            //   Divider(
            //     height: 24,
            //     thickness: 2,
            //     color: FFTheme.of(context).lineColor,
            //   ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
              child: InkWell(
                onTap: () async {
                  context.pushNamed(
                    'Dash_plannedDrills',
                    extra: <String, dynamic>{
                      kTransitionInfoKey: const TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.fade,
                        duration: Duration(milliseconds: 0),
                      ),
                    },
                  );
                },
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: widget.navBGOne,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.edit_rounded,
                    color: widget.navColorOne,
                    size: 24,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
              child: InkWell(
                onTap: () async {
                  context.pushNamed(
                    'Dash_publishedDrills',
                    extra: <String, dynamic>{
                      kTransitionInfoKey: const TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.fade,
                        duration: Duration(milliseconds: 0),
                      ),
                    },
                  );
                },
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: widget.navBgTwo,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.pending_actions_rounded,
                    color: widget.navColorTwo,
                    size: 24,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
              child: InkWell(
                onTap: () async {
                  context.pushNamed(
                    'Dash_completedDrills',
                    extra: <String, dynamic>{
                      kTransitionInfoKey: const TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.fade,
                        duration: Duration(milliseconds: 0),
                      ),
                    },
                  );
                },
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: widget.navBgThree,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.legend_toggle_rounded,
                    color: widget.navColorThree,
                    size: 24,
                  ),
                ),
              ),
            ),
            Divider(
              height: 24,
              thickness: 2,
              color: FFTheme.of(context).lineColor,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
              child: InkWell(
                onTap: () async {
                  context.pushNamed(
                    'Dash_teamMembersPage',
                    extra: <String, dynamic>{
                      kTransitionInfoKey: const TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.fade,
                        duration: Duration(milliseconds: 0),
                      ),
                    },
                  );
                },
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: widget.navBGFour,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.group_rounded,
                    color: widget.navColorFour,
                    size: 24,
                  ),
                ),
              ),
            ),
            Divider(
              height: 24,
              thickness: 2,
              color: FFTheme.of(context).lineColor,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Divider(
                      height: 24,
                      thickness: 2,
                      color: FFTheme.of(context).lineColor,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                      child: InkWell(
                        onTap: () async {
                          // TODO: duplicate some drill or add doc to firebase
                          const drillID = '';
                          // then:
                          context.pushNamed(
                            'planDrill',
                            params: {'drillID': drillID},
                            // TODO: Evaluate where to use this transition info
                            extra: <String, dynamic>{
                              kTransitionInfoKey: const TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.fade,
                                duration: Duration(milliseconds: 0),
                              ),
                            },
                          );
                        },
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: FFTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.library_add_rounded,
                            color: FFTheme.of(context).secondaryText,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 24,
                      thickness: 2,
                      color: FFTheme.of(context).lineColor,
                    ),
                    (Theme.of(context).brightness == Brightness.light)
                        ? const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
                            child: Icon(
                              Icons.wb_sunny_rounded,
                              color: Color(0xFFD64C06),
                              size: 24,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 6, 0, 0),
                            child: Icon(
                              Icons.brightness_2_outlined,
                              color: FFTheme.of(context).secondaryText,
                              size: 24,
                            ),
                          ),
                    Switch(
                      value: switchValue ?? false,
                      onChanged: (newValue) {
                        setState(() {
                          setDarkModeSetting(context,
                              newValue ? ThemeMode.light : ThemeMode.dark);
                          switchValue = newValue;
                        });
                      },
                      activeColor: const Color(0xFFD64C06),
                    ),
                    Divider(
                      height: 24,
                      thickness: 2,
                      color: FFTheme.of(context).lineColor,
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              'assets/images/wang_000.jpg',
                              width: 44,
                              height: 44,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
