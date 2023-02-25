import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:evac_drill_cryptography/src/keys/key_meta_data.dart';
// import 'package:csv/csv.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pointycastle/export.dart';

import '../util/cryptography/rsa_implementation.dart';

class DecryptResultsController {
  static String outputInPlace(String resultsZipPath) {
    return p.dirname(resultsZipPath);
  }

  static Future<RSAPrivateKey> getPrivKey(
    KeyMetaData thisKey,
  ) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final keysDir = Directory('${appDocDir.path}/keys');
    final keyFile = File('${keysDir.path}/${thisKey.privKeyFileName}');
    final thisPrivKeyString = keyFile.readAsStringSync();
    return RSAimplement.rsaPrivateKeyFromPem(thisPrivKeyString);
  }

  static Future<KeyMetaData?> findMatchingKey(
    String zipPath,
    List<KeyMetaData> keys,
  ) async {
    final pubKeyString = _getPubKeyAttachedToResults(zipPath);
    if (pubKeyString == null) return null;
    final pubKey = RSAimplement.rsaPublicKeyFromPem(pubKeyString);

    final appDocDir = await getApplicationDocumentsDirectory();
    final keysDir = Directory('${appDocDir.path}/keys');

    for (final thisKey in keys) {
      final keyFile = File('${keysDir.path}/${thisKey.privKeyFileName}');
      if (!keyFile.existsSync()) {
        throw Exception('bad key in metadata!');
      }
      final thisPrivKeyString = keyFile.readAsStringSync();
      final thisPrivKey = RSAimplement.rsaPrivateKeyFromPem(thisPrivKeyString);
      if (_confirmEncDecLoop(thisPrivKey, pubKey)) {
        return thisKey;
      }
    }
    return null;
  }

  static String unzipEncResults(String zipPath) {
    if (!zipPath.contains('.zip')) {
      throw Exception('bad zip formatting, does not end in `.zip`');
    }
    if (!File(zipPath).existsSync()) {
      throw Exception('zip file does not exist!');
    }

    final unzipPath = zipPath.replaceAll('.zip', '');
    Directory unzipDir = Directory(unzipPath);
    int copyNum = 0;
    while (unzipDir.existsSync()) {
      copyNum++;
      unzipDir = Directory('$unzipPath-$copyNum');
    }
    unzipDir.createSync();

    final inputStream = InputFileStream(zipPath);
    final archive = ZipDecoder().decodeBuffer(inputStream);
    extractArchiveToDisk(archive, unzipDir.path);
    return unzipDir.path;
  }

  static void cleanUpUnzippedEncResults(String unzipPath) {
    Directory unzipDir = Directory(unzipPath);
    unzipDir.deleteSync(recursive: true);
  }

  static void copyAccessRecordToOutput(
    String resultsPath,
    String outputPath,
  ) {
    final accessResultsFile = File('$resultsPath/accessRecord.json');
    final copyOfFile = File('$outputPath/accessRecord.json');
    copyOfFile.writeAsBytesSync(accessResultsFile.readAsBytesSync());
  }

  static String decryptEncResults(
    String resultsPath,
    String outputPath,
    RSAPrivateKey privKey,
  ) {
    final drillID = p.basename(resultsPath).split('-')[0].split('_')[2];
    final outputPath = p.dirname(resultsPath);

    // create DrillResults directory
    Directory outputDir =
        Directory('$outputPath/DrillResults-$drillID-noParse');
    int copyNum = 0;
    while (outputDir.existsSync()) {
      copyNum++;
      outputDir =
          Directory('$outputPath/DrillResults-$drillID-noParse-$copyNum');
    }
    outputDir.createSync();

    copyAccessRecordToOutput(resultsPath, outputDir.path);

    // parse each participant result directory
    final resultDirs =
        Directory('$resultsPath/DrillResults-$drillID-enc').listSync();
    for (FileSystemEntity item in resultDirs) {
      // error check for non directory items
      if (!FileSystemEntity.isDirectorySync(item.path)) continue;
      final dir = item as Directory;

      // duplicate the participant directory into the outputDir
      final thisDir = Directory('${outputDir.path}/${p.basename(dir.path)}');
      thisDir.createSync();

      /// decrypt each file in the participant result directory
      final participantResults = dir.listSync();
      for (FileSystemEntity item in participantResults) {
        // error check for directory items
        if (!FileSystemEntity.isFileSync(item.path)) continue;
        final enc = item as File;

        _decryptFile(enc, thisDir, privKey);
      }
    }

    return outputDir.path;
  }

  static String decryptAndParseEncResults(
    String resultsPath,
    String outputPath,
    RSAPrivateKey privKey,
  ) {
    // confirm dir at outputPath exists
    if (!Directory(outputPath).existsSync()) {
      throw Exception('selected output path no longer exists: $outputPath');
    }

    // const exampleZipBasename =
    //     "DrillResultZips_4YE1…uj4_spSzoP…nO2-2023-02-11T10_52_37.222Z.zip";
    final drillID = p.basename(resultsPath).split('-')[0].split('_')[2];

    // create DrillResults directory
    Directory outputDir = Directory('$outputPath/DrillResults-$drillID');
    int copyNum = 0;
    while (outputDir.existsSync()) {
      copyNum++;
      outputDir = Directory('$outputPath/DrillResults-$drillID-$copyNum');
    }
    outputDir.createSync();

    copyAccessRecordToOutput(resultsPath, outputDir.path);

    /// For now, just put all survey results into one big list
    final surveyResults = [];

    // create /trajectories directory
    final trajDir = Directory('${outputDir.path}/trajectories');
    trajDir.createSync();

    // parse each participant result directory
    final resultDirs =
        Directory('$resultsPath/DrillResults-$drillID-enc').listSync();
    for (FileSystemEntity item in resultDirs) {
      // error check for non directory items
      if (!FileSystemEntity.isDirectorySync(item.path)) continue;
      final dir = item as Directory;

      // get the participant id from the directory name
      final pID = p.basename(dir.path);

      /// decrypt and maybe parse each file in the participant result directory
      final participantResults = dir.listSync();
      for (FileSystemEntity item in participantResults) {
        // error check for directory items
        if (!FileSystemEntity.isFileSync(item.path)) continue;
        final enc = item as File;

        // get the filename with extension
        final encName = p.basename(enc.path);

        // confirm encryption
        if (!encName.contains('.enc')) continue;

        // decrypt & maybe parse:
        if (encName.contains('.gpx')) {
          // HACK: could `compute` here? or could compute the whole thing…
          _decryptFile(enc, trajDir, privKey);
        }
        // decrypt and decode json into memory
        // for now: just get the survey results and put them into the list
        else if (encName.contains('.json')) {
          _decryptAndParseDrillResults(enc, surveyResults, pID, privKey);
        }
      }
    }

    // write the list of survey results to disk
    final surveyResultsFile = File('${outputDir.path}/surveyResults.json');
    surveyResultsFile.writeAsStringSync(jsonEncode(surveyResults));

    return outputDir.path;
  }
}

/// decrypt any file into a directory on disk
void _decryptFile(
  File enc,
  Directory outDir,
  RSAPrivateKey privKey,
) {
  final fileName = p.basename(enc.path).replaceAll('.enc', '');
  File('${outDir.path}/$fileName').writeAsBytesSync(RSAimplement.rsaDecrypt(
    privKey,
    enc.readAsBytesSync(),
  ));
}

/// For now, only grabbing survey results, but this can be extended to get
/// any TaskResult and do anything with it…
void _decryptAndParseDrillResults(
  File enc,
  List surveyResults,
  String pID,
  RSAPrivateKey privKey,
) {
  // decrypt
  final plaintext = RSAimplement.rsaDecrypt(privKey, enc.readAsBytesSync());
  // decode
  final drillResults =
      jsonDecode(String.fromCharCodes(plaintext)) as Map<String, dynamic>;
  // parse
  for (final taskResult in drillResults['taskResults']) {
    // get survey results
    if (taskResult['taskType'] == 'survey') {
      surveyResults.add({
        'participantID': pID,
        'taskID': taskResult['taskID'],
        'surveyTitle': taskResult['title'],
        'surveyAnswers': taskResult['surveyAnswersJson'],
      });
    }
    // extend here for other types of task results
  }
}

String? _getPubKeyAttachedToResults(String zipPath) {
  final inputStream = InputFileStream(zipPath);
  final archive = ZipDecoder().decodeBuffer(inputStream);
  final accessResultsJsonFiles =
      archive.files.where((element) => element.name == 'accessRecord.json');
  if (accessResultsJsonFiles.isNotEmpty) {
    final accessResultsJson =
        jsonDecode(String.fromCharCodes(accessResultsJsonFiles.first.content))
            as Map<String, dynamic>;
    return accessResultsJson['publicKey'];
  }
  return null;
}

bool _confirmEncDecLoop(RSAPrivateKey privKey, RSAPublicKey pubKey) {
  const plaintext = 'do these bytes come out the other side?';
  final ciphertext =
      RSAimplement.rsaEncrypt(pubKey, Uint8List.fromList(plaintext.codeUnits));
  try {
    final decBytes = RSAimplement.rsaDecrypt(privKey, ciphertext);
    final looptext = String.fromCharCodes(decBytes);
    return looptext == plaintext;
  } catch (e) {
    print(e);
    print(e.runtimeType);
    return false;
  }
}
/// No longer parsing to csv for the time being until we confirm with them
/// what format they actually want
// // create results.csv
// final csv = File('${outputDir.path}/results.csv');
// if (csv.existsSync()) csv.deleteSync();
// csv.createSync();
// // and the state to hold the content prior to write
// List<List<dynamic>> csvRows = [];

// // create stringified csv data
// String csvString = const ListToCsvConverter().convert(csvRows);
// // write it to the file
// csv.writeAsStringSync(csvString);


/// TODO: overhaul this parse function according to "new" DrillDetails formatting
/// TODO: set up the csv header based on the DrillDetails formatting in a different
///       function
// void _parseResultsJson(dir, privKey, firstEntry, csvRows) {
//   // add results to csv
//   // get the json as a Map
//   final resultsJsonEncFile =
//       File('${dir.path}/${basename(dir.path)}-results.json.enc');
//   if (resultsJsonEncFile.existsSync()) {
//     final results = jsonDecode(String.fromCharCodes(RSAimplement.rsaDecrypt(
//       privKey,
//       resultsJsonEncFile.readAsBytesSync(),
//     ))) as Map<String, dynamic>;

//     // parse into csv row
//     // should this parse should be implemented in a model class somewhere?
//     // parse the values of the List into a new csv row (as string)
//     var firstRow = ['uuid', 'preDrillSurveyAnswers'];
//     var row = [basename(dir.path), ''];

//     if (results.containsKey('answers')) {
//       bool stillPreDrill = true;
//       for (final answer in results['answers']) {
//         if (stillPreDrill && answer['survey'] == 'postDrillSurvey') {
//           stillPreDrill = false;
//           if (firstEntry) firstRow.add('postDrillSurveyAnswers');
//           row.add('');
//         }
//         if (firstEntry) firstRow.add(answer['type']);
//         row.add(answer['response']);
//       }
//     }

//     if (results.containsKey('timeElapsed')) {
//       if (firstEntry) firstRow.add('timeElapsed');
//       row.add(results['timeElapsed']);
//     }

//     // add row list(s) to csvRows
//     if (firstEntry) csvRows.add(firstRow);
//     csvRows.add(row);
//     firstEntry = false;
//   }
// }
