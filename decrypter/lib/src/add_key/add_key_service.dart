import 'dart:io';

class AddKeyService {
  static getPemStringFromFilePath(filePath) {
    if (File(filePath).existsSync()) {
      return File(filePath).readAsStringSync();
    }
    return null;
  }
}
