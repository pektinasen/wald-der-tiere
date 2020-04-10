import 'dart:async';
import 'dart:io';

import 'package:optional/optional.dart';
import 'package:path/path.dart';
import 'package:tuple/tuple.dart';
import 'package:sqflite/sqflite.dart';

class Datastore {
  Database _db;
  
  Datastore();

  var _tableItems = "items";

  Future<void> open() async {
    // Open the database and store the reference.

    final Future<Database> database = openDatabase(
        // Set the path to the database. Note: Using the `join` function from the
        // `path` package is best practice to ensure the path is correctly
        // constructed for each platform.
        join(await getDatabasesPath(), 'wald-der-tiere.db'),

        onCreate: (db, version) =>
            // Run the CREATE TABLE statement on the database.
            db.execute(
              """CREATE TABLE items(
                item_uuid TEXT,
                checked BOOLEAN
              )
            """,
            ),
        version: 1);
    _db = await database;
    return ;
  }

  Future<void> close() async {
    await _db.close();
  }

  Future<int> _count(String itemUuid) async =>
      Sqflite.firstIntValue(await _db.rawQuery(
          """SELECT count(*) FROM $_tableItems WHERE item_uuid = ?""",
          [itemUuid]));

  Future<void> _check(String itemUuid, bool check) async => _db.rawUpdate("""
        UPDATE items 
        SET checked = ?
        WHERE item_uuid = ?
      """, [itemUuid, check]);

  Future<void> checkItem(String itemUuid) async {
    var count = await _count(itemUuid);
    if (count > 0) {
      _check(itemUuid, true);
    } else {
      _db.rawInsert("""
        INSERT INTO items(item_uuid, checked) 
        VALUES (?,?)
      """, [itemUuid, true]);
    }
  }

  void uncheckItem(String itemUuid) async => 
    _db.rawInsert("""
        INSERT INTO items(item_uuid, checked) 
        VALUES (?,?)
      """, [itemUuid, false]);

  Future<List<Tuple2<String, bool>>> allChecked() async {
    var list = await _db.query(_tableItems,
        columns: ['item_uuid', 'checked'],
        where: 'checked');
    return list.map((item) => Tuple2<String,bool>(item['item_uuid'], intToBool(item['checked']))).toList();
  }

  final intToBool = (i) => i != 0; 

  Future<Optional<Tuple2<String, bool>>> getItem(String uuid)  async  {
    List<Map<String, dynamic>> result = await _db.query(_tableItems, columns: ['item_uuid,checked'], where : 'item_uuid = ?', whereArgs: [uuid]);
    if (result.isEmpty) {
      return Optional.empty();
    } else {
      return Optional.of(Tuple2(result[0].toString(), true));
    }
    
  }

  Future<void> deleteItems() async {
    print("delete all");
    return _db.delete(_tableItems );
  }

}