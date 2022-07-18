import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proyecto/providers/categories_provider.dart';
import 'package:proyecto/providers/cities_provider.dart';
import 'package:proyecto/providers/equipos_provider.dart';
import 'package:proyecto/src/models/address.dart';
import 'package:proyecto/src/models/equipos.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:proyecto/src/pages/administrator/create/equipos/history/history_page.dart';
import 'package:proyecto/src/utils/shared_pref.dart';

class EquiposBuildingController{

  EquiposProvider _equiposProvider = new EquiposProvider();
  List<Address> address = [];

  User? user;

  BuildContext? context;
  SharedPref _sharedPref =  new SharedPref();
  Function? refresh;


  // List<Category> categories = [];

  Future? init(BuildContext context, Function refresh) async{

    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    _equiposProvider.init(context, user);
    refresh();

  }


  Future<List<Equipos>> getEquipos(String idCategory) async{
    return await _equiposProvider.getByCategory(idCategory);

  }

  void openBottomSheet(Equipos equipos, BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HistoryPage(equipos: equipos)));

  }

}