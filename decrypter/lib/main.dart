import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/keys/keys_controller.dart';
import 'src/keys/keys_meta_data_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set up the KeysController, which will glue user keys to multiple
  // Flutter Widgets.
  final keysController = KeysController(KeysMetaDataService());

  // Load the user's keys as view loads
  await keysController.loadKeys();
  // keysController.loadKeys();

  // Run the app and pass in the KeysController. The app listens to the
  // KeysController for changes, then passes it further down to the
  // KeysView.
  runApp(MyApp(keysController: keysController));
}
