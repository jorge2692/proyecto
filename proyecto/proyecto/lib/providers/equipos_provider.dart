import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';


import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto/src/api/environment.dart';
import 'package:proyecto/src/models/equipos.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/src/utils/shared_pref.dart';

class EquiposProvider {

  final String _url = Environment.API_TESIS;
  final String _api = '/api/machines';

  BuildContext? context;
  User? sessionUser;

  Future<void> init(BuildContext context, User? sessionUser)async{
    this.context = context;
    this.sessionUser = sessionUser;
  }


  Future<List<Equipos>> getByCategory(String idCategory) async{
    try {

      Uri url = Uri.http(_url, '$_api/findByCategory/$idCategory');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser!.sessionToken!
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401){
        Fluttertoast.showToast(msg: 'Sesion Expirada');
        SharedPref().logout(context!, sessionUser!.id!);
      }

      var data = json.decode(res.body);
      Iterable i = data;
      List<Equipos> equipos = i.map((e) => Equipos.fromJson(e)).toList();
      return equipos;
    }catch(e){
      print('Error: $e');
      return[];
    }


  }

  Future<Stream?> create(Equipos equipos, List<File> images) async {
    try{
      Uri url = Uri.http(_url, '$_api/create');
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = sessionUser!.sessionToken!;

      for(int i = 0; i < images.length; i++){

        request.files.add(http.MultipartFile(

            'image',
            http.ByteStream(images[i].openRead().cast()),
            await images[i].length(),
            filename:  basename(images[i].path)
        )
        );

      }

      request.fields['machine'] = json.encode(equipos);
      final response =  await request.send();
      return response.stream.transform(utf8.decoder);

    }catch(e){
      print('Error: $e');
      return null;
    }
  }

  Future<List<Equipos>> getByBuilding(String idBuilding) async{
    try {

      Uri url = Uri.http(_url, '$_api/findByCategory/$idBuilding');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser!.sessionToken!
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401){
        Fluttertoast.showToast(msg: 'Sesion Expirada');
        SharedPref().logout(context!, sessionUser!.id!);
      }

      var data = json.decode(res.body);
      Iterable i = data;
      List<Equipos> equipos = i.map((e) => Equipos.fromJson(e)).toList();
      return equipos;
    }catch(e){
      print('Error: $e');
      return[];
    }


  }



}