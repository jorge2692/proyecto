import 'package:flutter/material.dart';
import 'package:proyecto/src/models/equipos.dart';

class EquiposDetailsController{
  BuildContext? context;
  Function? refresh;

  String estado = 'HIGH';
  var encendido = 0;
  Equipos? equipos;

  Future? init(BuildContext context, Function refresh, Equipos equipos){
    this.context= context;
    this.refresh= refresh;
    this.equipos = equipos;

    refresh();

  }

  void suma(){
    if(encendido == 0){
      encendido = 1;
      estado = 'HIGH';
      print(encendido);
      print(estado);

    }
    else{
      encendido = 0;
      estado = 'LOW';
      print(encendido);
      print(estado);


    }


  }

}
