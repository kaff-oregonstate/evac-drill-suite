import 'package:file_picker/file_picker.dart';

import '../keys/key_meta_data.dart';
import 'add_key_controller.dart';
import '../view_key/view_key_dialog.dart';
import 'package:flutter/material.dart';

import '../keys/keys_controller.dart';

/// Displays the controls for importing a new key from disk
class AddKeyView extends StatefulWidget {
  const AddKeyView({super.key, required this.controller});

  static const routeName = '/addKey';
  static const title = 'Add key from disk';

  final KeysController controller;

  @override
  State<AddKeyView> createState() => _AddKeyViewState();
}

class _AddKeyViewState extends State<AddKeyView> {
  late AddKeyController addKeyController = AddKeyController(widget.controller);
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    void showNewKey(newKeyMetaData) {
      showDialog(
          context: context,
          builder: (context) => ViewKeyDialog(
              thisKey: newKeyMetaData,
              title: 'Imported Key: ${newKeyMetaData.keyName}'));
    }

    void showError(String title, String filepath, {Object? e}) {
      showDialog(
          context: context,
          builder: (context) => Dialog(
                child: Column(children: [
                  Text(title),
                  Text('filepath: `$filepath`'),
                  if (e != null) Text(e.toString()),
                  if (e != null) Text(e.runtimeType.toString()),
                ]),
              ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AddKeyView.title,
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
                final pickerRes = await FilePicker.platform.pickFiles(
                  // just a suggestion, not an enforcement: (cannot rely on .pem)
                  allowedExtensions: ['pem'],
                );

                if (pickerRes != null && pickerRes.count > 0) {
                  KeyMetaData? newKeyMetaData;
                  try {
                    newKeyMetaData = await addKeyController
                        .saveKeyFromFilePath(pickerRes.files.single.path!);
                  } catch (e) {
                    print(e);
                    print(e.toString());
                    print(e.runtimeType.toString());
                    showError(
                      'Error adding key',
                      pickerRes.files.single.path!,
                      e: e,
                    );
                  }

                  if (newKeyMetaData != null) {
                    showNewKey(newKeyMetaData);
                  }
                  // else {
                  //   // showError(
                  //   //   'Null key returned from addKeyController',
                  //   //   pickerRes.files.single.path!,
                  //   // );
                  // }
                }
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
                          Icons.file_open_rounded,
                          size: 300 * 8 / 15,
                        ),
                        Text(
                          AddKeyView.title,
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
                          'Importing key…',
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
