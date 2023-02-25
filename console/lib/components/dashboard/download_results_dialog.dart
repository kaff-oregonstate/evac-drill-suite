import 'package:flutter/material.dart';
import '../../models/drill_plan.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class DownloadResultsDialog extends StatefulWidget {
  const DownloadResultsDialog(this.drillPlan, this.userID, {super.key});

  final DrillPlan drillPlan;
  final String userID;

  @override
  State<DownloadResultsDialog> createState() => _DownloadResultsDialogState();
}

class _DownloadResultsDialogState extends State<DownloadResultsDialog> {
  bool _started = false;
  void setStarted([bool? val]) => setState(() => _started = val ?? !_started);
  bool _loading = true;
  void setLoading([bool? val]) => setState(() => _loading = val ?? !_loading);
  bool _success = false;
  void setSuccess([bool? val]) => setState(() => _success = val ?? !_success);

  void downloadResults() {
    setStarted(true);
    widget.drillPlan.accessResults(widget.userID).then((zipURL) {
      if (zipURL != null) {
        // prompt download in user's web browser
        html.AnchorElement(href: zipURL)
          ..setAttribute(
              'download', 'DrillResults-${widget.drillPlan.drillID}.zip')
          ..click();
        setSuccess(true);
        setLoading(false);
      } else {
        // FIXME: Error handling on accessResults failure
        // ignore: avoid_print
        print(
            'accessResults on drill with ID ${widget.drillPlan.drillID} failed');
        setLoading(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.download_rounded),
      title: (!_started)
          ? Text('Download results for "${widget.drillPlan.title}"')
          : (_loading)
              ? const Text('Downloading drill results…')
              : (_success)
                  ? const Text('Successful results download')
                  : const Text(
                      'Failed to download results, try again or contact admin'),
      content: (!_started)
          ? ElevatedButton(
              onPressed: () => downloadResults(),
              child: const Text('Start Download'))
          : (_loading)
              ? const CircularProgressIndicator.adaptive()
              : null,
      actions: <Widget>[
        if (_started && !_loading)
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
      ],
    );
  }
}
