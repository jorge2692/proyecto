import 'package:flutter/material.dart';
import 'package:proyecto/providers/categories_provider.dart';
import 'package:proyecto/src/models/category.dart';
import 'package:proyecto/src/models/response_api.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:proyecto/src/utils/my_snackbar.dart';
import 'package:proyecto/src/utils/shared_pref.dart';

class CategoriaCreateController {

  BuildContext? context;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Function? refresh;

  final CategoriesProvider _categoriesProvider = CategoriesProvider();
  User? user;
  final SharedPref sharedPref= SharedPref();


  Future? init(BuildContext context, Function refresh) async {

    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await sharedPref.read('user'));
    _categoriesProvider.init(context, user);

  }

  void createCategory() async {
    String name = nameController.text;
    String description = descriptionController.text;

    if(name.isEmpty || description.isEmpty ){
      MySnackbar.show(context!,'Ingresar todos los campos');
      return;
    }

    Category category = Category(
      name: name,
      description: description,
    );

    ResponseApi? responseApi = await _categoriesProvider.create(category);

    MySnackbar.show(context!,responseApi!.message!);

    if(responseApi.success!){
      nameController.text = '';
      descriptionController.text = '';
    }
  }
}
