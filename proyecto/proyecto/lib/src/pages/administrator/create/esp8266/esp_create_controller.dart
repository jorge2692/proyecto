import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyecto/providers/address_provider.dart';
import 'package:proyecto/providers/cities_provider.dart';
import 'package:proyecto/providers/equipos_provider.dart';
import 'package:proyecto/providers/esp8266_provider.dart';
import 'package:proyecto/src/models/address.dart';
import 'package:proyecto/src/models/city.dart';
import 'package:proyecto/src/models/equipos.dart';
import 'package:proyecto/src/models/esp8266.dart';
import 'package:proyecto/src/models/response_api.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:proyecto/src/utils/my_snackbar.dart';
import 'package:proyecto/src/utils/shared_pref.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class EspCreateController {

  BuildContext? context;

  TextEditingController idEspController = new TextEditingController();
  TextEditingController ssidController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  Function? refresh;

  EquiposProvider _equiposProvider = new EquiposProvider();
  Esp8266Provider _esp8266Provider = new Esp8266Provider();
  AddressProvider _addressProvider = new AddressProvider();
  CitiesProvider _citiesProvider = new CitiesProvider();
  User? user;
  SharedPref sharedPref= new SharedPref();

  List<Address> edificios = [];
  List<Address> address = [];
  List<City> cities = [];
  List<Equipos> equipos = [];



  String? idAddress;
  String? idCity;
  String? idLavanti;


  ProgressDialog? _progressDialog;

  Future? init(BuildContext context, Function refresh) async {

    this.context = context;
    this.refresh = refresh;
    _progressDialog = new ProgressDialog(context: context);
    user = User.fromJson(await sharedPref.read('user'));

    _equiposProvider.init(context, user);
    _addressProvider.init(context, user);
    _citiesProvider.init(context, user);
    _esp8266Provider.init(context, user);
    getCities();

  }





  void getEquipos(String idBuilding) async {
    equipos = await _equiposProvider.getByBuilding(idBuilding);
    refresh!();

  }


  void getEdificios(String idCiudad) async {
    edificios = await _addressProvider.findByBuild(idCiudad);
    refresh!();

  }

  void getAddress() async {
    address = await _addressProvider.getAll();
    refresh!();

  }

  void getCities()async{
    cities = await _citiesProvider.getAll();
    refresh!();
  }

  void createEsp8266() async {
    String idesp = idEspController.text;
    String ssid = ssidController.text;
    String password = passwordController.text;


    if(idesp.isEmpty || ssid.isEmpty || password.isEmpty){
      MySnackbar.show(context!,'Ingresar todos los campos');
      return;
    }
    

    if(idLavanti == null){

      MySnackbar.show(context!,'Seleccionar la categoria del producto');
      return;

    }

    if(idAddress == null){

      MySnackbar.show(context!,'Seleccionar el Edificio');
      return;

    }



    Esp8266? esp8266 = new Esp8266(

        idEsp: idesp,
        ssid: ssid,
        password: password,
        idLavanti: int.parse(idLavanti??'0'),



    );



    _progressDialog!.show(max: 100, msg: 'Espere un momento');
    ResponseApi? responseApi = await _esp8266Provider.create(esp8266);

    MySnackbar.show(context!, responseApi?.message??'Response');
    _progressDialog?.close();

    if (responseApi?.success??false) {

      resetValues();

    }


    print('Formulario Equipos: ${esp8266.toJson()}');


  }

  void resetValues(){

    idEspController.text = '';
    ssidController.text = '';
    passwordController.text = '';


    idAddress = null;
    idLavanti = null;
    idCity = null;
    refresh!();

  }
  
}
