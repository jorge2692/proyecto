import 'package:flutter/material.dart';
import 'package:proyecto/providers/categories_provider.dart';
import 'package:proyecto/src/models/category.dart';
import 'package:proyecto/src/models/response_api.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:proyecto/src/utils/my_snackbar.dart';
import 'package:proyecto/src/utils/shared_pref.dart';

class EquiposCreateController {

  BuildContext? context;

  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController serilController = new TextEditingController();
  TextEditingController modelController = new TextEditingController();
  // TextEditingController id_lavanti= new TextEditingController();
  TextEditingController voltajeController= new TextEditingController();
  TextEditingController corrienteController= new TextEditingController();
  TextEditingController potenciaController= new TextEditingController();

  Function? refresh;

  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  User? user;
  SharedPref sharedPref= new SharedPref();

  List<Category> categories = [];
  String? idCategory;

  Future? init(BuildContext context, Function refresh) async {

    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await sharedPref.read('user'));
    _categoriesProvider.init(context, user);
    getCategories();

  }

  void getCategories() async {
    categories = await _categoriesProvider.getAll();
    refresh!();

  }

  void createEquipo() async {
    String name = nameController.text;
    String description = descriptionController.text;

    if(name.isEmpty || description.isEmpty ){
      MySnackbar.show(context!,'Ingresar todos los campos');
      return;
    }


  }
}
