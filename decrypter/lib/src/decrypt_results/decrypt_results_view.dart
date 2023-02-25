import 'dart:math';

import 'package:evac_drill_cryptography/src/decrypt_results/decrypt_results_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pointycastle/asymmetric/api.dart';

import '../keys/key_meta_data.dart';
import '../keys/keys_controller.dart';

/// Displays the controls for decrypting encrypted and zipped results.
class DecryptResultsView extends StatefulWidget {
  const DecryptResultsView({super.key, required this.controller});

  static const routeName = '/decryptResults';
  static const title = 'Decrypt results';

  final KeysController controller;

  @override
  State<DecryptResultsView> createState() => _DecryptResultsViewState();
}

class _DecryptResultsViewState extends State<DecryptResultsView> {
  // late DecryptResultsController addKeyController = DecryptResultsController(widget.controller);
  bool _loading = false;
  bool _checkingKeys = false;
  String? _resultsZipPath;
  bool _badZipSelected = false;
  KeyMetaData? _selectedKey;
  bool _foundKey = false;
  RSAPrivateKey? _privKey;
  String? _outputPath;
  bool _parse = false;
  String? _outputDirPath;
  bool _resultDecrypted = false;

  void setResultsZipPath(String path) async {
    setState(() {
      _resultsZipPath = null;
    });
    if (await confirmZip(path)) {
      setState(() {
        _resultsZipPath = path;
      });
      checkKeys();
    }
    // do nothing if zip is bad
  }

  void setSelectedKey(KeyMetaData thisKey) {
    setState(() {
      _selectedKey = thisKey;
    });
    getPrivateKeyForSelected();
  }

  void getPrivateKeyForSelected() async {
    final RSAPrivateKey thisPrivKey =
        await DecryptResultsController.getPrivKey(_selectedKey!);
    setState(() {
      _privKey = thisPrivKey;
    });
  }

  void setOutputPath(String? path) {
    setState(() => _outputPath = path);
  }

  void setOutputDirPath(String? path) {
    setState(() => _outputDirPath = path);
  }

  void setParse(bool parse) {
    setState(() => _parse = parse);
  }

  void setLoading(bool loading) {
    setState(() => _loading = loading);
  }

  void setResultsDecrypted(bool success) {
    setState(() => _resultDecrypted = success);
  }

  Future<bool> confirmZip(String path) {
    // confirm file at path is archive
    if (!path.endsWith('.zip')) {
      _badZipSelected = true;
      return Future.value(false);
    }
    _badZipSelected = false;
    // maybe try looking inside it as an archive within a try?
    return Future.value(true);
  }

  void checkKeys() async {
    setState(() => _checkingKeys = true);
    // loopcheck with each privkey
    // if one matches, set it as the current _privKey and _selectedKey
    final thisKey = await DecryptResultsController.findMatchingKey(
      _resultsZipPath!,
      widget.controller.keys,
    );

    if (thisKey != null) {
      setState(() => _foundKey = true);
      setSelectedKey(thisKey);
    } else {
      setState(() => _foundKey = false);
    }

    // await Future.delayed(const Duration(seconds: 3));
    setState(() => _checkingKeys = false);
  }

  @override
  Widget build(BuildContext context) {
    // void showNewKey(newKeyMetaData) {
    //   showDialog(
    //       context: context,
    //       builder: (context) => ViewKeyDialog(
    //           thisKey: newKeyMetaData,
    //           title: 'Imported Key: ${newKeyMetaData.keyName}'));
    // }

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
        title: Text(DecryptResultsView.title,
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Center(
        child: SizedBox(
          // height: 300,
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: (!_loading)
                ? (!_resultDecrypted)
                    ? [
                        _chooseResultsZipWidget(),
                        const SizedBox(height: 20),
                        _chooseKeyWidget(),
                        const SizedBox(height: 20),
                        _chooseOutputPathWidget(),
                        const SizedBox(height: 20),
                        _chooseParseWidget(),
                        const SizedBox(height: 20),
                        _decryptButton(),
                      ]
                    : [
                        Container(
                          height: 300,
                          width: double.infinity,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            // color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context).dividerColor,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Decryption successful. Output path:',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              const SizedBox(height: 12),
                              SelectionArea(
                                child: Text(
                                  _outputDirPath ?? 'error: no output path…',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _resultDecrypted = false;
                                  });
                                },
                                child: const Text('decrypt other results'),
                              )
                            ],
                          ),
                        ),
                      ]
                : [
                    Container(
                      height: 300,
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 300 * 8 / 15,
                            width: 300 * 8 / 15,
                            child: CircularProgressIndicator.adaptive(),
                          ),
                          Text(
                            'Decrypting results…',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }

  Widget _chooseResultsZipWidget() {
    // create the displayed string of choice
    String resultsZipPathDisplay = '';
    if (_resultsZipPath != null) {
      final only40CharsStart = _resultsZipPath!.length - 40;
      final start = max(0, only40CharsStart);
      if (start > 0) resultsZipPathDisplay += '…';
      resultsZipPathDisplay += _resultsZipPath!.substring(start);
    }
    // normal behavior of button (if enabled)
    Function()? onPressed = () async {
      final pickerRes = await FilePicker.platform.pickFiles(
        // just a suggestion, not an enforcement: (cannot rely on .pem)
        allowedExtensions: ['zip'],
      );
      if (pickerRes != null && pickerRes.count > 0) {
        print('picked a file: ${pickerRes.files.single.path!}');
        setResultsZipPath(pickerRes.files.single.path!);
      }
    };
    String buttonText = 'Select results .zip';
    if (_resultsZipPath == null) {
      // re-choose, bad format selected
      if (_badZipSelected) {
        buttonText = 'Select valid results .zip';
        resultsZipPathDisplay = 'invalid zip selected, try again';
      }
    } else {
      // selection made, re-choose?
      buttonText = 'Select different results .zip';
    }
    if (_checkingKeys) {
      // button should be disabled
      buttonText = 'Selected results .zip, checking keys…';
      onPressed = null;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        // color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
                backgroundColor: (_resultsZipPath != null && !_badZipSelected)
                    ? MaterialStateProperty.all(Colors.grey[700])
                    : null),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(buttonText),
                const SizedBox(width: 8),
                const Icon(Icons.folder_zip_rounded),
              ],
            ),
          ),
          if (_resultsZipPath != null || _badZipSelected)
            const SizedBox(height: 4),
          if (resultsZipPathDisplay != '') Text(resultsZipPathDisplay),
        ],
      ),
    );
  }

  Widget _chooseKeyWidget() {
    if (_checkingKeys) return const CircularProgressIndicator.adaptive();

    // normal behavior of button (if enabled)
    void Function(KeyMetaData?)? onChanged = (thisKey) {
      if (thisKey == null) return;
      setState(() => _foundKey = false);
      setSelectedKey(thisKey);
    };
    // button only enabled if valid zip is selected
    if (_resultsZipPath == null) onChanged = null;

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor, width: 2),
      ),
      child: Column(
        children: [
          if (_foundKey)
            const Text(
              'this key matches results:',
              style: TextStyle(color: Colors.green),
            ),
          DropdownButton<KeyMetaData?>(
              value: _selectedKey,
              hint: const Text('Select key'),
              disabledHint: const Text('Select key after results zip'),
              borderRadius: BorderRadius.circular(4),
              onChanged: onChanged,
              items: List.generate(widget.controller.keys.length, (index) {
                return DropdownMenuItem(
                  value: widget.controller.keys[index],
                  child: Text(widget.controller.keys[index].keyName),
                );
              })),
        ],
      ),
    );
  }

  Widget _chooseOutputPathWidget(
      // String? outputPath,
      // Function setOutputPath,
      ) {
    // create the displayed string of choice
    String outputPathDisplay = '';
    if (_outputPath != null) {
      final only40CharsStart = _outputPath!.length - 40;
      final start = max(0, only40CharsStart);
      if (start > 0) outputPathDisplay += '…';
      outputPathDisplay += _outputPath!.substring(start);
    }
    // normal behavior of button (if enabled)
    Function()? onPressed = () async {
      final outputPath = await FilePicker.platform.getDirectoryPath();
      if (outputPath != null) {
        print('picked an output directory: $outputPath');
        setOutputPath(outputPath);
      }
    };

    String buttonText = 'Select output path';
    if (_selectedKey == null) {
      onPressed = null;
      buttonText = 'Select output path after key';
    }
    if (_resultsZipPath == null) {
      onPressed = null;
      buttonText = 'Select output path after results';
    }
    if (_outputPath != null) {
      // selection made, re-choose?
      buttonText = 'Select different output path';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        // color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('optional: '),
              // const SizedBox(width: 8),
              ElevatedButton(
                onPressed: onPressed,
                style: ButtonStyle(
                    backgroundColor: (_outputPath != null)
                        ? MaterialStateProperty.all(Colors.grey[700])
                        : null),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(buttonText),
                    const SizedBox(width: 8),
                    const Icon(Icons.folder_rounded),
                  ],
                ),
              ),
            ],
          ),
          if (_outputPath != null) const SizedBox(height: 4),
          if (outputPathDisplay != '')
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(outputPathDisplay),
                if (_outputPath != null) const SizedBox(width: 8),
                if (_outputPath != null)
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red[900]),
                    ),
                    onPressed: () {
                      setOutputPath(null);
                    },
                    child: const Icon(
                      Icons.folder_off_rounded,
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _chooseParseWidget() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 12),
          const Text('parse results: '),
          Switch(
            value: _parse,
            onChanged: setParse,
            activeColor: Colors.green[800],
          ),
        ],
      ),
    );
  }

  Widget _decryptButton() {
    // normal behavior of button (if enabled)
    Function()? onPressed = () async {
      if (_resultsZipPath == null || _privKey == null) return null;
      String? outputPath = _outputPath;
      if (_outputPath == null) {
        // decrypt in place
        // set outputPath to be local to resultsZipPath
        outputPath = DecryptResultsController.outputInPlace(_resultsZipPath!);
        // setOutputPath(outputPath);
      }

      final unzipPath =
          DecryptResultsController.unzipEncResults(_resultsZipPath!);
      // check parse
      if (_parse) {
        final outputDirPath =
            DecryptResultsController.decryptAndParseEncResults(
                unzipPath, outputPath!, _privKey!);
        setOutputDirPath(outputDirPath);
      } else {
        final outputDirPath = DecryptResultsController.decryptEncResults(
            unzipPath, outputPath!, _privKey!);
        setOutputDirPath(outputDirPath);
      }
      DecryptResultsController.cleanUpUnzippedEncResults(unzipPath);
      widget.controller.incrementKeyUses(_selectedKey!.keyName);
      setResultsDecrypted(true);
      setLoading(false);
    };
    String buttonText = 'Decrypt results';
    if (_resultsZipPath == null) {
      // tooltip says select zipped encrypted results
      buttonText = 'select results';
      onPressed = null;
    } else if (_selectedKey == null) {
      // tooltip says select key for decryption
      buttonText = 'select key';
      onPressed = null;
    } else if (_privKey == null) {
      // privKey must be loading…
      buttonText = 'loading key data…';
      onPressed = null;
      // tooltip says "loading key"?
    } else {
      // allow decrypt
    }

    // dropdown sets parse/noParse
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_selectedKey != null && _privKey == null)
          const CircularProgressIndicator.adaptive(),
        if (_selectedKey != null && _privKey == null) const SizedBox(width: 8),
        ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              backgroundColor: (_outputPath != null)
                  ? MaterialStateProperty.all(Colors.grey[700])
                  : null),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(buttonText),
              const SizedBox(width: 8),
              const Icon(Icons.lock_open_rounded),
            ],
          ),
        ),
      ],
    );
  }
}


// final inkwell = InkWell(
//   borderRadius: BorderRadius.circular(12),
//   onTap: () async {
//     if (!_loading) {
//       setState(() {
//         _loading = true;
//       });
//       final pickerRes = await FilePicker.platform.pickFiles(
//         // just a suggestion, not an enforcement: (cannot rely on .pem)
//         allowedExtensions: ['pem'],
//       );

//       if (pickerRes != null && pickerRes.count > 0) {
//         KeyMetaData? newKeyMetaData;
//         try {
//           newKeyMetaData = await addKeyController
//               .saveKeyFromFilePath(pickerRes.files.single.path!);
//         } catch (e) {
//           print(e);
//           print(e.toString());
//           print(e.runtimeType.toString());
//           showError(
//             'Error adding key',
//             pickerRes.files.single.path!,
//             e: e,
//           );
//         }

//         if (newKeyMetaData != null) {
//           showNewKey(newKeyMetaData);
//         }
//         // else {
//         //   // showError(
//         //   //   'Null key returned from addKeyController',
//         //   //   pickerRes.files.single.path!,
//         //   // );
//         // }
//       }
//       setState(() {
//         _loading = false;
//       });
//     }
//   },
//   child: Container(
//     width: double.infinity,
//     decoration: BoxDecoration(
//       // color: Theme.of(context).backgroundColor,
//       borderRadius: BorderRadius.circular(12),
//       border: Border.all(
//         color: Theme.of(context).dividerColor,
//         width: 2,
//       ),
//     ),
//     child: Container(),
//   ),
// );

// // Glue the KeysController to the theme selection DropdownButton.
// //
// // When a user selects a theme from the dropdown list, the
// // KeysController is updated, which rebuilds the MaterialApp.
// child: DropdownButton<ThemeMode>(
//   // Read the selected themeMode from the controller
//   value: controller.themeMode,
//   // Call the updateThemeMode method any time the user selects a theme.
//   onChanged: controller.updateThemeMode,
//   items: const [
//     DropdownMenuItem(
//       value: ThemeMode.system,
//       child: Text('System Theme'),
//     ),
//     DropdownMenuItem(
//       value: ThemeMode.light,
//       child: Text('Light Theme'),
//     ),
//     DropdownMenuItem(
//       value: ThemeMode.dark,
//       child: Text('Dark Theme'),
//     )
//   ],
// ),
