import 'package:dam_u3_practica1/materia.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {

  static Future<Database> _abrirDB() async {
    return openDatabase(join(await getDatabasesPath(), "practica1.db"),
        onCreate: (db, version) {
          // Tabla MATERIA
          db.execute(
              "CREATE TABLE MATERIA(IDMATERIA TEXT PRIMARY KEY, NOMBRE TEXT, SEMESTRE TEXT, DOCENTE TEXT)");

          // Tabla TAREA con clave foránea a IDMATERIA en MATERIA
          db.execute(
              "CREATE TABLE TAREA(IDTAREA INTEGER PRIMARY KEY AUTOINCREMENT, IDMATERIA TEXT, F_ENTREGA TEXT, DESCRIPCION TEXT, FOREIGN KEY (IDMATERIA) REFERENCES MATERIA(IDMATERIA))");
        },
        version: 1
    );
  }

  static Future<int> insertarMateria(Materia m) async{
    Database db = await _abrirDB();
    return db.insert("MATERIA", m.toJSON(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Materia>> mostrarMateria() async{
    Database db = await _abrirDB();
    List<Map<String, dynamic>> resultado = await db.query("MATERIA");

    return List.generate(resultado.length, (index) {
      return Materia(
        idmateria: resultado[index]["IDMATERIA"],
        nombre:resultado[index]["NOMBRE"],
        semestre: resultado[index]["SEMESTRE"],
        docente: resultado[index]["DOCENTE"],
      );
    });
  }

  static Future<int> actulizarMateria(Materia m)async{
    Database db = await _abrirDB();

    return db.update("MATERIA", m.toJSON(), where: "IDMATERIA=?", whereArgs: [m.idmateria]);
  }

  static Future<int> eliminarMateria(String idmateria)async{
    Database db = await _abrirDB();

    return db.delete("MATERIA", where: "IDMATERIA=?", whereArgs: [idmateria]);
  }
  //------METODOS PARA TABLA DE TAREA-------

  static Future<int> insertarTarea(Tarea t) async{
    Database db = await _abrirDB();
    return db.insert("TAREA", t.toJSON(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Tarea>> mostrarTarea() async{
    Database db = await _abrirDB();
    List<Map<String, dynamic>> resultado = await db.query("TAREA");

    return List.generate(resultado.length, (index) {
      return Tarea(
        idtarea: resultado[index]["IDTAREA"],
        idmateria:resultado[index]["IDMATERIA"],
        f_entrega: resultado[index]["F_ENTREGA"],
        descripcion: resultado[index]["DESCRIPCION"],
      );
    });
  }

  static Future<int> actulizarTarea(Tarea t)async{
    Database db = await _abrirDB();

    return db.update("TAREA", t.toJSON(), where: "IDTAREA=?", whereArgs: [t.idtarea]);
  }

  static Future<int> eliminarTarea(String idtarea)async{
    Database db = await _abrirDB();

    return db.delete("TAREA", where: "IDTAREA=?", whereArgs: [idtarea]);

  }

}
