import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spam_delection_app/models/call_logs/call_logs_model.dart';
import 'package:sqflite/sqflite.dart';

class CallLogDBHelper {
  static const _databaseName = "CallLogDatabase.db";
  static const _databaseVersion = 1;
  static const callLogTable = 'call_logs';
  static const callLogColumnId = 'id';
  static const callLogColumnPhoneAccountId = 'phoneaccountid';
  static const callLogColumnSimDisplayName = 'simdisplayname';
  static const callLogColumnName = 'name';
  static const callLogColumnCallType = 'call_type';
  static const callLogColumnCountryCode = 'country_code';
  static const callLogColumnMobileNo = 'mobile_no';
  static const callLogColumnCallTime = 'call_time';
  static const callLogColumnCallDuration = 'call_duration';
  static const callLogColumnCallDurationUnit = 'call_duration_unit';
  static const callLogColumnContactListId = 'contact_list_id';
  static const callLogColumnCallDurations = 'call_durations';
  static const callLogColumnIsSpam = 'is_spam';
  static const callLogColumnIsBlocked = 'is_blocked';
  static const callLogColumnMarkSpamByUser = 'markspambyuser';
  static const callLogColumnIsManually = 'is_manually';

  // Make this a singleton class
  CallLogDBHelper._privateConstructor();
  static final CallLogDBHelper instance = CallLogDBHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $callLogTable (
        $callLogColumnId TEXT PRIMARY KEY,
        $callLogColumnPhoneAccountId TEXT,
        $callLogColumnSimDisplayName TEXT,
        $callLogColumnName TEXT,
        $callLogColumnCallType TEXT,
        $callLogColumnCountryCode TEXT,
        $callLogColumnMobileNo TEXT,
        $callLogColumnCallTime TEXT,
        $callLogColumnCallDuration TEXT,
        $callLogColumnCallDurationUnit TEXT,
        $callLogColumnContactListId TEXT,
        $callLogColumnCallDurations TEXT,
        $callLogColumnIsSpam INTEGER,
        $callLogColumnIsBlocked INTEGER,
        $callLogColumnMarkSpamByUser INTEGER,
        $callLogColumnIsManually TEXT
      )
    ''');
  }

  // Call Log Helper Methods

  Future<int> insertCallLog(CallLogData callLog) async {
    Database db = await instance.database;
    return await db.insert(callLogTable, _callLogToMap(callLog));
  }

  Future<List<CallLogData>> getAllCallLogs() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query(callLogTable, orderBy: "$callLogColumnCallTime DESC");
    return maps.map((map) => _callLogFromMap(map)).toList();
  }

  Future<CallLogData?> getCallLog(String id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query(
      callLogTable,
      where: '$callLogColumnId = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return _callLogFromMap(results.first);
    }
    return null;
  }

  Future<int> updateCallLog(CallLogData callLog) async {
    Database db = await instance.database;
    return await db.update(
      callLogTable,
      _callLogToMap(callLog),
      where: '$callLogColumnId = ?',
      whereArgs: [callLog.id],
    );
  }

  Future<int> deleteCallLog(String id) async {
    Database db = await instance.database;
    return await db.delete(
      callLogTable,
      where: '$callLogColumnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllCallLogs() async {
    Database db = await instance.database;
    return await db.delete(
      callLogTable,
    );
  }

  // New method to delete the entire database
  Future<void> deleteDatabase1() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    await deleteDatabase(path);
    _database = null; // Reset the _database instance
    print('Call Log Database deleted successfully!');
  }

  // Helper functions to convert CallLogData to and from Map
  Map<String, dynamic> _callLogToMap(CallLogData callLog) {
    return {
      callLogColumnId: callLog.id,
      callLogColumnPhoneAccountId: callLog.phoneaccountid,
      callLogColumnSimDisplayName: callLog.simdisplayname,
      callLogColumnName: callLog.name,
      callLogColumnCallType: callLog.callType,
      callLogColumnCountryCode: callLog.countryCode,
      callLogColumnMobileNo: callLog.mobileNo,
      callLogColumnCallTime: callLog.callTime?.toIso8601String(),
      callLogColumnCallDuration: callLog.callDuration,
      callLogColumnCallDurationUnit: callLog.callDurationUnit,
      callLogColumnContactListId: callLog.contactListId,
      callLogColumnCallDurations: callLog.callDurations,
      callLogColumnIsSpam: callLog.isSpam,
      callLogColumnIsBlocked: callLog.isBlocked,
      callLogColumnMarkSpamByUser: callLog.markSpamByUser,
      callLogColumnIsManually: callLog.isManually,
    };
  }

  CallLogData _callLogFromMap(Map<String, dynamic> map) {
    return CallLogData(
      id: map[callLogColumnId],
      phoneaccountid: map[callLogColumnPhoneAccountId],
      simdisplayname: map[callLogColumnSimDisplayName],
      name: map[callLogColumnName],
      callType: map[callLogColumnCallType],
      countryCode: map[callLogColumnCountryCode],
      mobileNo: map[callLogColumnMobileNo],
      callTime: map[callLogColumnCallTime] == null
          ? null
          : DateTime.tryParse(map[callLogColumnCallTime]),
      callDuration: map[callLogColumnCallDuration],
      callDurationUnit: map[callLogColumnCallDurationUnit],
      contactListId: map[callLogColumnContactListId],
      callDurations: map[callLogColumnCallDurations],
      isSpam: map[callLogColumnIsSpam],
      isBlocked: map[callLogColumnIsBlocked],
      markSpamByUser: map[callLogColumnMarkSpamByUser],
      isManually: map[callLogColumnIsManually] ?? '0',
    );
  }
}
