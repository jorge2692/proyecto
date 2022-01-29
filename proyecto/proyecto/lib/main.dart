import 'package:flutter/material.dart';
import 'package:proyecto/src/pages/administrator/administrator_page.dart';
import 'package:proyecto/src/pages/administrator/create/categorias/categorias_create_page.dart';
import 'package:proyecto/src/pages/administrator/create/edificios/edificios_create_page.dart';
import 'package:proyecto/src/pages/administrator/create/equipos/equipos_create_page.dart';
import 'package:proyecto/src/pages/client/update/update_page.dart';
import 'package:proyecto/src/pages/login/login_page.dart';
import 'package:proyecto/src/pages/register/register_page.dart';
import 'package:proyecto/src/pages/roles/roles_pages.dart';
import 'package:proyecto/src/utils/my_colors.dart';
import 'screens/screen.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lavanti',
      initialRoute: 'login',
      routes:{
        'login': ( _ ) => LoginPage(),
        'roles': ( _ ) => RolesPages(),
        'register': ( _ ) => RegisterPage(),
        'client': ( _ ) => HomeScreen(),
        'administrator': ( _ ) => AdministratorPage(),
        'details': ( _ ) => DetailsScreen(),
        'edificio': ( _ ) => EdificioScreen(),
        'ciudad': ( _ ) => CiudadScreen(),
        'equipo': ( _ ) => EquipoScreen(),
        'control': ( _ ) => ControlScreen(),
        'clientupdate': ( _ ) => UpdatePage(),
        'EdificiosCreatePage': ( _ ) => EdificiosCreatePage(),
        'EquiposCreatePage': ( _ ) => EquiposCreatePage(),
        'CategoriaCreatePage': ( _ ) => CategoriaCreatePage(),
      },
      theme: ThemeData(
          primaryColor: MyColors.primaryColor
      ),
    );
  }
}
