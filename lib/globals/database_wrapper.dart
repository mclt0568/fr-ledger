import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqflite.dart';

class DatabaseWrapper {
  // Singleton Attributes
  static final DatabaseWrapper _database = DatabaseWrapper._internal();
  factory DatabaseWrapper() {
    return _database;
  }
  DatabaseWrapper._internal();
  // Singleton Attributes End

  late Database db;

  List<String> defaultTables = [
    "Ledger",
    "LedgerTag",
    "Commit",
    "CurrencyDict"
  ];

  // For development only.
  Future<String> getDefaultCreateSchema(BuildContext ctx) async {
    String rawJson = await DefaultAssetBundle.of(ctx)
        .loadString("assets/default_sql_schema.json");
    Map parsedSchema = jsonDecode(rawJson);
    Map tables = parsedSchema["tables"];
    String rawSqlStatement = "";
    for (var table in tables.keys) {
      List columns = parsedSchema["tables"][table];
      List primaryKeys = [];
      rawSqlStatement += "CREATE TABLE $table(";
      for (int columnIndex = 0; columnIndex < columns.length; columnIndex++) {
        var column = columns[columnIndex];
        String columnName = column['name'];
        String columnType = column['type'];
        String columnModifiers = column['modifiers'];
        rawSqlStatement += "$columnName $columnType $columnModifiers";
        if (column["primaryKey"]) {
          primaryKeys.add(columnName);
        }
      }
      String primaryKeyDelimited = primaryKeys.join(",");
      rawSqlStatement += "PRIMARY KEY ($primaryKeyDelimited));";
    }
    return rawSqlStatement;
  }

  Future<void> loadDatabase(BuildContext ctx) async {
    db = await openDatabase(join(await getDatabasesPath(), "defaultStorage.db"),
        onCreate: ((db, version) {
      db.execute(
          "CREATE TABLE Ledger(l_id TEXT l_name TEXT l_currency TEXT l_timezoneshift TEXT l_defaultplannedexp REAL PRIMARY KEY (l_id));CREATE TABLE LedgerTag(l_id TEXT t_id TEXT t_name TEXT PRIMARY KEY (l_id,t_id));CREATE TABLE Commit(c_id TEXT l_id TEXT c_type TEXT c_source TEXT c_amount REAL c_datetime TEXT c_title TEXT c_description TEXT c_tag TEXT c_editdatetime TEXT PRIMARY KEY (c_id,l_id));CREATE TABLE CurrencyDict(cd_id TEXT cd_symbol TEXT PRIMARY KEY (cd_id));");
    }));
  }
}
