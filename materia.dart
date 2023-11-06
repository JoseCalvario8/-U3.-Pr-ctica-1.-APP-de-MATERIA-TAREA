class Materia{
  String idmateria;
  String nombre;
  String semestre;
  String docente;

  Materia({
    required this.idmateria,
    required this.nombre,
    required this.semestre,
    required this.docente,
});

  Map<String, dynamic> toJSON(){
    return{
      "idmateria": idmateria,
      "nombre": nombre,
      "semestre": semestre,
      "docente": docente,
    };
  }
}

class Tarea{
  int idtarea;
  String idmateria;
  String f_entrega;
  String descripcion;

  Tarea({
    required this.idtarea,
    required this.idmateria,
    required this.f_entrega,
    required this.descripcion,
});

  Map<String, dynamic> toJSON(){
    return{
      "idmateria": idmateria,
      "f_entrega": f_entrega,
      "descripcion": descripcion,
    };
  }

}