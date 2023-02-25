import 'dart:convert';

// import 'package:flutter/services.dart';
// import 'package:sqflite/sqflite.dart';
import 'package:hive/hive.dart';

import 'package:evac_app/models/participant_location.dart';

class TrajectoryDatabaseManager {
  // static const _DATABASE_FILENAME = 'trajectory.sqlite3.db';
  // static const _SCHEMA_PATH = 'assets/trajectory_schema.sql';
  // static const _SQL_INSERT = 'INSERT INTO trajectory(locationData) VALUES (?)';
  // static const _SQL_SELECT = 'SELECT * FROM trajectory';

  static TrajectoryDatabaseManager? _instance;
  // final Database db;
  Box box;

  // TrajectoryDatabaseManager._({required Database database}) : db = database;
  TrajectoryDatabaseManager._({required Box box}) : box = box;

  factory TrajectoryDatabaseManager.getInstance() {
    assert(_instance != null);
    return _instance!;
  }

  Future<void> insert({required ParticipantLocation location}) async {
    box.add(
        '\t\t\t<trkpt lat="${location.latitude}" lon="${location.longitude}"><ele>${location.elevation}</ele><time>${location.time.toIso8601String()}</time></trkpt>\n');
    // String locJson = jsonEncode(location.toJson());
    // print(locJson);
    // await db.transaction((txn) async {
    //   try {
    //     await txn.rawInsert(
    //       _SQL_INSERT,
    //       [locJson],
    //     );
    //   } on DatabaseException catch (e) {
    //     print(e);
    //   }
    // });
  }

  /// DEPRECATED, use getTrajectoryString
  Future<List<ParticipantLocation>> getTrajectory() async {
    // List<Map> trajectoryDB = await db.rawQuery(_SQL_SELECT);
    List<Map> trajectoryDB = [];
    final ingredients = trajectoryDB.map((r) {
      return ParticipantLocation.fromJson(jsonDecode(r['locationData']));
    }).toList();
    return ingredients;
  }

  Future<List<dynamic>> getTrajectoryStrings() async {
    return await box.toMap().values.toList();
  }

  static Future initialize() async {
    // Database db = await openDatabase(
    //   _DATABASE_FILENAME,
    //   version: 1,
    //   onCreate: (Database db, int version) async {
    //     String schema = await rootBundle.loadString(_SCHEMA_PATH);
    //     createTables(db, schema);
    //   },
    // );
    // _instance = TrajectoryDatabaseManager._(database: db);

    Box box = await Hive.openBox('trajectory');
    _instance = TrajectoryDatabaseManager._(box: box);
  }

  Future<void> wipeData() async {
    // await deleteDatabase(_DATABASE_FILENAME);
    await box.clear();
    return await initialize();
  }

  // static void createTables(Database db, String sql) async {
  //   await db.execute(sql);
  // }
}
