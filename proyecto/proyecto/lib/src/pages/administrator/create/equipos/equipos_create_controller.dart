import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto/providers/categories_provider.dart';
import 'package:proyecto/providers/address_provider.dart';
import 'package:proyecto/providers/equipos_provider.dart';
import 'package:proyecto/src/models/category.dart';
import 'package:proyecto/src/models/address.dart';
import 'package:proyecto/src/models/equipos.dart';
import 'package:proyecto/src/models/response_api.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:proyecto/src/utils/my_snackbar.dart';
import 'package:proyecto/src/utils/shared_pref.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class EquiposCreateController {

  BuildContext? context;

  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController serialController = new TextEditingController();
  TextEditingController modelController = new TextEditingController();
  TextEditingController id_lavanti= new TextEditingController();
  TextEditingController voltajeController= new TextEditingController();
  TextEditingController corrienteController= new TextEditingController();
  TextEditingController potenciaController= new TextEditingController();
  // TextEditingController id_address= new TextEditingController();


  Function? refresh;

  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  EquiposProvider _equiposProvider = new EquiposProvider();
  AddressProvider _addressProvider = new AddressProvider();
  User? user;
  SharedPref sharedPref= new SharedPref();

  List<Category> categories = [];
  List<Address> address = [];

  String? idCategory;
  String? idAddress;

  PickedFile? pickedFile;
  File? imageFile1;
  File? imageFile2;
  ProgressDialog? _progressDialog;

  Future? init(BuildContext context, Function refresh) async {

    this.context = context;
    this.refresh = refresh;
    _progressDialog = new ProgressDialog(context: context);
    user = User.fromJson(await sharedPref.read('user'));
    _categoriesProvider.init(context, user);
    _addressProvider.init(context, user);
    _equiposProvider.init(context, user);
    getCategories();
    getAddress();

  }

  void getCategories() async {
    categories = await _categoriesProvider.getAll();
    refresh!();

  }

  void getAddress() async {
    address = await _addressProvider.getAll();
    refresh!();

  }

  void createEquipo() async {
    String name = nameController.text;
    String description = descriptionController.text;
    String serial = serialController.text;
    String model = modelController.text;
    double idlavanti = double.parse(id_lavanti.text);
    double voltaje = double.parse(voltajeController.text);
    double corriente = double.parse(corrienteController.text);
    double potencia = double.parse(potenciaController.text);

    if(name.isEmpty || description.isEmpty || serial.isEmpty || voltaje == 0 || model ==0 || corriente ==0|| potencia == 0){
      MySnackbar.show(context!,'Ingresar todos los campos');
      return;
    }

    if(imageFile1 == null || imageFile2 == null){

      MySnackbar.show(context!,'Seleccionar las dos imagenes');
      return;

    }

    if(idCategory == null){

      MySnackbar.show(context!,'Seleccionar la categoria del producto');
      return;

    }

    if(idAddress == null){

      MySnackbar.show(context!,'Seleccionar el Edificio');
      return;

    }

    Equipos? equipos = new Equipos(
      name: name,
      description: description,
      serial: serial,
      model: model,
      idlavanti: idlavanti,
      voltaje: voltaje,
      corriente: corriente,
      potencia: potencia,
      idCategory: int.parse(idCategory!),
      idAddress: int.parse(idAddress!)
    );

    List<File> images = [];
    images.add(imageFile1!);
    images.add(imageFile2!);

    _progressDialog!.show(max: 100, msg: 'Espere un momento');
    Stream? stream = await _equiposProvider.create(equipos, images);
    stream!.listen((res) {
      _progressDialog!.close();

      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      MySnackbar.show(context!, responseApi.message!);

      if (responseApi.success!) {

        resetValues();

      }

    });

    print('Formulario Equipos: ${equipos.toJson()}');


  }

  void resetValues(){

    nameController.text = '';
    descriptionController.text = '';
    serialController.text = '';
    modelController.text = '';
    id_lavanti.text = '';
    voltajeController.text = '';
    corrienteController.text = '';
    potenciaController.text = '';
    imageFile1 = null;
    imageFile2 = null;
    idCategory = null;
    idAddress = null;
    refresh!();

  }


  Future selectImage(ImageSource imageSource, int numberFile) async{

    pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null){

      if(numberFile == 1){

        imageFile1 = File(pickedFile!.path);

      }
      else if(numberFile == 2){

        imageFile2 = File(pickedFile!.path);

      }
    }
    Navigator.pop(context!);
    refresh!();
  }

  void showAlertDialog(int numberFile) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery, numberFile);
        }, child: Text('Galeria')
    );


    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera, numberFile);
        }, child: Text('Camera')
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona una imagen'),
      actions: [
        galleryButton,
        cameraButton,
      ],
    );

    showDialog(
        context: context!,
        builder: (BuildContext context){
          return alertDialog;
        }
    );
  }
}
