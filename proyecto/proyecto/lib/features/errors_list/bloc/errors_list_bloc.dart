import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/src/api/environment.dart';
import 'package:proyecto/src/models/errors.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:proyecto/src/utils/shared_pref.dart';

part 'erros_list_event.dart';
part 'errors_list_state.dart';


class ErrorsListBloc extends Bloc<ErrorsListEvent,ErrorListState>{

  ErrorsListBloc() : super(LoadingErrors()){
    on<LoadErrorsEvent>(_onLoadDada);
    add(LoadErrorsEvent());
  }

  List<ErrorData> errors = [];
  final String _url = Environment.API_TESIS;
  User? sessionUser;
  final SharedPref _sharedPref = SharedPref();



  _onLoadDada(LoadErrorsEvent event, Emitter<ErrorListState> emit) async{
    try{
      sessionUser = User.fromJson(await _sharedPref.read('user'));
      Uri url = Uri.parse(_url + '/api/esp8266/errors');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser!.sessionToken!
      };
      final res = await http.get(url, headers: headers);

      final data = json.decode(res.body);
      Iterable i = data;
      errors= i.map((e) => ErrorData.fromJson(e)).toList();

    }
    catch(e){
      errors = <ErrorData>[];
    }
    emit(DataListErrors(errors));

  }

}