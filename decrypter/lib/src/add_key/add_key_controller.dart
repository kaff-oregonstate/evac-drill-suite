import 'dart:async';
import 'package:path/path.dart' as p;

import 'package:flutter/services.dart';

import 'package:pointycastle/asymmetric/api.dart';
import '../util/cryptography/rsa_implementation.dart';

import 'add_key_service.dart';
import '../gen_key/gen_key_controller.dart';
import '../gen_key/gen_key_service.dart';
import '../keys/keys_controller.dart';
import '../keys/key_meta_data.dart';

class AddKeyController {
  AddKeyController(this.keysController);
  final KeysController keysController;

  /// save a private key from the user selected path
  /// IMPORTANT!: Wrap this in a try statement so that bad inputs are shown
  /// to the user via a showErrorDialog
  Future<dynamic> saveKeyFromFilePath(String filePath) async {
    /// get the keyname, which for our purposes is whatever the filename is
    final keyName = p.basename(filePath).replaceAll('.priv.pem', '');

    /// check if we already have a key by that keyname:
    for (final thisKey in keysController.keys) {
      if (thisKey.keyName == keyName) {
        throw Exception(
            'Already have a key by name: $keyName… rename this key if you absolutely must import it');
      }
    }

    /// get the privkey from user indicated path
    final pemString = await AddKeyService.getPemStringFromFilePath(filePath);
    final privKey = RSAimplement.rsaPrivateKeyFromPem(pemString);
    final pubKey = GenKeyController.makePubFromPriv(privKey);

    /// after import and create pub key, do a loop with the two keys to confirm
    /// (formatting && key) is valid
    if (!_confirmEncDecLoop(privKey, pubKey)) {
      throw Exception(
          'Key pair generated from input private key is breaking encryption loop, data may be corrupted…');
    }

    /// save the priv key to disk
    await GenKeyService.savePrivKeyPem(
        RSAimplement.encodeRSAPrivateKeyToPem(privKey), keyName);

    /// save new keymetadata to state (and disk)
    final newKeyMetaData = KeyMetaData(keyName: keyName);
    await keysController.addKey(newKeyMetaData).then((value) {
      if (!value) throw Exception('INTERNAL: bad save of newKeyMetaData');
    });

    // return the new keymetadata
    return newKeyMetaData;
  }
}

_confirmEncDecLoop(RSAPrivateKey privKey, RSAPublicKey pubKey) {
  const plaintext = 'do these bytes come out the other side?';
  final ciphertext =
      RSAimplement.rsaEncrypt(pubKey, Uint8List.fromList(plaintext.codeUnits));
  final decBytes = RSAimplement.rsaDecrypt(privKey, ciphertext);
  final looptext = String.fromCharCodes(decBytes);
  return looptext == plaintext;
}
