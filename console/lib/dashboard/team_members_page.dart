import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evac_drill_console/components/dashboard/d_refresh_button.dart';
import 'package:evac_drill_console/components/web_nav_bar.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_widgets.dart';
import 'package:evac_drill_console/screen_too_small/show_notice_on_small.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../app_state.dart';
import '../components/dashboard/requesting_access_card.dart';
import '../models/evac_drill_user.dart';

class TeamMembersPage extends StatefulWidget {
  const TeamMembersPage({super.key});

  @override
  State<TeamMembersPage> createState() => _TeamMembersPageState();
}

class _TeamMembersPageState extends State<TeamMembersPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _requestedAccessScrollControl = ScrollController();
  final ScrollController _usersScrollControl = ScrollController();
  TextEditingController emailController = TextEditingController();

  final _auth = FirebaseAuth.instanceFor(
    app: Firebase.app(),
    persistence: Persistence.INDEXED_DB,
  );

  bool _loadingReqAccesses = true;

  List<Map<String, dynamic>> reqAccesses = [];

  void setReqAccessLoading([bool? val]) {
    if (mounted) {
      setState(() => _loadingReqAccesses = val ?? !_loadingReqAccesses);
    }
  }

  bool _loadingUsers = true;

  List<EvacDrillUser> users = [];

  void setUsersLoading([bool? val]) {
    if (mounted) {
      setState(() => _loadingUsers = val ?? !_loadingUsers);
    }
  }

  @override
  void initState() {
    super.initState();

    refreshReqAccesses();
    refreshUsers();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _requestedAccessScrollControl.dispose();
    _usersScrollControl.dispose();
    emailController.dispose();
  }

  Future<void> refreshReqAccesses() async {
    setReqAccessLoading(true);

    reqAccesses = [];

    // get the relevant documents from firestore
    final reqAccessCol =
        FirebaseFirestore.instance.collection('RequestedAccess');
    final reqAccessDocs = await reqAccessCol.get();

    // consume the documents, populating the local DrillPlans
    for (final snap in reqAccessDocs.docs) {
      Map<String, dynamic> thisReqAccess = snap.data();
      thisReqAccess['docID'] = snap.id;
      if (mounted) {
        setState(() => reqAccesses.add(thisReqAccess));
      }
    }

    // setState sort reqAccesses by ??

    setReqAccessLoading();
    return;
  }

  Future<void> refreshUsers() async {
    setUsersLoading(true);

    users = [];

    // get the relevant documents from firestore
    final usersCol = FirebaseFirestore.instance.collection('User');
    final userDocs = await usersCol.get();

    // consume the documents, populating the local DrillPlans
    for (final snap in userDocs.docs) {
      final thisUser = EvacDrillUser.fromDoc(snap);
      if (mounted) {
        setState(() => users.add(thisUser));
      }
    }

    // setState sort users by ??

    setUsersLoading();
    return;
  }

  @override
  Widget build(BuildContext context) {
    void showDialogHere(Widget dialog) {
      showDialog(context: context, builder: ((context) => dialog));
    }

    return ShowNoticeOnSmall(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FFTheme.of(context).primaryBackground,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              // web nav bar
              Stack(
                children: [
                  // if (false)
                  //   WebNavBarCollapsed(
                  //     navBGOne: FFTheme.of(context).tertiaryColor,
                  //     navColorOne: FFTheme.of(context).primaryText,
                  //     navBgTwo:
                  //         FFTheme.of(context).secondaryBackground,
                  //     navColorTwo: FFTheme.of(context).secondaryText,
                  //     navBgThree:
                  //         FFTheme.of(context).secondaryBackground,
                  //     navColorThree: FFTheme.of(context).secondaryText,
                  //     navBGFour:
                  //         FFTheme.of(context).secondaryBackground,
                  //     navColorFour: FFTheme.of(context).secondaryText,
                  //   ),
                  if (true)
                    WebNavBar(
                      navBGOne: FFTheme.of(context).secondaryBackground,
                      navColorOne: FFTheme.of(context).secondaryText,
                      navBgTwo: FFTheme.of(context).secondaryBackground,
                      navColorTwo: FFTheme.of(context).secondaryText,
                      navBgThree: FFTheme.of(context).secondaryBackground,
                      navColorThree: FFTheme.of(context).secondaryText,
                      navBGFour: FFTheme.of(context).primaryBackground,
                      navColorFour: FFTheme.of(context).primaryText,
                    ),
                ],
              ),
              // dashboard body
              Expanded(
                  child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FFTheme.of(context).primaryBackground,
                ),
                padding:
                    const EdgeInsetsDirectional.fromSTEB(24 + 4, 24, 24, 24),
                // main dashboard content
                child: Column(
                  children: [
                    // add new user by email
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: FFTheme.of(context).secondaryBackground,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x2B090F13),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // title bar
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      8, 12, 8, 8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // title text
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Text(
                                          'Invite New User by Email',
                                          style: FFTheme.of(context).title2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // textfield and buttons go here
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: TextField(
                                          controller: emailController,
                                          decoration: const InputDecoration(
                                            hintText: 'Email',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      DefaultFFButton(
                                        'send invite',
                                        () async {
                                          // send sign-in link
                                          var acs = ActionCodeSettings(
                                            // URL must be whitelisted in the Firebase Console.
                                            url: FFAppState.deploymentUrl,
                                            handleCodeInApp: true,
                                          );
                                          try {
                                            await _auth.sendSignInLinkToEmail(
                                              email: emailController.text,
                                              actionCodeSettings: acs,
                                            );

                                            showDialogHere(AlertDialog(
                                              title: Text(
                                                  'Sent sign-in link to ${emailController.text}'),
                                              actions: [
                                                TextButton(
                                                  child: const Text('Ok'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            ));
                                            emailController.clear();
                                          } catch (e) {
                                            showDialogHere(AlertDialog(
                                              title: Text(
                                                  'Failed to send sign-in link to ${emailController.text}'),
                                              content: Text('Error: $e'),
                                              actions: [
                                                TextButton(
                                                  child: const Text('Ok'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            ));
                                          }
                                        },
                                        width: 300,
                                        icon: Icon(
                                          Icons.send_rounded,
                                          color: FFTheme.of(context)
                                              .primaryBtnText,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // requesting access
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: FFTheme.of(context).secondaryBackground,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x2B090F13),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // title bar
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    8, 12, 8, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // title text
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: Text(
                                            'New Users Requesting Access',
                                            style: FFTheme.of(context).title2,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 6),
                                          child: Text(
                                            '(${reqAccesses.length.toString()})',
                                            style: FFTheme.of(context)
                                                .subtitle2
                                                .override(
                                                  fontFamily: 'Space Grotesk',
                                                  color: FFTheme.of(context)
                                                      .secondaryText,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // title buttons
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        DRefreshButton(onTap: () {
                                          refreshReqAccesses();
                                        }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // drill plan cards
                              Expanded(
                                child: (_loadingReqAccesses)
                                    ? const Center(
                                        child: CircularProgressIndicator
                                            .adaptive())
                                    : (reqAccesses.isEmpty)
                                        ? Center(
                                            child: Text(
                                              'No users requesting access at this time',
                                              style: FFTheme.of(context)
                                                  .subtitle2
                                                  .override(
                                                    fontFamily: 'Space Grotesk',
                                                    color: FFTheme.of(context)
                                                        .secondaryText,
                                                  ),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 1,
                                              horizontal: 248,
                                            ),
                                            child: Scrollbar(
                                              controller:
                                                  _requestedAccessScrollControl,
                                              thumbVisibility: true,
                                              child: ListView.builder(
                                                controller:
                                                    _requestedAccessScrollControl,
                                                itemCount: reqAccesses.length,
                                                itemBuilder: (context, index) {
                                                  return RequestingAccessCard(
                                                    index,
                                                    reqAccesses[index],
                                                    refreshReqAccesses,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // current users
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: FFTheme.of(context).secondaryBackground,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x2B090F13),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // title bar
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    8, 12, 8, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // title text
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: Text(
                                            'Current Users',
                                            style: FFTheme.of(context).title2,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 6),
                                          child: Text(
                                            '(${users.length.toString()})',
                                            style: FFTheme.of(context)
                                                .subtitle2
                                                .override(
                                                  fontFamily: 'Space Grotesk',
                                                  color: FFTheme.of(context)
                                                      .secondaryText,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // title buttons
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        DRefreshButton(onTap: () {
                                          refreshUsers();
                                        }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // drill plan cards
                              Expanded(
                                child: (_loadingUsers)
                                    ? const Center(
                                        child: CircularProgressIndicator
                                            .adaptive())
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 1,
                                          horizontal: 248,
                                        ),
                                        child: Scrollbar(
                                          controller: _usersScrollControl,
                                          thumbVisibility: true,
                                          child: ListView.builder(
                                            controller: _usersScrollControl,
                                            itemCount: users.length,
                                            itemBuilder: (context, index) {
                                              return Material(
                                                color: Colors.transparent,
                                                child: ListTile(
                                                  title:
                                                      Text(users[index].email),
                                                  tileColor: (index % 2 == 0)
                                                      ? null
                                                      : FFTheme.of(context)
                                                          .primaryBackground,
                                                ),
                                              );
                                            },
                                          ),
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
              )),
            ],
          ),
        ),
      ),
    );
  }
}
