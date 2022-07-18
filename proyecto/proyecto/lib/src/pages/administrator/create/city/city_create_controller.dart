import 'package:flutter/material.dart';
import 'package:proyecto/providers/cities_provider.dart';
import 'package:proyecto/src/models/city.dart';
import 'package:proyecto/src/models/response_api.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:proyecto/src/utils/my_snackbar.dart';
import 'package:proyecto/src/utils/shared_pref.dart';

class CityCreateController {

  BuildContext? context;

  final TextEditingController nameController =  TextEditingController();
  final TextEditingController departmentController =  TextEditingController();
  Function? refresh;

  final CitiesProvider _citiesProvider =  CitiesProvider();
  User? user;
  final SharedPref sharedPref = SharedPref();


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

    City city = City(
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
