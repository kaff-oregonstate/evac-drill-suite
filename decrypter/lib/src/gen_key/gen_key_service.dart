import 'dart:io';

import 'package:path_provider/path_provider.dart';

class GenKeyService {
  /// Save a newly generated privKeyPemString to .pem file
  static savePrivKeyPem(String privKeyPemString, String keyName) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;

    final keysDir = Directory('$appDocPath/keys');
    if (!keysDir.existsSync()) keysDir.createSync();

    final keyFile = File('${keysDir.path}/$keyName.priv.pem');
    if (keyFile.existsSync()) {
      throw Exception('key already exists with that name!');
    }
    keyFile.writeAsStringSync(privKeyPemString);
    return;
  }

  /// no need to save a pubKey as it can be generated from priv on command
  // /// Save a newly generated pubKeyPemString to .pem file
  // static savePubKeyPem(String pubKeyPemString, String keyName) async {
  //   final appDocDir = await getApplicationDocumentsDirectory();
  //   final appDocPath = appDocDir.path;

  //   final keysDir = Directory('$appDocPath/keys');
  //   if (!keysDir.existsSync()) keysDir.createSync();

  //   final keyFile = File('${keysDir.path}/$keyName.pub.pem');
  //   if (keyFile.existsSync()) {
  //     throw Exception('key already exists with that name!');
  //   }
  //   keyFile.writeAsStringSync(pubKeyPemString);
  //   return;
  // }
}
