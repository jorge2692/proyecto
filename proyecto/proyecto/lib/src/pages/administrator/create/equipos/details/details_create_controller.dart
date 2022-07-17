import 'package:flutter/material.dart';
import 'package:proyecto/providers/esp8266_provider.dart';
import 'package:proyecto/src/models/equipos.dart';
import 'package:proyecto/src/models/esp8266.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:proyecto/src/utils/shared_pref.dart';

class EquiposDetailsController{
  BuildContext? context;
  Function? refresh;

  final Esp8266Provider _esp8266Provider = Esp8266Provider();


  String estado = 'HIGH';
  Esp8266? esp8266;
  Equipos? equipos;
  User? user;
  SharedPref sharedPref = SharedPref();


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
    Future.delayed(const Duration(seconds: 2));
    return await _esp8266Provider.getByMachine(idMachine);
  }

  Future<bool> updateMachineStatus(Esp8266? esp8266)async{
    if(esp8266 == null) return false;
    await _esp8266Provider.update(esp8266);
    return true;
  }

}
