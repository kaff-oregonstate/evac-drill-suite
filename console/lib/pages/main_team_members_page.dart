import 'package:evac_drill_console/components/web_nav_bar.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_util.dart';
import 'package:evac_drill_console/screen_too_small/show_notice_on_small.dart';
// HACK: content in this ⬇️ file that needs to be moved
import 'package:evac_drill_console/pages/sign_in_page.dart';
import 'package:flutter/material.dart';

class MainTeamMembersPage extends StatefulWidget {
  const MainTeamMembersPage({Key? key}) : super(key: key);

  @override
  State<MainTeamMembersPage> createState() => _MainTeamMembersPageState();
}

class _MainTeamMembersPageState extends State<MainTeamMembersPage> {
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShowNoticeOnSmall(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     context.pushNamed(
        //       'addTeamMembers',
        //       extra: <String, dynamic>{
        //         kTransitionInfoKey: const TransitionInfo(
        //           hasTransition: true,
        //           transitionType: PageTransitionType.bottomToTop,
        //           duration: Duration(milliseconds: 250),
        //         ),
        //       },
        //     );
        //   },
        //   backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        //   elevation: 8,
        //   child: const Icon(
        //     Icons.add_rounded,
        //     color: Colors.white,
        //     size: 36,
        //   ),
        // ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (responsiveVisibility(
                context: context,
                phone: false,
              ))
                WebNavBar(
                  navBGOne: FlutterFlowTheme.of(context).secondaryBackground,
                  navColorOne: FlutterFlowTheme.of(context).secondaryText,
                  navBgTwo: FlutterFlowTheme.of(context).secondaryBackground,
                  navColorTwo: FlutterFlowTheme.of(context).secondaryText,
                  navBgThree: FlutterFlowTheme.of(context).secondaryBackground,
                  navColorThree: FlutterFlowTheme.of(context).secondaryText,
                  navBGFour: FlutterFlowTheme.of(context).primaryBackground,
                  navColorFour: FlutterFlowTheme.of(context).primaryText,
                ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title, searchbar
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (responsiveVisibility(
                            context: context,
                            tablet: false,
                            tabletLandscape: false,
                            desktop: false,
                          ))
                            Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 12, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                if (responsiveVisibility(
                                  context: context,
                                  phone: false,
                                ))
                                  Text(
                                    'My Team',
                                    style: FlutterFlowTheme.of(context).title2,
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          // if (responsiveVisibility(
                          //   context: context,
                          //   tablet: false,
                          //   tabletLandscape: false,
                          //   desktop: false,
                          // ))
                          //   Padding(
                          //     padding: const EdgeInsetsDirectional.fromSTEB(
                          //         16, 0, 16, 4),
                          //     child: Row(
                          //       mainAxisSize: MainAxisSize.max,
                          //       children: [
                          //         Padding(
                          //           padding:
                          //               const EdgeInsetsDirectional.fromSTEB(
                          //                   0, 0, 12, 0),
                          //           child: InkWell(
                          //             onTap: () async {
                          //               scaffoldKey.currentState!.openDrawer();
                          //             },
                          //             child: const UserCardWidget(),
                          //           ),
                          //         ),
                          //         Text(
                          //           'My Team',
                          //           style: FlutterFlowTheme.of(context).title2,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // Padding(
                          //   padding: const EdgeInsetsDirectional.fromSTEB(
                          //       16, 8, 16, 12),
                          //   child: Row(
                          //     mainAxisSize: MainAxisSize.max,
                          //     children: [
                          //       Expanded(
                          //         child: TextFormField(
                          //           controller: textController,
                          //           onChanged: (_) => EasyDebounce.debounce(
                          //             'textController',
                          //             const Duration(milliseconds: 2000),
                          //             () => setState(() {}),
                          //           ),
                          //           autofocus: true,
                          //           obscureText: false,
                          //           decoration: InputDecoration(
                          //             labelText: 'Search members...',
                          //             labelStyle: FlutterFlowTheme.of(context)
                          //                 .bodyText2,
                          //             enabledBorder: OutlineInputBorder(
                          //               borderSide: const BorderSide(
                          //                 color: Color(0x00000000),
                          //                 width: 1,
                          //               ),
                          //               borderRadius: BorderRadius.circular(12),
                          //             ),
                          //             focusedBorder: OutlineInputBorder(
                          //               borderSide: const BorderSide(
                          //                 color: Color(0x00000000),
                          //                 width: 1,
                          //               ),
                          //               borderRadius: BorderRadius.circular(12),
                          //             ),
                          //             errorBorder: OutlineInputBorder(
                          //               borderSide: const BorderSide(
                          //                 color: Color(0x00000000),
                          //                 width: 1,
                          //               ),
                          //               borderRadius: BorderRadius.circular(12),
                          //             ),
                          //             focusedErrorBorder: OutlineInputBorder(
                          //               borderSide: const BorderSide(
                          //                 color: Color(0x00000000),
                          //                 width: 1,
                          //               ),
                          //               borderRadius: BorderRadius.circular(12),
                          //             ),
                          //             filled: true,
                          //             fillColor: FlutterFlowTheme.of(context)
                          //                 .secondaryBackground,
                          //           ),
                          //           style:
                          //               FlutterFlowTheme.of(context).bodyText1,
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsetsDirectional.fromSTEB(
                          //             12, 0, 0, 0),
                          //         child: FlutterFlowIconButton(
                          //           borderColor: Colors.transparent,
                          //           borderRadius: 30,
                          //           borderWidth: 1,
                          //           buttonSize: 44,
                          //           icon: Icon(
                          //             Icons.search_rounded,
                          //             color: FlutterFlowTheme.of(context)
                          //                 .primaryText,
                          //             size: 24,
                          //           ),
                          //           onPressed: () {
                          //             print('IconButton pressed ...');
                          //           },
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    const ManageTeamDemo(),
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

// Find members title
                    // Padding(
                    //   padding:
                    //       const EdgeInsetsDirectional.fromSTEB(24, 8, 0, 0),
                    //   child: Text(
                    //     'Find Members',
                    //     style: FlutterFlowTheme.of(context).bodyText2,
                    //   ),
                    // ),
                    // Padding(
                    //   padding:
                    //       const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 44),
                    //   child: ListView(
                    //     padding: EdgeInsets.zero,
                    //     primary: false,
                    //     shrinkWrap: true,
                    //     scrollDirection: Axis.vertical,
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsetsDirectional.fromSTEB(
                    //             16, 4, 16, 8),
                    //         child: Container(
                    //           width: 400,
                    //           height: 60,
                    //           decoration: BoxDecoration(
                    //             color: FlutterFlowTheme.of(context)
                    //                 .secondaryBackground,
                    //             boxShadow: const [
                    //               BoxShadow(
                    //                 blurRadius: 4,
                    //                 color: Color(0x32000000),
                    //                 offset: Offset(0, 2),
                    //               )
                    //             ],
                    //             borderRadius: BorderRadius.circular(8),
                    //             border: Border.all(
                    //               color: FlutterFlowTheme.of(context)
                    //                   .primaryBackground,
                    //               width: 1,
                    //             ),
                    //           ),
                    //           child: Padding(
                    //             padding: const EdgeInsetsDirectional.fromSTEB(
                    //                 8, 0, 8, 0),
                    //             child: Row(
                    //               mainAxisSize: MainAxisSize.max,
                    //               mainAxisAlignment: MainAxisAlignment.start,
                    //               children: [
                    //                 ClipRRect(
                    //                   borderRadius: BorderRadius.circular(26),
                    //                   child: Image.network(
                    //                     'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
                    //                     width: 36,
                    //                     height: 36,
                    //                     fit: BoxFit.cover,
                    //                   ),
                    //                 ),
                    //                 Padding(
                    //                   padding:
                    //                       const EdgeInsetsDirectional.fromSTEB(
                    //                           12, 0, 0, 0),
                    //                   child: Column(
                    //                     mainAxisSize: MainAxisSize.max,
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.center,
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.start,
                    //                     children: [
                    //                       Text(
                    //                         'Username',
                    //                         style: FlutterFlowTheme.of(context)
                    //                             .subtitle2,
                    //                       ),
                    //                       Padding(
                    //                         padding: const EdgeInsetsDirectional
                    //                             .fromSTEB(0, 4, 0, 0),
                    //                         child: Text(
                    //                           'user@domainname.com',
                    //                           style:
                    //                               FlutterFlowTheme.of(context)
                    //                                   .bodyText2,
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
