import 'package:flutter/cupertino.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:proyecto/src/utils/shared_pref.dart';

class RolesController{

  BuildContext? context;

  Function? refresh;

  User? user;
  SharedPref sharedPref = new SharedPref();


  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    user = User.fromJson(await sharedPref.read('user'));
    refresh();

  }

  void goToPage(String route){

    Navigator.pushNamedAndRemoveUntil(context!, route, (route) => false);

  }

}