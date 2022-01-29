import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';


import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto/src/api/environment.dart';
import 'package:proyecto/src/models/esp8266.dart';
import 'package:proyecto/src/models/response_api.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/src/utils/shared_pref.dart';

class Esp8266Provider {

  String _url = Environment.API_TESIS;
  String _api = '/api/esp8266';

  BuildContext? context;
  User? sessionUser;

  Future? init(BuildContext context, User? sessionUser){
    this.context = context;
    this.sessionUser = sessionUser;
  }


  // Future<List<Esp8266>> getByCategory(String idCategory) async{
  //   try {
  //
  //     Uri url = Uri.http(_url, '$_api/findByCategory/$idCategory');
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json',
  //       'Authorization': sessionUser!.sessionToken!
  //     };
  //     final res = await http.get(url, headers: headers);
  //
  //     if (res.statusCode == 401){
  //       Fluttertoast.showToast(msg: 'Sesion Expirada');
  //       new SharedPref().logout(context!, sessionUser!.id!);
  //     }
  //
  //     final data = json.decode(res.body);
  //     Esp8266 equipos = Esp8266.fromJsonList(data);
  //     return equipos.toList;
  //
  //
  //   }catch(e){
  //     print('Error: $e');
  //     return[];
  //
  //   }
  //
  //
  // }

  Future<Stream?> create(Esp8266 esp8266) async {
    try{
      Uri url = Uri.http(_url, '$_api/create');
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = sessionUser!.sessionToken!;


      request.fields['esp8266'] = json.encode(esp8266);
      final response =  await request.send();
      return response.stream.transform(utf8.decoder);

    }catch(e){
      print('Error: $e');
      return null;
    }
  }
  //
  // Future<ResponseApi?> create(Esp8266 esp8266) async {
  //
  //   try{
  //
  //     Uri url = Uri.http(_url, '$_api/create');
  //     String bodyParams = json.encode(esp8266);
  //     Map<String, String> headers = {
  //       'Content-type': 'application/json',
  //       'Authorization': sessionUser!.sessionToken!
  //     };
  //     final res = await http.post(url, headers: headers, body: bodyParams);
  //
  //     if (res.statusCode == 401){
  //       Fluttertoast.showToast(msg: 'Sesion Expirada');
  //       new SharedPref().logout(context!, sessionUser!.id!);
  //     }
  //
  //     final data = json.decode(res.body);
  //     ResponseApi responseApi =  ResponseApi.fromJson(data);
  //     return responseApi;
  //
  //   }
  //   catch(e){
  //     print('Error: $e');
  //     return null;
  //   }
  // }


}