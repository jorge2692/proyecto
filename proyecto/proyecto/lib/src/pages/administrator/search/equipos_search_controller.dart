import 'package:flutter/material.dart';
import 'package:proyecto/providers/cities_provider.dart';
import 'package:proyecto/src/models/city.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:proyecto/src/utils/shared_pref.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class EquiposSearchController{

  BuildContext? context;
  Function? refresh;


  CitiesProvider _citiesProvider = new CitiesProvider();
  User? user;
  SharedPref sharedPref= new SharedPref();

  List<City> cities = [];

  String? idCity;


  ProgressDialog? _progressDialog;

  Future? init(BuildContext context, Function refresh) async {

    this.context = context;
    this.refresh = refresh;
    _progressDialog = new ProgressDialog(context: context);
    user = User.fromJson(await sharedPref.read('user'));


    _citiesProvider.init(context, user);
    getCities();

  }

  void getCities()async{
    cities = await _citiesProvider.getAll();
    refresh!();
  }

}


