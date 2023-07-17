import 'package:notemakngapp/helper/notemodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Future<Database> open() async {
    var dbpath = await getDatabasesPath();
    String path = join(dbpath, 'demo.db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE Todo (id INTEGER PRIMARY KEY AUTOINCREMENT  , title TEXT,subtitle TEXT, done integer )');
      },
    );

    return db;
  }

  Future<bool> insert(NoteModel noteModel) async {
    final Database db = await open();
    await db.insert('Todo', noteModel.toMap());
    return true;
  }

  Future<List<NoteModel>> getnotes() async {
    final db = await open();
    final List<Map<String, Object?>> map = await db.query('Todo');
    return map.map((e) => NoteModel.fromMap(e)).toList();
  }

  Future<bool> updateNote(NoteModel noteModel) async {
    final db = await open();
    await db.update('Todo', noteModel.toMap(),
        where: 'id=?', whereArgs: [noteModel.id]);
    return true;
  }

  Future<bool> deleteNote(int id) async {
    print('gggg      $id');
    final db = await open();
    await db.delete('Todo', whereArgs: [id], where: 'id=?');
    return true;
  }
}
