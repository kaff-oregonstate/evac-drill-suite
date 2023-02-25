import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../models/drill_plan.dart';

class ConfirmDeleteDrillPlanDialog extends StatefulWidget {
  const ConfirmDeleteDrillPlanDialog(
    this.drillPlan, {
    this.onSuccess,
    super.key,
  });

  final DrillPlan drillPlan;
  final Function? onSuccess;

  @override
  State<ConfirmDeleteDrillPlanDialog> createState() =>
      _ConfirmDeleteDrillPlanDialogState();
}

class _ConfirmDeleteDrillPlanDialogState
    extends State<ConfirmDeleteDrillPlanDialog> {
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
          ? const Text('Please confirm: you want to delete this drill:')
          : (_loading)
              ? const Text('Deleting drill…')
              : (_success)
                  ? const Text('Successfully deleted drill')
                  : const Text('Failed to delete drill'),
      content: (!_started)
          ? SelectionArea(
              child: Text(
              'Drill with title "${(widget.drillPlan.title == null || widget.drillPlan.title!.isEmpty) ? 'no title yet' : widget.drillPlan.title!}" and ID ${widget.drillPlan.drillID}',
              style: FFTheme.of(context).subtitle2.override(
                    fontFamily: 'Space Grotesk',
                    color: FFTheme.of(context).secondaryText,
                  ),
            ))
          : (_loading)
              ? const CircularProgressIndicator.adaptive()
              : (_success)
                  ? null
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
            child: const Text('Confirm, Delete'),
            onPressed: () async {
              setLoading(true);
              setStarted(true);
              widget.drillPlan.delete(_auth.currentUser!.uid).then((value) {
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
