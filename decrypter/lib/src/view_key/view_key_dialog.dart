import 'dart:convert';
import 'dart:io';

import 'package:evac_drill_cryptography/src/keys/keys_meta_data_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../keys/key_meta_data.dart';

/// Displays the info for a given key.
class ViewKeyDialog extends StatefulWidget {
  const ViewKeyDialog({super.key, required this.thisKey, required this.title});

  final KeyMetaData thisKey;
  final String title;

  @override
  State<ViewKeyDialog> createState() => _ViewKeyDialogState();
}

class _ViewKeyDialogState extends State<ViewKeyDialog> {
  String? pubKeyString;

  @override
  void initState() {
    KeysMetaDataService.getPublicKeyPEMString(widget.thisKey)
        .then((value) => setState(() => pubKeyString = value));
    super.initState();
  }

  // final KeysController controller;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 7),
            Text(
              'created: ${widget.thisKey.created.toString().substring(0, 16)}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'times used to decrypt results: ${widget.thisKey.timesUsed.toString()}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                // color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 2,
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Copy public key for Console:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '(safe to share anywhere)',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  if (pubKeyString != null)
                    IconButton(
                      onPressed: () => copyPublicKeyForConsole(),
                      icon: const Icon(Icons.copy),
                      splashRadius: 24.0,
                    ),
                  if (pubKeyString == null)
                    const CircularProgressIndicator.adaptive(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                // color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 2,
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Save copy of private key:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '(keep secret to maintain security)',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: () => saveCopyOfPrivateKey(),
                    icon: const Icon(Icons.save_alt_rounded),
                    splashRadius: 24.0,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                // color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 2,
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Check if pubKeys match:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '(test)',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  if (pubKeyString != null)
                    IconButton(
                      onPressed: () => seeIfDuplicatePubKey(pubKeyString!),
                      icon: const Icon(Icons.double_arrow_rounded),
                      splashRadius: 24.0,
                    ),
                  if (pubKeyString == null)
                    const CircularProgressIndicator.adaptive(),
                ],
              ),
            ),
            // Text(
            //     'TODO: Implement "Copy public key for Console:" (icon: globe) button'),
            // Text(
            //     'TODO: Implement optional "Save copy of private key (already saved in decrypter)" (icon: lock) button, dialog'),
          ],
        ),
      ),
    );
  }

  Future<bool> seeIfDuplicatePubKey(String thisPubKey) async {
    print('im in');
    // // file_picker to get save location
    // final pickerRes = await FilePicker.platform.pickFiles();
    // if (pickerRes != null && pickerRes.count > 0) {
    //   final accessRecordJsonFile = File(pickerRes.files.single.path!);
    //   final accessRecord = jsonDecode(accessRecordJsonFile.readAsStringSync());
    //   // print(thisPubKey);
    //   // print(accessRecord ?? 'no accessRecord');
    //   // print(accessRecord['publicKey'] ?? 'no pubKey');
    //   if (accessRecord['publicKey'] == thisPubKey) {
    //     print(true);
    //   }
    //   return accessRecord['publicKey'] == thisPubKey;
    // }
    // return false;
    final res = (await Clipboard.getData('text/plain'))?.text == thisPubKey;
    print(res);
    return res;
  }

  void saveCopyOfPrivateKey() async {
    // file_picker to get save location
    final savePath = await FilePicker.platform.getDirectoryPath();
    if (savePath != null) {
      // use that path to write bytes from file
      KeysMetaDataService.saveCopyOfPrivKey(widget.thisKey, savePath);
    }
  }

  void copyPublicKeyForConsole() async {
    await Clipboard.setData(ClipboardData(text: pubKeyString));
  }
}
