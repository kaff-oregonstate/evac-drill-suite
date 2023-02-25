import 'package:evac_drill_console/nav/nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../models/drill_plan.dart';

class DePublishDrillDialog extends StatefulWidget {
  const DePublishDrillDialog(
    this.drillPlan, {
    this.onSuccess,
    super.key,
  });

  final DrillPlan drillPlan;
  final Function? onSuccess;

  @override
  State<DePublishDrillDialog> createState() => _DePublishDrillDialogState();
}

class _DePublishDrillDialogState extends State<DePublishDrillDialog> {
  bool _started = false;
  void setStarted([bool? val]) => setState(() => _started = val ?? !_started);
  bool _loading = true;
  void setLoading([bool? val]) => setState(() => _loading = val ?? !_loading);
  bool _success = false;
  void setSuccess([bool? val]) => setState(() => _success = val ?? !_success);

  final _auth = FirebaseAuth.instanceFor(
    app: Firebase.app(),
    persistence: Persistence.INDEXED_DB,
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: (!_started)
          ? const Icon(Icons.warning_rounded)
          : (_loading)
              ? null
              : (_success)
                  ? const Icon(Icons.check_circle_outline_rounded)
                  : const Icon(Icons.error_outline_outlined),
      title: (!_started)
          ? const Text('Please confirm: you want to DePublish this drill:')
          : (_loading)
              ? const Text('DePublishing drill…')
              : (_success)
                  ? const Text('Successfully DePublished drill')
                  : const Text('Failed to depublish drill'),
      content: (!_started)
          ? SelectionArea(
              child: Text(
              'Drill with title "${(widget.drillPlan.title == null || widget.drillPlan.title!.isEmpty) ? 'no title yet' : widget.drillPlan.title!}" and ID ${widget.drillPlan.drillID}\n\nThe Drill will be INACCESSIBLE to PARTICIPANTS, until Re-Published.\n\nAny invites sent to participants will have to be re-sent with the new invite code (after edits are complete and the Drill is Re-Published).',
              style: FFTheme.of(context).subtitle2.override(
                    fontFamily: 'Space Grotesk',
                    color: FFTheme.of(context).secondaryText,
                  ),
            ))
          : (_loading)
              ? const CircularProgressIndicator.adaptive()
              : (_success)
                  ? RichText(
                      text: TextSpan(
                        style: FFTheme.of(context).bodyText2,
                        children: [
                          TextSpan(
                            text:
                                'Drill has ID: `${widget.drillPlan.drillID}`\n\nGo to the ',
                          ),
                          TextSpan(
                            text: 'Planned Drills page',
                            style: FFTheme.of(context).bodyText2.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => context.goNamed('Dash_plannedDrills'),
                          ),
                          const TextSpan(
                            text: ' to see it in the collection,\nor ',
                          ),
                          TextSpan(
                            text: 'plan the drill right now',
                            style: FFTheme.of(context).bodyText2.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                WidgetsBinding.instance.addPostFrameCallback(
                                    (_) => context
                                            .pushNamed('planDrill', params: {
                                          'drillID': widget.drillPlan.drillID
                                        }));
                                Navigator.of(context).pop();
                              },
                          ),
                          const TextSpan(
                            text: '.',
                          ),
                        ],
                      ),
                    )
                  : const Text(
                      'An unexpected error occurred.\nPlease check network connectivity, and contact admin.'),
      actions: <Widget>[
        if (!_loading && !_started)
          TextButton(
            child: const Text('Nevermind…'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        if (_started && !_loading)
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        if (!_started)
          TextButton(
            style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(Colors.red.shade800)),
            child: const Text('Confirm, DePublish'),
            onPressed: () async {
              setLoading(true);
              setStarted(true);
              widget.drillPlan.depublish(_auth.currentUser!.uid).then((value) {
                if (mounted) {
                  setSuccess(value);
                  setLoading(false);
                  if (value) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Future.delayed(const Duration(milliseconds: 300)).then(
                          (value) => (widget.onSuccess != null)
                              ? widget.onSuccess!()
                              : null);
                    });
                  }
                }
              });
            },
          ),
      ],
    );
  }
}
