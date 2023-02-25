import 'package:evac_drill_console/nav/nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../models/drill_plan.dart';
import '../../models/missing_plan_param.dart';

class PublishDrillDialog extends StatefulWidget {
  const PublishDrillDialog(
    this.drillID, {
    this.onSuccess,
    super.key,
  });

  final String drillID;
  final Function? onSuccess;

  @override
  State<PublishDrillDialog> createState() => _PublishDrillDialogState();
}

class _PublishDrillDialogState extends State<PublishDrillDialog> {
  DrillPlan? drillPlan;

  bool _loading = true;
  void setLoading([bool? val]) => setState(() => _loading = val ?? !_loading);
  bool _readyyy = false;
  void setReadyyy([bool? val]) => setState(() => _readyyy = val ?? !_readyyy);
  bool _started = false;
  void setStarted([bool? val]) => setState(() => _started = val ?? !_started);
  bool _pubbing = true;
  void setPubbing([bool? val]) => setState(() => _pubbing = val ?? !_pubbing);
  bool _success = false;
  void setSuccess([bool? val]) => setState(() => _success = val ?? !_success);

  final _auth = FirebaseAuth.instanceFor(
    app: Firebase.app(),
    persistence: Persistence.INDEXED_DB,
  );

  List<MissingPlanParam> missingParams = [];
  String? invalidBecause;

  @override
  void initState() {
    super.initState();
    checkIfDrillReadyyy();
  }

  // void refreshDrillPlan() async {
  //   drillPlan = await DrillPlan.fromDrillID(widget.drillID);
  //   setState(() {});
  // }

  void checkIfDrillReadyyy() async {
    drillPlan = await DrillPlan.fromDrillID(widget.drillID);
    if (mounted && drillPlan != null) {
      setState(() => missingParams = drillPlan!.paramsMissing());
      if (missingParams.isNotEmpty) {
        setLoading(false);
        return;
      }
      try {
        drillPlan!.validate();
        setReadyyy(true);
      } catch (e) {
        setState(() => invalidBecause = e.toString());
      }
      setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: (_loading)
          ? null
          : (!_started)
              ? (_readyyy)
                  ? const Icon(Icons.publish_rounded)
                  : const Icon(Icons.error_outline_outlined)
              : (_pubbing)
                  ? null
                  : (_success)
                      ? const Icon(Icons.check_circle_outline_rounded)
                      : const Icon(Icons.error_outline_outlined),
      title: (_loading)
          ? const Text('Determining if drill is ready for publishing…')
          : (!_started)
              ? (_readyyy)
                  ? const Text(
                      'Drill is ready, Please confirm you want to Publish:')
                  : const Text('Drill is not ready for publishing:')
              : (_pubbing)
                  ? const Text('Publishing drill…')
                  : (_success)
                      ? const Text('Successfully published drill')
                      : const Text('Failed to publish drill'),
      content: (_loading)
          ? const CircularProgressIndicator.adaptive()
          : (!_started)
              ? (_readyyy)
                  ? Text(
                      'Drill with title "${drillPlan!.title!}" and ID ${drillPlan!.drillID}')
                  : (missingParams.isNotEmpty)
                      ? MissingParamsRundown(missingParams)
                      : InvalidRundown(invalidBecause ??
                          'Drill is invalid due to unknown internal error')
              : (_pubbing)
                  ? const CircularProgressIndicator.adaptive()
                  : (_success)
                      ? RichText(
                          text: TextSpan(
                            style: FFTheme.of(context).bodyText2,
                            children: [
                              const TextSpan(
                                text: 'Go to the ',
                              ),
                              TextSpan(
                                text: 'Published Drills page',
                                style: FFTheme.of(context).bodyText2.copyWith(
                                      // color: FFTheme.of(context)
                                      //     .primaryText,
                                      decoration: TextDecoration.underline,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      context.goNamed('Dash_publishedDrills'),
                              ),
                              const TextSpan(
                                text: ' to view the invite code.',
                              ),
                            ],
                          ),
                        )
                      : const Text(
                          'An unexpected error occurred.\nPlease check network connectivity, and contact admin.'),
      actions: <Widget>[
        if (!_loading && !_started)
          TextButton(
            child: Text((_readyyy) ? 'Nevermind…' : 'Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        if (_started && !_pubbing)
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        if (!_loading && _readyyy && !_started)
          TextButton(
            style: ButtonStyle(
                foregroundColor:
                    MaterialStatePropertyAll(Colors.green.shade700)),
            child: const Text('Confirm, Publish'),
            onPressed: () async {
              setPubbing(true);
              setStarted(true);
              drillPlan!.publish(_auth.currentUser!.uid).then((value) {
                if (mounted) {
                  setSuccess(value);
                  setPubbing(false);
                  if (value) {
                    // refreshDrillPlan();
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

class InvalidRundown extends StatelessWidget {
  const InvalidRundown(this.invalidBecause, {super.key});

  final String invalidBecause;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('The current drill plan is invalid because:'),
          const SizedBox(height: 10),
          Text(invalidBecause),
        ],
      ),
    );
  }
}

class MissingParamsRundown extends StatelessWidget {
  const MissingParamsRundown(this.missingParams, {super.key});

  final List<MissingPlanParam> missingParams;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('The following parameters are empty or missing:'),
          const SizedBox(height: 10),
          for (final param in missingParams) Text(param.field),
        ],
      ),
    );
  }
}
