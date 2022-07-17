import 'package:flutter/material.dart';
import 'package:proyecto/providers/address_provider.dart';
import 'package:proyecto/providers/cities_provider.dart';
import 'package:proyecto/src/models/city.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:proyecto/src/utils/shared_pref.dart';
import 'package:proyecto/src/models/address.dart';


class EquiposSearchController{

  BuildContext? context;
  Function? refresh;


  final CitiesProvider _citiesProvider = CitiesProvider();
  final AddressProvider _addressProvider = AddressProvider();

  User? user;
  SharedPref sharedPref = SharedPref();

  List<City> cities = [];
  List<Address> edificios = [];
  List<Address> address = [];

  String? idCity;
  String? nameAddress;

  Future? init(BuildContext context, Function refresh) async {

    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await sharedPref.read('user'));


    _citiesProvider.init(context, user);
    _addressProvider.init(context, user);
    getCities();

  }

  void getCities()async{
    cities = await _citiesProvider.getAll();
    refresh!();
  }

  void getEdificios(String idCiudad) async {
    edificios = await _addressProvider.findByBuild(idCiudad);
    refresh!();

  }

  void goToHistoryPage(){
    Navigator.pushNamed(context!, 'HistoryPage');
  }

}


