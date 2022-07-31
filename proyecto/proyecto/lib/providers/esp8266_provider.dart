import 'dart:convert';
import 'package:intl/intl.dart';


import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto/src/api/environment.dart';
import 'package:proyecto/src/models/esp8266.dart';
import 'package:proyecto/src/models/response_api.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/src/utils/shared_pref.dart';

class Esp8266Provider {

  final String _url = Environment.API_TESIS;
  final String _api = '/api/esp8266';

  BuildContext? context;
  User? sessionUser;

  Future<void> init(BuildContext context, User? sessionUser)async{
    this.context = context;
    this.sessionUser = sessionUser;
  }


  // Future<Stream?> create(Esp8266 esp8266) async {
  //   try{
  //     Uri url = Uri.parse(_url, '$_api/create');
  //     final request = http.MultipartRequest('POST', url);
  //     request.headers['Authorization'] = sessionUser!.sessionToken!;
  //
  //     final res = await http.post(url, headers: headers, body: bodyParams);
  //
  //
  //
  //     request.fields['esp8266'] = json.encode(esp8266);
  //     final response =  await request.send();
  //     return response.stream.transform(utf8.decoder);
  //
  //   }catch(e){
  //     print('Error: $e');
  //     return null;
  //   }
  // }
  //
  Future<ResponseApi?> create(Esp8266 esp8266) async {

    try{

      Uri url = Uri.parse(_url+ '$_api/create');
      String bodyParams = json.encode(esp8266);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser!.sessionToken!
      };
      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401){
        Fluttertoast.showToast(msg: 'Sesion Expirada');
        SharedPref().logout(context!, sessionUser!.id!);
      }

      final data = json.decode(res.body);
      ResponseApi responseApi =  ResponseApi.fromJson(data);
      return responseApi;

    }
    catch(e){
      print('Error: $e');
      return null;
    }
  }


Future<Esp8266?> getByMachine(String idMachine) async{
  try {

    Uri url = Uri.parse(_url+ '$_api/findByMachine/$idMachine');
    Map<String, String> headers = {
      'Content-type': 'application/json',
      // 'Authorization': sessionUser?.sessionToken??''
    };
    final res = await http.get(url, headers: headers);

    // if (res.statusCode == 401){
    //   Fluttertoast.showToast(msg: 'Sesion Expirada');
    //   new SharedPref().logout(context!, sessionUser!.id!);
    // }

    final data = json.decode(res.body);
    Esp8266 esp8266 = Esp8266.fromJson(data);
    return esp8266;


  }catch(e){
    print('Error: $e');
    return null;
  }


}

  Future<ResponseApi?> update(Esp8266 esp8266) async {

    try{
      Uri url = Uri.parse(_url+ '$_api/update');
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(now);
      Map<String,dynamic> body = {
          "id" : esp8266.idEsp,
          "gpio0" : !(esp8266.gpio0 ?? false),
          "updated_at" : formatted
      };
      Map<String, String> headers = {
        'Content-type': 'application/json'
      };

      final res = await http.post(url, headers: headers, body: jsonEncode(body));

      final data = json.decode(res.body);
      ResponseApi responseApi =  ResponseApi.fromJson(data);
      return responseApi;

    }
    catch(e){
      print('Error update: $e');
      return null;
    }
  }



}