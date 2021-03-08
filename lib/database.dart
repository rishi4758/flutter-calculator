import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableName = "todom";
final String Column_id = "id";
final String total = "total";

class TaskModel {
  final String total;
  int id;

  TaskModel({this.total, this.id});

  Map<String, dynamic> toMap() {
    return {total: this.total};
  }
}

class TodoHelper {
  Database db;

  TodoHelper() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    db = await openDatabase(join(await getDatabasesPath(), "databse.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE $tableName($Column_id INTEGER PRIMARY KEY AUTOINCREMENT, $total TEXT)");
    }, version: 1);
  }

  Future<void> insertTask(TaskModel task) async {
    // var result = await db.insert(tableName, task.toMap());
    // print('result : $result');

    try {
      print(task.total);
      // db.insert(tableName, task.toMap(),
      db.execute(
          "  INSERT INTO $tableName([($Column_id ,$total) ]VALUES( 1,	task.total) ");
      // conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (_) {
      print(_);
    }
  }
}

// import "./models/alarm_info.dart";
// import 'dart:async';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// final String tableAlarm = 'calculator';
// final String columnId = 'id';
// final String columnTotal = 'total';

// class DBProvider {
//   static Database _database;
//   static DBProvider _alarmHelper;

//   DBProvider._createInstance();
//   factory DBProvider() {
//     if (_alarmHelper == null) {
//       _alarmHelper = DBProvider._createInstance();
//     }
//     return _alarmHelper;
//   }

//   Future<Database> get database async {
//     if (_database == null) {
//       _database = await initializeDatabase();
//     }
//     return _database;
//   }

//   Future<Database> initializeDatabase() async {
//     var dir = await getDatabasesPath();
//     var path = dir + "alarm.db";

//     var database = await openDatabase(
//       path,
//       version: 3,
//       onCreate: (db, version) {
//         db.execute('''
//           create table $tableAlarm (
//           $columnId integer primary key autoincrement,
//           $columnTotal text not null,

//         ''').then((value) => print("can not executesss"));
//       },
//     );
//     print("$database ddkdjd");
//     return database;
//   }

//   void insertAlarm(AlarmInfo alarmInfo) async {
//     var db = await this.database;
//     var result = await db.insert(tableAlarm, alarmInfo.toJson());
//     print('result : $result');
//   }
// }
