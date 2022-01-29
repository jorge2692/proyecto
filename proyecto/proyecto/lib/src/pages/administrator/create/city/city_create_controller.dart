import 'package:flutter/material.dart';
import 'package:proyecto/providers/cities_provider.dart';
import 'package:proyecto/src/models/city.dart';
import 'package:proyecto/src/models/response_api.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:proyecto/src/utils/my_snackbar.dart';
import 'package:proyecto/src/utils/shared_pref.dart';

class CityCreateController {

  BuildContext? context;

  TextEditingController nameController = new TextEditingController();
  TextEditingController departmentController = new TextEditingController();
  Function? refresh;

  CitiesProvider _citiesProvider = new CitiesProvider();
  User? user;
  SharedPref sharedPref= new SharedPref();


  Future? init(BuildContext context, Function refresh) async {

    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await sharedPref.read('user'));
    _citiesProvider.init(context, user);

  }

  void createCity() async {
    String name = nameController.text;
    String department = departmentController.text;

    if(name.isEmpty || department.isEmpty ){
      MySnackbar.show(context!,'Ingresar todos los campos');
      return;
    }

    City city = new City(
      name: name,
      department: department,
    );

    ResponseApi? responseApi = await _citiesProvider.create(city);

    MySnackbar.show(context!,responseApi!.message!);

    if(responseApi.success!){
      nameController.text = '';
      departmentController.text = '';
    }
  }
}
