import 'package:flutter/material.dart';

import '../keys/keys_controller.dart';
import 'gen_key_controller.dart';
import '../view_key/view_key_dialog.dart';

/// Displays the controls for generating a new key (pair).
class GenKeyView extends StatefulWidget {
  const GenKeyView({super.key, required this.controller});

  static const routeName = '/genKey';
  static const title = 'Make a new key';

  final KeysController controller;

  @override
  State<GenKeyView> createState() => _GenKeyViewState();
}

class _GenKeyViewState extends State<GenKeyView> {
  late GenKeyController genKeyController = GenKeyController(widget.controller);
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GenKeyView.title,
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Center(
        child: SizedBox(
          height: 300,
          width: 400,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () async {
              if (!_loading) {
                setState(() {
                  _loading = true;
                });

                final newKeyMetaData = await genKeyController.generateKey();

                showDialog(
                    context: context,
                    builder: (context) => ViewKeyDialog(
                        thisKey: newKeyMetaData,
                        title: 'Generated Key: ${newKeyMetaData.keyName}'));
                setState(() {
                  _loading = false;
                });
              }
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                // color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: (!_loading)
                    ? [
                        const Icon(
                          Icons.add_rounded,
                          size: 300 * 8 / 15,
                        ),
                        Text(
                          GenKeyView.title,
                          style: Theme.of(context).textTheme.headlineSmall,
                        )
                      ]
                    : [
                        const SizedBox(
                          height: 300 * 8 / 15,
                          width: 300 * 8 / 15,
                          child: CircularProgressIndicator.adaptive(),
                        ),
                        Text(
                          'Generating new key…',
                          style: Theme.of(context).textTheme.headlineSmall,
                        )
                      ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
