import 'package:flutter/material.dart';
import 'package:perro/editar.dart';
import 'package:perro/listado.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: 'listado',
      routes: {

        'listado': ( _ ) => Listado(),
        'editar':   ( _ ) => Editar(),

      },
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
    );
  }
}

