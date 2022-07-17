import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proyecto/providers/categories_provider.dart';
import 'package:proyecto/providers/cities_provider.dart';
import 'package:proyecto/providers/equipos_provider.dart';
import 'package:proyecto/src/models/category.dart';
import 'package:proyecto/src/models/equipos.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:proyecto/src/pages/administrator/create/equipos/details/details_create_page.dart';
import 'package:proyecto/src/utils/shared_pref.dart';

class CerrarSesion{

  BuildContext? context;
  final SharedPref _sharedPref = SharedPref();
  Function? refresh;

  User? user;
  final CategoriesProvider _categoriesProvider = CategoriesProvider();
  final EquiposProvider _equiposProvider = EquiposProvider();
  final CitiesProvider _citiesProvider = CitiesProvider();
  List<Category> categories = [];

  Future? init(BuildContext context, Function refresh) async{

    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    _categoriesProvider.init(context, user);
    _equiposProvider.init(context, user);
    _citiesProvider.init(context, user);
    getCategories();
    refresh();

  }

  Future<List<Equipos>> getEquipos(String idCategory) async{
    return await _equiposProvider.getByCategory(idCategory);

  }


  void getCategories() async{

    categories = await _categoriesProvider.getAll();
    refresh!();

  }
  void openBottomSheet(Equipos machine){
    showMaterialModalBottomSheet(
        context: context!,
        builder: (_) => EquiposDetailsPage(equipos: machine)
    );
  }

  void logout(){

    _sharedPref.logout(context!, user!.id!);

  }

  void goToUpdatePage(){
    Navigator.pushNamed(context!, 'clientupdate');

  }

  void goToRoles(){
    Navigator.pushNamedAndRemoveUntil(context!, 'roles', (route) => false);
  }

  void goToEdificioCreate(){
    Navigator.pushNamed(context!, 'EdificiosCreatePage');
  }


  void goToEquiposCreate(){
    Navigator.pushNamed(context!, 'EquiposCreatePage');
  }

  void goToEspCreate(){
    Navigator.pushNamed(context!, 'EspCreatePage');
  }

  void goToCategoriaCreate(){
    Navigator.pushNamed(context!, 'CategoriaCreatePage');
  }

  void goToCityCreate(){
    Navigator.pushNamed(context!, 'CityCreatePage');
  }

  void goToEquiposSearch(){
    Navigator.pushNamed(context!, 'EquiposSearchPage');
  }



}