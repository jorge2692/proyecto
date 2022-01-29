


class Maquina {

  int ? id;
  String ? serial;
  DateTime ? fecha;


  Maquina({this.id, this.serial, this.fecha});

  Map<String, dynamic> toMap(){
    return {'id': id, 'Serial': serial, 'Fecha': fecha};
  }

}