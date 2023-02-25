import 'package:evac_drill_cryptography/src/view_key/view_key_dialog.dart';
import 'package:flutter/material.dart';

import '../keys/keys_controller.dart';

/// Displays the controls for importing a new private key from disk.
class ViewKeysView extends StatelessWidget {
  const ViewKeysView({super.key, required this.controller});

  static const routeName = '/viewKeys';
  static const title = 'View keys';

  final KeysController controller;

  @override
  Widget build(BuildContext context) {
    List<TableRow> rows = [
      TableRow(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'keyname',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'times used',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Center(
          child: Text(
            'details',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ]),
    ];
    bool altHighlight = true;
    for (final thisKey in controller.keys) {
      rows.add(TableRow(
        children: [
          // key title
          Container(
            color: (altHighlight) ? Colors.black26 : null,
            // ~ * ~ m a g i c   n u m b e r s ~ * ~
            padding: const EdgeInsets.all(14.0),
            child: Text(
              thisKey.keyName,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          // times used
          Container(
            color: (altHighlight) ? Colors.black26 : null,
            // ~ * ~ m a g i c   n u m b e r s ~ * ~
            padding: const EdgeInsets.all(14.0),
            child: Text(
              thisKey.timesUsed.toString(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          // view buton
          Container(
            color: (altHighlight) ? Colors.black26 : null,
            // ~ * ~ m a g i c   n u m b e r s ~ * ~
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: const Text('view'),
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) => ViewKeyDialog(
                      thisKey: thisKey,
                      title: 'Viewing key: ${thisKey.keyName}')),
            ),
          ),
        ],
      ));
      altHighlight = !altHighlight;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 14,
                ),
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: const <int, TableColumnWidth>{
                    0: IntrinsicColumnWidth(),
                    1: IntrinsicColumnWidth(),
                    2: FixedColumnWidth(96),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: rows,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
