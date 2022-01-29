//
// import 'package:perro/maquina.dart';
// import 'maquina.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
//
// class DB{
//
//   static Future<Database> _openDB() async{
//
//     return openDatabase(join(await getDatabasesPath(), 'maquinas.db'),
//       onCreate: (db, version){
//         return db.execute(
//           "CREATE TABLE maquinas (id INTEGER PRIMARY KEY, serial TEXT, fecha TEXT )"
//         );
//       },
//     version: 1);
//   }
//
//   static Future<void> insert (Maquina maquina) async{
//
//     Database database = await _openDB();
//
//     return database.insert("maquinas", maquina.toMap());
//
//   }
//
//   static Future<void> delete (Maquina maquina) async{
//
//     Database database = await _openDB();
//
//     return database.delete("maquinas", where: "id: ?", whereArgs: [maquina.id]);
//
//   }
//
//   static Future<void> update (Maquina maquina) async{
//
//     Database database = await _openDB();
//
//     return database.update("maquinas", where: "id: ?", whereArgs: [maquina.id]);
//
//   }
//   static Future<List<Maquina>> maquinas() async{
//     Database database = await _openDB();
//     final List<Map<String, dynamic>> maquinasMap = await database.query("maquinas");
//
//
//     return List.generate(maquinasMap.length,
//             (i) => Maquina(
//
//               id: maquinasMap[i]['id'],
//               serial: maquinasMap[i]['serial'],
//               fecha: maquinasMap[i]['fecha'],
//             )
//     );
//   }
//
//
//
// }