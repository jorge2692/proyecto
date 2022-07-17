// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto/providers/users_provider.dart';
import 'package:proyecto/src/models/response_api.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:proyecto/src/utils/my_snackbar.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class RegisterController{

  BuildContext? context;
  TextEditingController emailController     =  TextEditingController();
  TextEditingController nameController      =  TextEditingController();
  TextEditingController lastNameController  =  TextEditingController();
  //TextEditingController phoneController   = new TextEditingController();
  TextEditingController passController      =  TextEditingController();
  TextEditingController passCheckController =  TextEditingController();

  UsersProvider usersProvider =  UsersProvider();

  PickedFile? pickedFile;
  File? imageFile;
  Function? refresh;

  ProgressDialog? _progressDialog;


  bool isEnable = true;


  Future<void> init(BuildContext context, Function refresh)async{
    this.context = context;
    this.refresh = refresh;
    usersProvider.init(context);
    _progressDialog = ProgressDialog(context: context);
  }

  void register() async{

  String email    = emailController.text;
  String name     = nameController.text;
  String lastName = lastNameController.text;
  //String phone  = phoneController.text;
  String pass     = passController.text;
  String passCheck= passCheckController.text;

  if(email.isEmpty || name.isEmpty || lastName.isEmpty || pass.isEmpty || passCheck.isEmpty){
    MySnackbar.show(context!, 'Debes ingresar todos los campos');
    return;

  }

  if(passCheck != pass){
    MySnackbar.show(context!, 'Las contraseñas no coinciden');
    return;
  }

  if(pass.length < 6){
    MySnackbar.show(context!, 'Las Contraseñas debe tener al menos 6 caracteres');
    return;
  }

  if(imageFile == null){

    MySnackbar.show(context!, 'Selecciona una image');
    return;
  }

  _progressDialog?.show(max: 100, msg: 'Espere un momento');

  isEnable = false;

  User user = User(
    email   : email,
    name    : name,
    lastname: lastName,
    password: pass,
  );

  Stream? stream =  await usersProvider.createWithImage(user, imageFile!);
  stream?.listen((res){

    _progressDialog?.close();




    //ResponseApi? responseApi = await usersProvider.create(user);
    ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

    print('Respuesta: ${responseApi.toJson()}');

    MySnackbar.show(context!, responseApi.message ?? '');

    if(responseApi.success?? false){

      Future.delayed(const Duration(seconds: 3),(){

        Navigator.pushReplacementNamed(context!, 'login');

      });
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