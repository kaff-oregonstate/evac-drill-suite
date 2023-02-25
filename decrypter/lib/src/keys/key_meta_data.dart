import 'package:english_words/english_words.dart' as random_words;

class KeyMetaData {
  KeyMetaData({keyName})
      : created = DateTime.now(),
        keyName = keyName ?? random_words.generateWordPairs().first.toString(),
        _lastUsed = null,
        _timesUsed = 0;

  KeyMetaData.fromRecord(
    this.keyName, {
    required this.created,
    required lastUsed,
    required timesUsed,
  })  : _lastUsed = lastUsed,
        _timesUsed = timesUsed;

  factory KeyMetaData.fromJson(Map<String, dynamic> json) {
    return KeyMetaData.fromRecord(
      json['keyName'],
      created: DateTime.parse(json['created']),
      lastUsed: DateTime.tryParse(json['lastUsed'] ?? ''),
      timesUsed: json['timesUsed'],
    );
  }

  Map<String, dynamic> toJson() => {
        'keyName': keyName,
        'created': created.toIso8601String(),
        'lastUsed': _lastUsed?.toIso8601String(),
        'timesUsed': _timesUsed,
      };

  final String keyName;
  final DateTime created;
  DateTime? _lastUsed;
  int _timesUsed;

  int get timesUsed => _timesUsed;

  void incrementTimesUsed() {
    _timesUsed += 1;
  }

  String get privKeyFileName => '$keyName.priv.pem';

  /// no need to save pubKey, as it can be generated from privKey on command
  // String get pubKeyFileName => '$keyName.pub.pem';
}
