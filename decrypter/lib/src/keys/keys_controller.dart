import 'package:flutter/material.dart';

import 'key_meta_data.dart';
import 'keys_meta_data_service.dart';

/// A class that many Widgets can interact with to read user keys, update
/// user keys, or listen to user keys changes.
///
/// Controllers glue Data Services to Flutter Widgets. The KeysController
/// uses the KeysMetaDataService to store and retrieve user keys.
class KeysController with ChangeNotifier {
  KeysController(this._keysMetaDataService);

  // Make KeysMetaDataService a private variable so it is not used directly.
  final KeysMetaDataService _keysMetaDataService;

  // Make List<KeyMetaData> a private variable so it is not updated directly
  // without also persisting the changes with the KeysMetaDataService.
  late List<KeyMetaData> _keys;

  // Allow Widgets to read the user's current list of Keys (via KeyMetaData).
  List<KeyMetaData> get keys => _keys;

  /// Load the user's keys from the KeysMetaDataService. It loads from disk.
  /// The controller only knows it can load the keys from the service.
  Future<void> loadKeys() async {
    _keys = await _keysMetaDataService.keys();
    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  /// Save the user's keys to the KeysMetaDataService. It saves to disk.
  /// The controller only knows it can save the keys to the service.
  Future<void> saveKeys() async {
    await _keysMetaDataService.updateKeys(_keys);
  }

  bool isKeyNameUniq(KeyMetaData? newKeyMetaData) {
    // Do not perform any work if new and old KeyMetaData are identical
    // This is not a deep comparison, should implement KeyMetaData.== …
    if (newKeyMetaData == null || _keys.contains(newKeyMetaData)) return false;
    return true;
  }

  /// Persist a new KeyMetaData based on a newly generated key.
  Future<bool> addKey(KeyMetaData? newKeyMetaData) async {
    if (newKeyMetaData == null) return false;

    // Otherwise, store the new KeyMetaData in memory
    _keys.add(newKeyMetaData);

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to disk using the KeysMetaDataService.
    await saveKeys();

    return true;
  }

  void incrementKeyUses(String keyName) {
    _keys
        .where((element) => element.keyName == keyName)
        .first
        .incrementTimesUsed();
    saveKeys();
  }
}
