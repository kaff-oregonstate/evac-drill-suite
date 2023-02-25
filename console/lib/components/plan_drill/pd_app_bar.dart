import 'package:evac_drill_console/flutter_flow/flutter_flow_theme.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_util.dart';
import 'package:evac_drill_console/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import '../../models/drill_plan.dart';
import '../../plan_drill/plan_drill_controller.dart';
import '../dashboard/publish_drill_plan_dialog.dart';

/// An app bar used for the Plan Drill and View Drill Plan pages.
class PDAppBar extends StatelessWidget {
  const PDAppBar({
    required this.planning,
    this.creator,
    this.pdController,
    this.drillPlan,
    this.refreshDrillPlan,
    super.key,
  });

  final bool planning;
  final bool? creator;
  final PDController? pdController;
  final DrillPlan? drillPlan;
  final Function? refreshDrillPlan;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'PDAppBarHeroTag',
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 64,
          color: FFTheme.of(context).primaryBackground,
          padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 12, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // back button and page title
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BackButton(
                    onPressed: (pdController != null &&
                            pdController!.unsavedChanges)
                        ? () {
                            showUnsavedChangesDialog(context, (thatContext) {
                              Navigator.of(thatContext).pop();
                              Navigator.of(thatContext).pop();
                            });
                          }
                        : () {
                            context.pop();
                          },
                    // default behavior
                    // : null,
                  ),
                  Text(
                    (planning) ? 'Plan Drill' : 'View Drill Plan',
                    style: FFTheme.of(context).title2,
                  ),
                ],
              ),
              // action buttons
              Row(
                mainAxisSize: MainAxisSize.max,
                children: (planning)
                    ? [
                        if (pdController != null &&
                            pdController!.unsavedChanges)
                          Text(
                            'unsaved changes     ',
                            style:
                                FFTheme.of(context).subtitle1.merge(TextStyle(
                                      color: FFTheme.of(context).secondaryText,
                                    )),
                          ),
                        // save changes button
                        if (pdController != null)
                          FFButtonWidget(
                            onPressed: () async {
                              if (pdController != null) {
                                await pdController!.syncChanges();
                              }
                            },
                            text: 'Save Changes',
                            icon: const Icon(
                              Icons.save_rounded,
                              size: 15,
                            ),
                            options: FFButtonOptions(
                              height: 40,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24, 0, 24, 0),
                              color: FFTheme.of(context).primaryColor,
                              textStyle: FFTheme.of(context).subtitle2.override(
                                    fontFamily: 'Space Grotesk',
                                    color: FFTheme.of(context).primaryBtnText,
                                  ),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        // review plan button
                        if (pdController != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                if (pdController!.unsavedChanges) {
                                  showUnsavedChangesDialog(
                                    context,
                                    (thatContext) {
                                      Navigator.of(thatContext).pop();
                                      thatContext.goNamed(
                                        'viewDrillPlan',
                                        params: {
                                          'drillID':
                                              pdController!.drillPlan.drillID
                                        },
                                        extra: {
                                          kTransitionInfoKey:
                                              const TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                            duration: Duration(milliseconds: 0),
                                          ),
                                        },
                                      );
                                    },
                                  );
                                } else {
                                  context.goNamed(
                                    'viewDrillPlan',
                                    params: {
                                      'drillID': pdController!.drillPlan.drillID
                                    },
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
                              text: 'Review',
                              icon: const Icon(
                                Icons.inventory_rounded,
                                size: 15,
                              ),
                              options: FFButtonOptions(
                                height: 40,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    8, 0, 8, 0),
                                color: FFTheme.of(context).tertiaryColor,
                                textStyle: FFTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Space Grotesk',
                                      color: FFTheme.of(context).primaryText,
                                    ),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                      ]
                    : [
                        if (creator != null && !creator! && drillPlan != null)
                          SelectableText(
                            'Drill creator: ${drillPlan!.creatorEmail}',
                            style:
                                FFTheme.of(context).subtitle1.merge(TextStyle(
                                      color: FFTheme.of(context).secondaryText,
                                    )),
                          ),
                        const SizedBox(width: 24),
                        // refresh drill plan button
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              if (refreshDrillPlan != null) {
                                await refreshDrillPlan!();
                              }
                            },
                            text: 'Refresh Drill Plan',
                            icon: const Icon(
                              Icons.refresh_rounded,
                              size: 15,
                            ),
                            options: FFButtonOptions(
                              height: 40,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  8, 0, 8, 0),
                              color: FFTheme.of(context).tertiaryColor,
                              textStyle: FFTheme.of(context).subtitle2.override(
                                    fontFamily: 'Space Grotesk',
                                    color: FFTheme.of(context).primaryText,
                                  ),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // published indicator
                        if (drillPlan != null && drillPlan!.published)
                          SelectableText(
                            'This drill is currently published. Invite Code: ${drillPlan!.inviteCode ?? '[error]'}',
                            style: FFTheme.of(context).subtitle1.merge(
                                  TextStyle(
                                    color: FFTheme.of(context).secondaryText,
                                  ),
                                ),
                          ),
                        // publish button
                        if (creator != null &&
                            creator! &&
                            drillPlan != null &&
                            !drillPlan!.published)
                          FFButtonWidget(
                            onPressed: () async {
                              // TODO: Implement Publish Button
                              showDialog(
                                context: context,
                                builder: (context) => PublishDrillDialog(
                                  drillPlan!.drillID,
                                  onSuccess: () {
                                    if (refreshDrillPlan != null) {
                                      refreshDrillPlan!();
                                    }
                                  },
                                ),
                              );
                            },
                            text: 'Publish Drill',
                            icon: const Icon(
                              Icons.cloud_upload_rounded,
                              size: 15,
                            ),
                            options: FFButtonOptions(
                              height: 40,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24, 0, 24, 0),
                              color: FFTheme.of(context).primaryColor,
                              textStyle: FFTheme.of(context).subtitle2.override(
                                    fontFamily: 'Space Grotesk',
                                    color: FFTheme.of(context).primaryBtnText,
                                  ),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),

                        /// no more delete button because it's a headache to do on the
                        /// planDrill page, and it's already implemented on the dashboard
                        // Padding(
                        //   padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                        //   child: FFButtonWidget(
                        //     onPressed: () async {
                        //       // context.pop();
                        //       if (pdController != null) {
                        //         showDialog(
                        //           context: context,
                        //           builder: (context) => ConfirmDeleteDrillPlanDialog(
                        //             pdController!.drillPlan,
                        //             FirebaseAuth.instanceFor(
                        //               app: Firebase.app(),
                        //               persistence: Persistence.INDEXED_DB,
                        //             ).currentUser!.uid,
                        //             showDialogHere,
                        //           ),
                        //         );
                        //       }
                        //     },
                        //     text: '',
                        //     icon: Icon(
                        //       Icons.delete_rounded,
                        //       color: FFTheme.of(context).secondaryText,
                        //       size: 15,
                        //     ),
                        //     options: FFButtonOptions(
                        //       height: 40,
                        //       padding:
                        //           const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                        //       color: FFTheme.of(context).tertiaryColor,
                        //       textStyle: FFTheme.of(context)
                        //           .subtitle2
                        //           .override(
                        //             fontFamily: 'Space Grotesk',
                        //             color: FFTheme.of(context).secondaryText,
                        //           ),
                        //       borderSide: const BorderSide(
                        //         color: Colors.transparent,
                        //         width: 1,
                        //       ),
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //   ),
                        // ),
                      ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showUnsavedChangesDialog(
      BuildContext context, Function(BuildContext) onDecision) {
    showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            icon: const Icon(Icons.warning_rounded),
            title: const Text(
                'Do you want to save the changes you made to this drill plan?'),
            content: const Text(
                'Your changes will be lost if you don\'t save them.'),
            actions: [
              TextButton(
                onPressed: () {
                  onDecision(context);
                },
                child: const Text('Don\'t Save'),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                      FFTheme.of(context).primaryBtnText),
                  backgroundColor: MaterialStateProperty.all(
                      FFTheme.of(context).primaryColor),
                ),
                onPressed: () {
                  pdController!.syncChanges();
                  onDecision(context);
                },
                child: const Text('Save'),
              ),
            ],
          )),
    );
  }
}
