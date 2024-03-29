import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../models/drill_plan.dart';

class WebNavBar extends StatefulWidget {
  const WebNavBar({
    Key? key,
    this.navBGOne,
    this.navColorOne,
    this.navBgTwo,
    this.navColorTwo,
    this.navBgThree,
    this.navColorThree,
    this.navBGFour,
    this.navColorFour,
    this.updateDashLeavingPlanDrill,
  }) : super(key: key);

  final Color? navBGOne;
  final Color? navColorOne;
  final Color? navBgTwo;
  final Color? navColorTwo;
  final Color? navBgThree;
  final Color? navColorThree;
  final Color? navBGFour;
  final Color? navColorFour;
  final Function()? updateDashLeavingPlanDrill;

  @override
  State<WebNavBar> createState() => _WebNavBarState();
}

class _WebNavBarState extends State<WebNavBar> {
  bool switchValue = false;
  String user = '';
  final _auth = FirebaseAuth.instanceFor(
    app: Firebase.app(),
    persistence: Persistence.INDEXED_DB,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          switchValue = Theme.of(context).brightness == Brightness.light;
        }));
    // initSwitchValue();
    setState(() {
      user = _auth.currentUser?.displayName ??
          _auth.currentUser?.email ??
          'Example Name';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
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
        padding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              padding: const EdgeInsetsDirectional.fromSTEB(6, 8, 4, 0),
              child: SelectionArea(
                  child: Text(
                'Evacuation Drill',
                textAlign: TextAlign.center,
                style: FFTheme.of(context).subtitle2.override(
                      fontFamily: 'Space Grotesk',
                      color: FFTheme.of(context).awesomeOrange,
                    ),
              )),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 4, 12),
              child: SelectionArea(
                  child: Text(
                'Console',
                textAlign: TextAlign.start,
                style: FFTheme.of(context).title2.override(
                      // fontFamily: 'Outfit',
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w700,
                      lineHeight: 1,
                      fontSize: 36,
                      letterSpacing: -0.2,
                      color: FFTheme.of(context).secondaryText,
                    ),
              )),
            ),
            Divider(
              height: 24,
              thickness: 2,
              color: FFTheme.of(context).lineColor,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
              child: InkWell(
                onTap: () async {
                  context.goNamed(
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
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: widget.navBGOne,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.edit_rounded,
                          color: widget.navColorOne,
                          size: 24,
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Text(
                            'Planned Drills',
                            style: FFTheme.of(context).bodyText2.override(
                                  fontFamily: 'Space Grotesk',
                                  color: widget.navColorOne,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
              child: InkWell(
                onTap: () async {
                  context.goNamed(
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
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: widget.navBgTwo,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.pending_actions_rounded,
                          color: widget.navColorTwo,
                          size: 24,
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Text(
                            'Published Drills',
                            style: FFTheme.of(context).bodyText2.override(
                                  fontFamily: 'Space Grotesk',
                                  color: widget.navColorTwo,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
              child: InkWell(
                onTap: () async {
                  context.goNamed(
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
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: widget.navBgThree,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.legend_toggle_rounded,
                          color: widget.navColorThree,
                          size: 24,
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Text(
                            'Completed Drills',
                            style: FFTheme.of(context).bodyText2.override(
                                  fontFamily: 'Space Grotesk',
                                  color: widget.navColorThree,
                                ),
                          ),
                        ),
                        if (responsiveVisibility(
                          context: context,
                          phone: false,
                          tablet: false,
                          tabletLandscape: false,
                          desktop: false,
                        ))
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: FFTheme.of(context).primaryColor,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 3,
                                  color: Color(0x33000000),
                                  offset: Offset(0, 1),
                                )
                              ],
                              shape: BoxShape.circle,
                            ),
                            alignment: const AlignmentDirectional(0, 0),
                            child: Text(
                              '3',
                              textAlign: TextAlign.center,
                              style: FFTheme.of(context).bodyText1.override(
                                    fontFamily: 'Space Grotesk',
                                    color: FFTheme.of(context).primaryBtnText,
                                  ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
              child: InkWell(
                onTap: () async {
                  context.goNamed(
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
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: widget.navBGFour,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.group_rounded,
                          color: widget.navColorFour,
                          size: 24,
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Text(
                            'Team Members',
                            style: FFTheme.of(context).bodyText2.override(
                                  fontFamily: 'Space Grotesk',
                                  color: widget.navColorFour,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Divider(
                      height: 12,
                      thickness: 2,
                      color: FFTheme.of(context).lineColor,
                    ),
                    // TODO: Make new drill button work again (MNDBWA, yikes)
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                      child: InkWell(
                        onTap: () async {
                          if (_auth.currentUser!.email == null) {
                            return;
                          }
                          await DrillPlan.newDrillPlan(
                            _auth.currentUser!.uid,
                            _auth.currentUser!.email!,
                          ).then(
                            (newDrillID) {
                              context.pushNamed(
                                'planDrill',
                                params: {'drillID': newDrillID},
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: const TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 0),
                                  ),
                                },
                              );
                              if (widget.updateDashLeavingPlanDrill != null) {
                                GoRouter.of(context).addListener(
                                    widget.updateDashLeavingPlanDrill!);
                              }
                            },
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FFTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12, 12, 12, 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.library_add_rounded,
                                  color: FFTheme.of(context).secondaryText,
                                  size: 24,
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: Text(
                                    'New Drill',
                                    style: FFTheme.of(context).bodyText2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 12,
                      thickness: 2,
                      color: FFTheme.of(context).lineColor,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: FFTheme.of(context).secondaryBackground,
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            12, 12, 12, 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                (Theme.of(context).brightness ==
                                        Brightness.light)
                                    ? const Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 6, 0, 6),
                                        child: Icon(
                                          Icons.wb_sunny_rounded,
                                          color: Color(0xFFD64C06),
                                          size: 24,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 6, 0, 6),
                                        child: Icon(
                                          Icons.brightness_2_outlined,
                                          color:
                                              FFTheme.of(context).secondaryText,
                                          size: 24,
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: Text(
                                    'Brightness',
                                    style: FFTheme.of(context).bodyText2,
                                  ),
                                ),
                              ],
                            ),
                            Switch(
                              value: switchValue,
                              onChanged: (newValue) {
                                setState(() {
                                  setDarkModeSetting(
                                      context,
                                      newValue
                                          ? ThemeMode.light
                                          : ThemeMode.dark);
                                  switchValue = newValue;
                                });
                              },
                              activeColor: const Color(0xFFD64C06),
                              inactiveTrackColor:
                                  FFTheme.of(context).tertiaryColor,
                              inactiveThumbColor:
                                  FFTheme.of(context).secondaryText,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 12,
                      thickness: 2,
                      color: FFTheme.of(context).lineColor,
                    ),
                    // User
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8.0),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // redo this with FF
                                  return AlertDialog(
                                    title: const Text('Sign out?'),
                                    // content: const Text(''),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text('Cancel')),
                                      TextButton(
                                          onPressed: () {
                                            // ignore: no_leading_underscores_for_local_identifiers

                                            _auth.signOut();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Sign Out'))
                                    ],
                                  );
                                });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg?20200418092106',
                                  width: 44,
                                  height: 44,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user,
                                        style: FFTheme.of(context).bodyText1,
                                      ),
                                      Text(
                                        'Admin',
                                        style: FFTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'Space Grotesk',
                                              fontSize: 12,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
