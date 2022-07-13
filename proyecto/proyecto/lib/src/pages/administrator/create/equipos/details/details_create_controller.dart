import 'package:flutter/material.dart';
import 'package:proyecto/providers/esp8266_provider.dart';
import 'package:proyecto/src/models/equipos.dart';
import 'package:proyecto/src/models/esp8266.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:proyecto/src/utils/shared_pref.dart';

class EquiposDetailsController{
  BuildContext? context;
  Function? refresh;

  Esp8266Provider _esp8266Provider = new Esp8266Provider();


  String estado = 'HIGH';
  Esp8266? esp8266;
  Equipos? equipos;
  User? user;
  SharedPref sharedPref= new SharedPref();


  Future? init(BuildContext context, Function refresh, Equipos equipos) async {
    this.context= context;
    this.refresh= refresh;
    this.equipos = equipos;
    user = User.fromJson(await sharedPref.read('user'));
    esp8266 = Esp8266.fromJson(await sharedPref.read('esp8266'));
    _esp8266Provider.init(context, user);

    refresh();

  }

  Future<Esp8266?> getEspByMachine(String idMachine) async{
    Future.delayed(Duration(seconds: 2));
    return await _esp8266Provider.getByMachine(idMachine);
    String? gpio0Update = esp8266!.idEsp;

  }

  Future<bool> updateMachineStatus(Esp8266? esp8266)async{
    if(esp8266 == null) return false;
    await _esp8266Provider.update(esp8266);
    return true;
  }


  void suma() async{
    /*// String? gpio0Update = esp8266!.idEsp;
    if(gpio0Update == true){
      gpio0Update = 'false';
    }
    else{
      gpio0Update = 'true';
    }


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


    }*/


  }

}
