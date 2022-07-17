import 'package:flutter/material.dart';
import 'package:proyecto/providers/users_provider.dart';
import 'package:proyecto/src/models/response_api.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:proyecto/src/utils/my_snackbar.dart';
import 'package:proyecto/src/utils/shared_pref.dart';

class LoginController{

  BuildContext? context;


  TextEditingController emailController = TextEditingController();
  TextEditingController passController  = TextEditingController();

  UsersProvider usersProvider = UsersProvider();
  final SharedPref _sharedPref = SharedPref();

  Future? init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);

    User user = User.fromJson(await _sharedPref.read('user') ?? {});

    if (user.sessionToken != null){

      if(user.roles!.length > 1) {
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      }
      else {
        Navigator.pushNamedAndRemoveUntil(context, user.roles![0].route!, (route) => false);
      }    }

  }

  void goToRegistesterPage(){
    Navigator.pushNamed(context!, 'register');
  }

  void login() async {
    String email = emailController.text.trim();
    String pass = passController.text;
    ResponseApi? responseApi= await usersProvider.login(email, pass);

    if(responseApi?.success ?? false){

      User user = User.fromJson(responseApi?.data);
      _sharedPref.save('user', user.toJson());

      print('Usuario logeado: ${user.toJson()}');

      if(user.roles!.length > 1) {
        Navigator.pushNamedAndRemoveUntil(context!, 'roles', (route) => false);
      }
      else {
        Navigator.pushNamedAndRemoveUntil(context!, user.roles![0].route!, (route) => false);
      }

    }
    else{
      MySnackbar.show(context!, responseApi!.message ?? '');
    }
  }
}