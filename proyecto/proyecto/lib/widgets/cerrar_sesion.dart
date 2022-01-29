import 'package:flutter/material.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:proyecto/src/utils/shared_pref.dart';

class CerrarSesion{

  BuildContext? context;
  SharedPref _sharedPref =  new SharedPref();
  Function? refresh;

  User? user;

  Future? init(BuildContext context, Function refresh) async{

    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    refresh();

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

  void goToCategoriaCreate(){
    Navigator.pushNamed(context!, 'CategoriaCreatePage');
  }

}