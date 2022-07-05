import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDatabase {
  Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialData();
      return _db;
    } else {
      return _db;
    }
  }

  initialData() async {
    var databasePath = await getDatabasesPath();
    String path = await join(databasePath, 'abd2.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print('================= NEW VERISON CREATED');
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
   CREATE TABLE "users" (
      "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "userName" TEXT NOT NULL,
      "password" TEXT NOT NULL
      )
    ''');
    print('================= SQL CREATED');
  }

  readData(String sql) async {
    Database? mydb = await db;
    var res = await mydb!.rawQuery(sql);
    return res;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    var res = await mydb!.rawInsert(sql);
    return res;
  }

  updataData(String sql) async {
    Database? mydb = await db;
    var res = await mydb!.rawUpdate(sql);
    return res;
  }

  delateData(String sql) async {
    Database? mydb = await db;
    var res = await mydb!.rawDelete(sql);
    return res;
  }

  ////
  ////
  ///////////////////
  /////
  //// طريقة ثاانوية للكتابة
//   read(String table) async {
//     Database? mydb = await db;
//     var res = await mydb!.query(table);

//     return res;
// //    _sql.read('users') // يكفي فقط كتابة اسم الجدول
//   }

//   insert(String table, Map<String, String> values) async {
//     Database? mydb = await db;
//     var res = await mydb!.insert(table, values);
//     return res;
//     // _sql.insert('notes', {
//     //   'userName' : 'New Uesr Name',
//     //   'password' : 'New Password',
//     // });
//   }

//   updata(String table, Map<String, String> values, myWhere) async {
//     Database? mydb = await db;
//     var res = await mydb!.update(table, values, where: myWhere);
//     return res;
//     // _sql.update('notes', {
//     //   'userName' : 'New Uesr Name',
//     //   'password' : 'New Password',
//     // },
//     // " id = ${widget.id} ");
//   }

//   delate(String table, myWhere) async {
//     Database? mydb = await db;
//     var res = await mydb!.delete(table, where: myWhere);
//     return res;
//   }

}
