// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto/providers/users_provider.dart';
import 'package:proyecto/src/models/response_api.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:proyecto/src/utils/my_snackbar.dart';
import 'package:proyecto/src/utils/shared_pref.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class UpdateController{

  BuildContext? context;
  TextEditingController nameController      = TextEditingController();
  TextEditingController lastNameController  = TextEditingController();

  UsersProvider usersProvider =  UsersProvider();

  PickedFile? pickedFile;
  File? imageFile;
  Function? refresh;

  ProgressDialog? _progressDialog;


  bool isEnable = true;
  User? user;
  final SharedPref _sharedPref = SharedPref();

  Future? init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    _progressDialog = ProgressDialog(context: context);
    user = User.fromJson(await _sharedPref.read('user'));
    usersProvider.init(context,sessionUser: user );


    nameController.text = user!.name!;
    lastNameController.text = user!.lastname!;
    refresh();
  }

  void update() async{

    String name     = nameController.text;
    String lastName = lastNameController.text;

    if(name.isEmpty || lastName.isEmpty ){
      MySnackbar.show(context!, 'Debes ingresar todos los campos');
      return;

    }

    if(imageFile == null){

      MySnackbar.show(context!, 'Selecciona una imagen');
      return;
    }

    _progressDialog?.show(max: 100, msg: 'Espere un momento');

    isEnable = false;

    User myUser = User(
      id      : user?.id,
      name    : name,
      lastname: lastName,
      image   : user?.image,
    );

    Stream? stream =  await usersProvider.update(myUser, imageFile!);
    stream?.listen((res)async{

      _progressDialog?.close();




      //ResponseApi? responseApi = await usersProvider.create(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      Fluttertoast.showToast(msg: responseApi.message!);

      if(responseApi.success?? false){

        user = await usersProvider.getById(myUser.id!); //coloque la admiracion para evitar el null
        _sharedPref.save('user', user!.toJson());// igual al anterior para evitar el user null

        Navigator.pushNamedAndRemoveUntil(context!, 'client', (route) => false);
      }

      else{
        isEnable = true;
      }


    });


  }

  Future selectImage(ImageSource imageSource) async{

    pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null){
      imageFile = File(pickedFile!.path);
    }
    Navigator.pop(context!);
    refresh!();
  }

  void showAlertDialog() {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery);
        }, child: const Text('Galeria')
    );


    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera);
        }, child: const Text('Camera')
    );

    AlertDialog alertDialog = AlertDialog(
      title: const Text('Selecciona una imagen'),
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


  void back(){

    Navigator.pop(context!);

  }


}