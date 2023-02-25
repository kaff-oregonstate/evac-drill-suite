import 'dart:convert';
import 'dart:io';
import 'package:evac_drill_cryptography/src/gen_key/gen_key_controller.dart';
import 'package:evac_drill_cryptography/src/util/cryptography/rsa_implementation.dart';
import 'package:path_provider/path_provider.dart';

import 'key_meta_data.dart';

/// A service that stores and retrieves user keys.

class KeysMetaDataService {
  /// Loads the User's keys from disk storage.

  Future<List<KeyMetaData>> keys() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;

    final keysDir = Directory('$appDocPath/keys');
    if (!keysDir.existsSync()) keysDir.createSync();

    final keysMetaDataJson = File('$appDocPath/keys/keys_metadata.json');
    if (!keysMetaDataJson.existsSync()) {
      keysMetaDataJson.createSync();
      keysMetaDataJson.writeAsStringSync('[]');
    }

    final keysMetaDataJsonString = keysMetaDataJson.readAsStringSync();

    final keysMetaDataList = jsonDecode(keysMetaDataJsonString);

    if (keysMetaDataList.isNotEmpty) {
      // List<Map<String, dynamic>> keysMetaDataListOfMaps;
      // try {
      //   keysMetaDataListOfMaps = keysMetaDataList as List<Map<String, dynamic>>;
      // } catch (e) {
      //   print(
      //       'Unexpected error in cast of non-empty List to List<Map<String,dynamic>> in KeysMetaDataService:');
      //   print(e);
      //   print('Error type: ${e.runtimeType}');
      //   return [];
      // }

      List<KeyMetaData> keysMetaData = [];
      try {
        // for (final keyJson in keysMetaDataListOfMaps) {
        for (final keyJson in keysMetaDataList) {
          keysMetaData.add(KeyMetaData.fromJson(keyJson));
        }
      } catch (e) {
        print(
            'Unexpected error in parse of keysMetaDataListOfMaps to List<KeyMetaData>:');
        print(e);
        print('Error type: ${e.runtimeType}');
      }

      return keysMetaData;
    }

    return [];
  }

  /// Persists the user's keys to local storage.

  Future<void> updateKeys(List<KeyMetaData> keys) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;

    final keysDir = Directory('$appDocPath/keys');
    if (!keysDir.existsSync()) keysDir.createSync();

    final keysMetaDataJson = File('$appDocPath/keys/keys_metadata.json');
    if (!keysMetaDataJson.existsSync()) keysMetaDataJson.createSync();

    List<Map<String, dynamic>> keysJsonList = [];
    for (final key in keys) {
      keysJsonList.add(key.toJson());
    }

    keysMetaDataJson.writeAsStringSync(jsonEncode(keysJsonList), flush: true);

    return;
  }

  // // Persist a new key to local storage
  // Future<void> addKey(KeyMetaData key) async {
  //   // add key to list on disk
  //   return;
  // }

  static Future<String> getPublicKeyPEMString(KeyMetaData key) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;

    final keysDir = Directory('$appDocPath/keys');
    if (!keysDir.existsSync()) keysDir.createSync();

    final privKeyFile = File('${keysDir.path}/${key.privKeyFileName}');
    final priv =
        RSAimplement.rsaPrivateKeyFromPem(privKeyFile.readAsStringSync());
    final pub = GenKeyController.makePubFromPriv(priv);
    return RSAimplement.encodeRSAPublicKeyToPem(pub);
  }

  static void saveCopyOfPrivKey(KeyMetaData key, String savePath) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path; // print(appDocPath);

    final keysDirPath = Directory('$appDocPath/keys').path;
    final privKeyFile = File('$keysDirPath/${key.privKeyFileName}');

    final saveFile = File('$savePath/${key.privKeyFileName}');
    await saveFile.writeAsBytes(await privKeyFile.readAsBytes());
  }
}
