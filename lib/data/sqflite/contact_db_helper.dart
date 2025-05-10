import 'dart:convert';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spam_delection_app/data/models/call_logs/call_logs_model.dart';
import 'package:spam_delection_app/data/models/contact/contact_list_response.dart';
import 'package:sqflite/sqflite.dart';

class ContactDBHelper {
  static const _databaseName = "ContactDatabase.db";
  static const _databaseVersion = 1;
  static const table = 'contacts';
  static const columnId = 'id';
  static const columnDeviceContactId = 'device_contact_id';
  static const columnName = 'name';
  static const columnCountryCode = 'country_code';
  static const columnNumberType = 'number_type';
  static const columnMobileNo = 'mobile_no';
  static const columnIsSpam = 'is_spam';
  static const columnCategory = 'category';
  static const columnMarkSpamByUser = 'markspambyuser';
  static const columnIsRegistered = 'is_registered';
  static const columnIsBlocked = 'is_blocked';
  static const columnSpamReport = 'spam_report';
  static const columnCallActivity = 'call_activity';
  static const columnUsuallyCalls = 'usually_calls';
  static const columnLastSeen = 'last_seen';
  static const columnIsOnline = 'is_online';
  static const columnCallHistory = 'call_history'; // Store as JSON
  static const columnEmail = 'email';
  static const columnSynced = 'synced';
  static const columnIsMarkedSpamByMe = 'ismarkbyme';

  // Make this a singleton class
  ContactDBHelper._privateConstructor();
  static final ContactDBHelper instance = ContactDBHelper._privateConstructor();

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
      CREATE TABLE $table (
        $columnId TEXT PRIMARY KEY,
        $columnDeviceContactId TEXT,
        $columnName TEXT,
        $columnCountryCode TEXT,
        $columnNumberType TEXT,
        $columnMobileNo TEXT,
        $columnIsSpam INTEGER,
        $columnCategory TEXT,
        $columnMarkSpamByUser INTEGER,
        $columnIsRegistered TEXT,
        $columnIsBlocked INTEGER,
        $columnSpamReport TEXT,
        $columnCallActivity TEXT,
        $columnUsuallyCalls TEXT,
        $columnLastSeen TEXT,
        $columnIsOnline TEXT,
        $columnCallHistory TEXT,
        $columnEmail TEXT,
        $columnSynced INTEGER,
        $columnIsMarkedSpamByMe INTEGER
      )
    ''');
  }

  // Helper methods to insert, query, update, and delete contacts

  Future<int> insert(ContactData contact) async {
    Database db = await instance.database;
    return await db.insert(table, _contactToMap(contact));
  }

  Future<List<ContactData>> getAllContacts() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return maps.map((map) => _contactFromMap(map)).toList();
  }

  Future<ContactData?> getContact(String id, {int? limit, int? start}) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query(
      table,
      where: '$columnMobileNo = ?',
      whereArgs: [id],
      limit: limit,
      offset: start,
      orderBy: '$columnName ASC',
    );
    if (results.isNotEmpty) {
      return _contactFromMap(results.first);
    }
    return null;
  }

  Future<ContactData?> getContactByPhone(String phone,
      {int? limit, int? start}) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query(
      table,
      where: '$columnMobileNo = ?',
      whereArgs: [phone],
      limit: limit,
      offset: start,
      orderBy: '$columnName ASC',
    );
    if (results.isNotEmpty) {
      return _contactFromMap(results.first);
    }
    return null;
  }

  Future<int> update(ContactData contact) async {
    Database db = await instance.database;
    return await db.update(
      table,
      _contactToMap(contact),
      where: '$columnMobileNo = ?',
      whereArgs: [contact.mobileNo],
    );
  }

  Future<int> delete(String id) async {
    Database db = await instance.database;
    return await db.delete(
      table,
      where: '$columnMobileNo = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteDatabase1() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    await deleteDatabase(path);
    _database = null; // Reset the _database instance
    print('Database deleted successfully!');
  }

  // Helper functions to convert ContactData to and from Map
  Map<String, dynamic> _contactToMap(ContactData contact) {
    return {
      columnDeviceContactId: contact.deviceContactId,
      columnId: contact.mobileNo,
      columnName: contact.name,
      columnCountryCode: contact.countryCode,
      columnNumberType: contact.numberType,
      columnMobileNo: contact.mobileNo,
      columnIsSpam: contact.isSpam,
      columnCategory: contact.category,
      columnMarkSpamByUser: contact.markspambyuser,
      columnIsRegistered: contact.isRegistered,
      columnIsBlocked: contact.isBlocked,
      columnSpamReport: contact.spamReport,
      columnCallActivity: contact.callActivity,
      columnUsuallyCalls: contact.usuallyCalls,
      columnLastSeen: contact.lastSeen,
      columnIsOnline: contact.isOnline,
      columnCallHistory: contact.callHistory != null
          ? jsonEncode(contact.callHistory!.map((e) => e.toJson()).toList())
          : null,
      columnEmail: contact.email,
      columnSynced: contact.synced ? 1 : 0,
      columnIsMarkedSpamByMe: contact.isMarkedSpamByMe ? 1 : 0
    };
  }

  ContactData _contactFromMap(Map<String, dynamic> map) {
    return ContactData(
      id: map[columnId],
      deviceContactId: map[columnDeviceContactId],
      name: map[columnName],
      countryCode: map[columnCountryCode],
      numberType: map[columnNumberType],
      mobileNo: map[columnMobileNo],
      isSpam: map[columnIsSpam],
      category: map[columnCategory],
      markspambyuser: map[columnMarkSpamByUser],
      isRegistered: map[columnIsRegistered],
      isBlocked: map[columnIsBlocked],
      spamReport: map[columnSpamReport],
      callActivity: map[columnCallActivity],
      usuallyCalls: map[columnUsuallyCalls],
      lastSeen: map[columnLastSeen],
      isOnline: map[columnIsOnline],
      callHistory: map[columnCallHistory] != null
          ? (jsonDecode(map[columnCallHistory]) as List)
              .map((e) => CallLogData.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      email: map[columnEmail],
      synced: map[columnSynced] == 1,
      isMarkedSpamByMe: map[columnIsMarkedSpamByMe] == 1,
    );
  }

  Future<List<ContactData>> getUnsyncedContacts(
      {int? limit, int? start}) async {
    Database db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query(
      table,
      where: '$columnSynced = ?',
      whereArgs: [0],
      limit: limit,
      offset: start,
      orderBy: '$columnName ASC',
    );

    return maps.map((map) => _contactFromMap(map)).toList();
  }
}
