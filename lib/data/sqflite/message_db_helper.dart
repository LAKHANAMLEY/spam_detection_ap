import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:spam_delection_app/models/sms/sms_list_model.dart';
import 'package:sqflite/sqflite.dart'; // For DateTime formatting

class SmsLogDBHandler {
  static const String _databaseName = "sms_log_database.db";
  static const int _databaseVersion = 1;

  static const String tableSmsLog = "sms_log";
  static const String columnLogId = "id";
  static const String columnAddress = "address";
  static const String columnCountryCode = "country_code";
  static const String columnUnreadReceivedSms = "unread_received_sms";
  static const String columnName = "name";
  static const String columnIsMarkSpam = "is_mark_spam";

  static const String tableSmsDetail = "sms_detail";
  static const String columnDetailId = "_detail_id";
  static const String columnLogIdFk = "log_id_fk";
  static const String columnBody = "body";
  static const String columnIsRead = "is_read";
  static const String columnMessageState = "message_state";
  static const String columnMessageKind = "message_kind";
  static const String columnQueryKind = "query_kind";
  static const String columnSendReceiveDatetime = "send_receive_datetime";
  static const String columnThreadId = "thread_id";
  static const String columnSmsId = "sms_id"; // Renamed from 'id'
  static const String columnDeviceSmsId = "device_sms_id";
  static const String columnIsSpam = "is_spam";
  static const String columnSpamMessage = "spam_message";
  static const String columnScore = "score";
  static const String columnIsManually = "is_manually";
  static const String columnDetailAddress = "address";
  static const String columnDetailCountryCode = "country_code";
  static const String columnDate = "date";
  static const String columnDetailName = "name";

  // Singleton instance
  SmsLogDBHandler._privateConstructor();
  static final SmsLogDBHandler instance = SmsLogDBHandler._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    //AUTOINCREMENT
    await db.execute('''
      CREATE TABLE $tableSmsLog (
        $columnLogId TEXT PRIMARY KEY,
        $columnAddress TEXT,
        $columnCountryCode TEXT,
        $columnUnreadReceivedSms INTEGER,
        $columnName TEXT,
        $columnIsMarkSpam INTEGER,
        $columnIsSpam TEXT,
        $columnDate INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE $tableSmsDetail (
        $columnDetailId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnLogIdFk INTEGER,
        $columnBody TEXT,
        $columnIsRead TEXT,
        $columnMessageState TEXT,
        $columnMessageKind TEXT,
        $columnQueryKind TEXT,
        $columnSendReceiveDatetime INTEGER,
        $columnThreadId TEXT,
        $columnSmsId TEXT,
        $columnDeviceSmsId TEXT,
        $columnIsSpam TEXT,
        $columnIsMarkSpam INTEGER,
        $columnSpamMessage TEXT,
        $columnScore TEXT,
        $columnIsManually TEXT,
        $columnDetailAddress TEXT,
        $columnDetailCountryCode TEXT,
        $columnDate INTEGER,
        $columnDetailName TEXT,
        FOREIGN KEY ($columnLogIdFk) REFERENCES $tableSmsLog ($columnLogId) ON DELETE CASCADE
      )
    ''');
  }

  // Helper to convert DateTime to milliseconds since epoch
  int? _dateTimeToInt(DateTime? dateTime) => dateTime?.millisecondsSinceEpoch;

  // Helper to convert milliseconds since epoch to DateTime
  DateTime? _intToDateTime(int? value) =>
      value == null ? null : DateTime.fromMillisecondsSinceEpoch(value);

  Future<int> insertSmsLog(SmsLog smsLog) async {
    final db = await database;
    final logId = await db.insert(tableSmsLog, {
      columnLogId: smsLog.id,
      columnAddress: smsLog.address,
      columnCountryCode: smsLog.countryCode,
      columnUnreadReceivedSms: smsLog.unreadReceivedSms,
      columnName: smsLog.name,
      columnIsMarkSpam: smsLog.isMarkSpam,
      columnIsSpam: smsLog.isSpam,
      columnDate: _dateTimeToInt(smsLog.date),
    });

    if (smsLog.smsDetails != null) {
      for (final detail in smsLog.smsDetails!) {
        //check exists or not
        final exists = await _getSmsDetailsForLogId(db, detail.id ?? "");
        if (exists.isEmpty) {
          await db.insert(tableSmsDetail, {
            columnLogIdFk: smsLog.id, //TODO: logId
            columnBody: detail.body,
            columnIsRead: detail.isRead,
            columnMessageState: detail.messageState,
            columnMessageKind: detail.messageKind,
            columnQueryKind: detail.queryKind,
            columnSendReceiveDatetime:
                _dateTimeToInt(detail.sendreceiveDatetime),
            columnThreadId: detail.threadId,
            columnSmsId: detail.id,
            columnDeviceSmsId: detail.deviceMessageId,
            columnIsSpam: detail.isSpam,
            columnIsMarkSpam: detail.isMarkSpam,
            columnSpamMessage: detail.spamMessage,
            columnScore: detail.score,
            columnIsManually: detail.isManually,
            columnDetailAddress: detail.address,
            columnDetailCountryCode: detail.countryCode,
            columnDate: _dateTimeToInt(detail.date),
            columnDetailName: detail.name,
          });
        } else {
          await updateSmsDetail(detail);
        }
      }
    }
    return logId;
  }

  // Future<int> updateSmsLog(SmsLog smsLog) async {
  //   final db = await database;

  //   if (smsLog.smsDetails != null) {
  //     for (final detail in smsLog.smsDetails!) {
  //       await db.insert(tableSmsDetail, {
  //         columnLogIdFk: smsLog.id, //TODO: logId
  //         columnBody: detail.body,
  //         columnIsRead: detail.isRead,
  //         columnMessageState: detail.messageState,
  //         columnMessageKind: detail.messageKind,
  //         columnQueryKind: detail.queryKind,
  //         columnSendReceiveDatetime: _dateTimeToInt(detail.sendreceiveDatetime),
  //         columnThreadId: detail.threadId,
  //         columnSmsId: detail.id,
  //         columnIsSpam: detail.isSpam,
  //         columnSpamMessage: detail.spamMessage,
  //         columnScore: detail.score,
  //         columnIsManually: detail.isManually,
  //         columnDetailAddress: detail.address,
  //         columnDetailCountryCode: detail.countryCode,
  //         columnDate: _dateTimeToInt(detail.date),
  //         columnDetailName: detail.name,
  //       });
  //     }
  //   }

  //   return await db.update(
  //     tableSmsLog,
  //     {
  //       columnAddress: smsLog.address,
  //       columnCountryCode: smsLog.countryCode,
  //       columnUnreadReceivedSms: smsLog.unreadReceivedSms,
  //       columnName: smsLog.name,
  //       columnIsMarkSpam: smsLog.isMarkSpam,
  //     },
  //     where: '$columnLogId = ?',
  //     whereArgs: [
  //       // Assuming your SmsLog object has a way to identify the existing record,
  //       // ideally by the auto-incremented ID. If not, you might need to update
  //       // based on a unique field like 'address' (use with caution if not truly unique).
  //       // For proper updating, ensure your SmsLog object carries the ID.
  //       // Example assuming SmsLog has an 'id' property:
  //       // smsLog.id,
  //       // If you don't have an ID in your SmsLog class, you might need to
  //       // update based on a unique identifier like address (if it's guaranteed unique).
  //       // Replace 'smsLog.address' with the actual identifier you want to use.
  //       smsLog.address,
  //     ],
  //   );
  // }

  Future<int> updateSmsLog(SmsLog smsLog) async {
    final db = await database;
    int updatedRows = 0;

    // Ensure the SmsLog has an ID for updating
    if (smsLog.id != null) {
      updatedRows = await db.update(
        tableSmsLog,
        {
          columnAddress: smsLog.address,
          columnCountryCode: smsLog.countryCode,
          columnUnreadReceivedSms: smsLog.unreadReceivedSms,
          columnName: smsLog.name,
          columnIsMarkSpam: smsLog.isMarkSpam,
          columnIsSpam: smsLog.isSpam,
          columnDate: _dateTimeToInt(smsLog.date),
        },
        where: '$columnLogId = ?',
        whereArgs: [smsLog.address],
      );

      if (smsLog.smsDetails != null) {
        // Logic to update or insert SmsDetail records
        for (final detail in smsLog.smsDetails!) {
          // Check if the SmsDetail already exists (you'll need a unique identifier)
          updateSmsDetail(detail);
        }
      }
    } else {
      print('Error: Cannot update SmsLog without an ID.');
    }

    return updatedRows;
  }

  Future<int> updateSmsDetail(SmsDetail detail) async {
    final db = await database;

    // Logic to update or insert SmsDetail records

    // Check if the SmsDetail already exists (you'll need a unique identifier)
    final existingDetail = await db.query(
      tableSmsDetail,
      where:
          '$columnLogIdFk = ? AND $columnDeviceSmsId = ?', // Example: check by logId and smsId
      whereArgs: [
        detail.address,
        detail.deviceMessageId
      ], // Assuming detail.id is somewhat unique
    );

    final smsDetailMap = {
      columnLogIdFk: detail.address,
      columnBody: detail.body,
      columnIsRead: detail.isRead,
      columnMessageState: detail.messageState,
      columnMessageKind: detail.messageKind,
      columnQueryKind: detail.queryKind,
      columnSendReceiveDatetime: _dateTimeToInt(detail.sendreceiveDatetime),
      columnThreadId: detail.threadId,
      columnSmsId: detail.id,
      columnDeviceSmsId: detail.deviceMessageId,
      columnIsSpam: detail.isSpam,
      columnSpamMessage: detail.spamMessage,
      columnScore: detail.score,
      columnIsManually: detail.isManually,
      columnDetailAddress: detail.address,
      columnDetailCountryCode: detail.countryCode,
      columnDate: _dateTimeToInt(detail.date),
      columnDetailName: detail.name,
    };

    if (existingDetail.isNotEmpty) {
      // Update existing SmsDetail
      return await db.update(
        tableSmsDetail,
        smsDetailMap,
        where: '$columnLogIdFk = ? AND $columnDeviceSmsId = ?',
        whereArgs: [detail.address, detail.deviceMessageId],
      );
    } else {
      // Insert new SmsDetail
      return await db.insert(tableSmsDetail, smsDetailMap);
    }
  }

  Future<int> deleteSmsLog(String id) async {
    Database db = await instance.database;
    await deleteSmsDetail(id);
    return await db.delete(
      tableSmsLog,
      where: '$columnLogId = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteSmsDetail(String id) async {
    Database db = await instance.database;
    return await db.delete(
      tableSmsDetail,
      where: '$columnLogIdFk = ?',
      whereArgs: [id],
    );
  }

  Future<SmsLog?> getSmsLog(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableSmsLog,
      columns: [
        columnLogId,
        columnAddress,
        columnCountryCode,
        columnUnreadReceivedSms,
        columnName,
        columnIsMarkSpam,
        columnIsSpam,
        columnDate,
      ],
      where: '$columnLogId = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      final logMap = maps.first;
      final List<SmsDetail> details = await _getSmsDetailsForLogId(db, id);
      return SmsLog(
        id: logMap[columnLogId],
        address: logMap[columnAddress] as String?,
        countryCode: logMap[columnCountryCode] as String?,
        unreadReceivedSms: logMap[columnUnreadReceivedSms] as int?,
        name: logMap[columnName] as String?,
        isMarkSpam: logMap[columnIsMarkSpam] as int?,
        isSpam: logMap[columnIsSpam],
        date: _intToDateTime(logMap[columnDate]),
        smsDetails: details,
      );
    }
    return null;
  }

  Future<List<SmsDetail>> _getSmsDetailsForLogId(
      Database db, String logId) async {
    final List<Map<String, dynamic>> detailMaps = await db.query(tableSmsDetail,
        where: '$columnLogIdFk = ?',
        whereArgs: [logId],
        orderBy: "$columnDate DESC");
    return detailMaps
        .map((detailMap) => SmsDetail(
              body: detailMap[columnBody] as String?,
              isRead: detailMap[columnIsRead] as String?,
              messageState: detailMap[columnMessageState] as String?,
              messageKind: detailMap[columnMessageKind] as String?,
              queryKind: detailMap[columnQueryKind] as String?,
              sendreceiveDatetime:
                  _intToDateTime(detailMap[columnSendReceiveDatetime] as int?),
              threadId: detailMap[columnThreadId] as String?,
              id: detailMap[columnSmsId] as String?,
              deviceMessageId: detailMap[columnDeviceSmsId] as String?,
              isSpam: detailMap[columnIsSpam] as String?,
              isMarkSpam: detailMap[columnIsMarkSpam] as int?,
              spamMessage: detailMap[columnSpamMessage] as String?,
              score: detailMap[columnScore] as String?,
              isManually: detailMap[columnIsManually] as String?,
              address: detailMap[columnDetailAddress] as String?,
              countryCode: detailMap[columnDetailCountryCode] as String?,
              date: _intToDateTime(detailMap[columnDate] as int?),
              name: detailMap[columnDetailName] as String?,
            ))
        .toList();
  }

  Future<List<SmsLog>> getAllSmsLogs() async {
    final db = await database;
    final List<Map<String, dynamic>> logMaps =
        await db.query(tableSmsLog, orderBy: "$columnDate DESC");
    return Future.wait(logMaps.map((logMap) async {
      final String logId = logMap[columnLogId];
      final List<SmsDetail> details = await _getSmsDetailsForLogId(db, logId);
      return SmsLog(
        id: logMap[columnLogId],
        address: logMap[columnAddress] as String?,
        countryCode: logMap[columnCountryCode] as String?,
        unreadReceivedSms: logMap[columnUnreadReceivedSms] as int?,
        name: logMap[columnName] as String?,
        isMarkSpam: logMap[columnIsMarkSpam] as int?,
        isSpam: logMap[columnIsSpam],
        date: _intToDateTime(logMap[columnDate] as int?),
        smsDetails: details,
      );
    }).toList());
  }

  Future<List<SmsLog>> getSmsLogsPaginated({int? start, int? limit}) async {
    final db = await database;
    final List<Map<String, dynamic>> logMaps = await db.query(
      tableSmsLog,
      orderBy: "$columnDate DESC",
      limit: limit,
      offset: start,
    );

    return Future.wait(logMaps.map((logMap) async {
      final String logId = logMap[columnLogId];
      final List<SmsDetail> details = await _getSmsDetailsForLogId(db, logId);
      return SmsLog(
        id: logMap[columnLogId],
        address: logMap[columnAddress] as String?,
        countryCode: logMap[columnCountryCode] as String?,
        unreadReceivedSms: logMap[columnUnreadReceivedSms] as int?,
        name: logMap[columnName] as String?,
        isMarkSpam: logMap[columnIsMarkSpam] as int?,
        isSpam: logMap[columnIsSpam],
        date: _intToDateTime(logMap[columnDate] as int?),
        smsDetails: details,
      );
    }).toList());
  }

  Future<int> deleteTable() async {
    final db = await database;
    return await db.delete(
        tableSmsLog); // Deleting the main table will cascade delete details
  }

  Future<void> deleteDatabase1() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    await deleteDatabase(path);
    _database = null; // Reset the database instance
  }

  String join(String path, String databaseName) => path + databaseName;
}
