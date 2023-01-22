import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:evac_drill_console/flutter_flow/lat_lng.dart';

const kMenuCollapsedKey = '__menu_collapsed__';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    _userPrefsBox = await Hive.openBox('userPrefs');
    if (_userPrefsBox.containsKey(kMenuCollapsedKey)) {
      _menuCollapsed = _userPrefsBox.get(kMenuCollapsedKey);
    }
  }

  late Box _userPrefsBox;

  bool _menuCollapsed = false;
  bool get menuCollapsed => _menuCollapsed;
  set menuCollapsed(bool value) {
    _menuCollapsed = value;
    _userPrefsBox.put(kMenuCollapsedKey, value);
    notifyListeners();
  }
}

// LatLng? _latLngFromString(String? val) {
//   if (val == null) {
//     return null;
//   }
//   final split = val.split(',');
//   final lat = double.parse(split.first);
//   final lng = double.parse(split.last);
//   return LatLng(lat, lng);
// }
