import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:proyecto/providers/categories_provider.dart';
import 'package:proyecto/providers/address_provider.dart';
import 'package:proyecto/providers/esp8266_provider.dart';
import 'package:proyecto/src/models/category.dart';
import 'package:proyecto/src/models/address.dart';
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

  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  Esp8266Provider _esp8266Provider = new Esp8266Provider();
  AddressProvider _addressProvider = new AddressProvider();
  User? user;
  SharedPref sharedPref= new SharedPref();

  List<Category> categories = [];
  List<Address> address = [];

  String? idCategory;
  String? idAddress;


  ProgressDialog? _progressDialog;

  Future? init(BuildContext context, Function refresh) async {

    this.context = context;
    this.refresh = refresh;
    _progressDialog = new ProgressDialog(context: context);
    user = User.fromJson(await sharedPref.read('user'));
    _categoriesProvider.init(context, user);
    _addressProvider.init(context, user);
    _esp8266Provider.init(context, user);
    getCategories();
    getAddress();

  }

  void getCategories() async {
    categories = await _categoriesProvider.getAll();
    refresh!();

  }

  void getAddress() async {
    address = await _addressProvider.getAll();
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
    

    if(idCategory == null){

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

        idCategory: int.parse(idCategory!),
        idAddress: int.parse(idAddress!)
    );



    _progressDialog!.show(max: 100, msg: 'Espere un momento');
    Stream? stream = await _esp8266Provider.create(esp8266);
    stream!.listen((res) {
      _progressDialog!.close();

      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      MySnackbar.show(context!, responseApi.message!);

      if (responseApi.success!) {

        resetValues();

      }

    });

    print('Formulario Equipos: ${esp8266.toJson()}');


  }

  void resetValues(){

    idEspController.text = '';
    ssidController.text = '';
    passwordController.text = '';


    idCategory = null;
    idAddress = null;
    refresh!();

  }
  
}
