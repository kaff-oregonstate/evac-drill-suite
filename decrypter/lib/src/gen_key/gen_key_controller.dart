import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:evac_drill_cryptography/src/gen_key/gen_key_service.dart';
import 'package:evac_drill_cryptography/src/keys/key_meta_data.dart';
import 'package:evac_drill_cryptography/src/keys/keys_controller.dart';
import 'package:evac_drill_cryptography/src/util/cryptography/rsa_implementation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';

class GenKeyController {
  GenKeyController(this.keysController);
  final KeysController keysController;

  /// generate a new keypair,
  /// persist the private key,
  /// persist the metadata
  Future<KeyMetaData> generateKey() async {
    KeyMetaData keyMetaData = KeyMetaData();
    bool nonDupe = keysController.isKeyNameUniq(keyMetaData);
    while (!nonDupe) {
      keyMetaData = KeyMetaData();
      nonDupe = keysController.isKeyNameUniq(keyMetaData);
    }

    // this is stupid slow, need to async it in an isolate?
    // ⬇️⬇️⬇️⬇️⬇️
    // final keyPair =
    //     RSAimplement.generateRSAkeyPair(RSAimplement.exampleSecureRandom());
    // ⬆️⬆️⬆️⬆️⬆️

    // but isolate is busted on platform channel (which is every plugin ever)?

    // oh nvm [goated dev](https://github.com/gaaclarke) just fixed it in Flutter 3.7

    // updating…

    // https://github.com/gaaclarke/background_isolate_channels_sample/blob/main/lib/simple_database.dart
    RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;

    final firstCommand =
        _Command(arg0: keyMetaData.keyName, arg1: rootIsolateToken);

    final madeKey = await compute(_genAndSaveRSAKeyPair, firstCommand);
    if (!madeKey) {
      throw Exception('compute of genRSAKeyPair failed');
    }

    await keysController.addKey(keyMetaData);

    return keyMetaData;
  }

  static makePubFromPriv(RSAPrivateKey priv) {
    // RSAimplement.generateRSAkeyPair(secureRandom);
    if (priv.n != null && priv.exponent != null) {
      return RSAPublicKey(priv.n!, priv.publicExponent!);
    }
    return null;
  }
}

class _Command {
  const _Command({this.arg0, this.arg1});
  final Object? arg0;
  final Object? arg1;
}

_genAndSaveRSAKeyPair(_Command cmd) async {
  try {
    String keyName = cmd.arg0 as String;

    RootIsolateToken rootIsolateToken = cmd.arg1 as RootIsolateToken;
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

    final keyPair =
        RSAimplement.generateRSAkeyPair(RSAimplement.exampleSecureRandom());

    final privKeyPemString =
        RSAimplement.encodeRSAPrivateKeyToPem(keyPair.privateKey);
    await GenKeyService.savePrivKeyPem(privKeyPemString, keyName);

    /// no need to save the pubKey, as it can be generated from privKey on command
    // final pubKeyPemString =
    //     RSAimplement.encodeRSAPublicKeyToPem(keyPair.publicKey);
    // await GenKeyService.savePubKeyPem(pubKeyPemString, keyName);
  } catch (e) {
    // should never get here now that the rootIsolateToken is passed to the
    // BackgroundIsolateBinaryMessenger and Platform Channels are accessible
    // from secondary isolate
    print(e);
    print(e.runtimeType);
    return false;
  }
  return true;
}
