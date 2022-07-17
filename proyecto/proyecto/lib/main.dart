import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/src/pages/administrator/administrator_page.dart';
import 'package:proyecto/src/pages/administrator/create/categorias/categorias_create_page.dart';
import 'package:proyecto/src/pages/administrator/create/city/city_create_page.dart';
import 'package:proyecto/src/pages/administrator/create/edificios/edificios_create_page.dart';
import 'package:proyecto/src/pages/administrator/create/equipos/equipos_create_page.dart';
import 'package:proyecto/src/pages/administrator/create/equipos/history/history_page.dart';
import 'package:proyecto/src/pages/administrator/create/esp8266/esp_create_page.dart';
import 'package:proyecto/src/pages/administrator/create/map/edificios_map_page.dart';
import 'package:proyecto/src/pages/administrator/search/equipos_search_page.dart';
import 'package:proyecto/src/pages/client/update/update_page.dart';
import 'package:proyecto/src/pages/esp8266/update/esp_update_page.dart';
import 'package:proyecto/src/pages/login/login_page.dart';
import 'package:proyecto/src/pages/register/register_page.dart';
import 'package:proyecto/src/pages/roles/roles_pages.dart';
import 'package:proyecto/src/utils/my_colors.dart';
import 'screens/screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  /// init a firebase app
  await Firebase.initializeApp();

  String? fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onMessage.listen(_onMessageService);
  FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpened);

  runApp(const MyApp());
}

Future<void> _onMessageService(RemoteMessage? message)async{
  print('onMessageService');
  print('${message?.data}');

}

Future<void> _onMessageOpened(RemoteMessage? message)async{
  print('onMessageService');
  print('${message?.data}');
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lavanti',
      initialRoute: 'login',
      routes:{
        'login': ( _ ) => const LoginPage(),
        'roles': ( _ ) => const RolesPages(),
        'register': ( _ ) => const RegisterPage(),
        'client': ( _ ) => const HomeScreen(),
        'administrator': ( _ ) => const AdministratorPage(),
        'details': ( _ ) => const DetailsScreen(),
        'edificio': ( _ ) => const EdificioScreen(),
        'ciudad': ( _ ) => const CiudadScreen(),
        'equipo': ( _ ) => const EquipoScreen(),
        'control': ( _ ) => const ControlScreen(),
        'clientupdate': ( _ ) => const UpdatePage(),
        'EdificiosCreatePage': ( _ ) => const EdificiosCreatePage(),
        'edificiosmappage' : ( _ ) => const EdificiosMapPage(),
        'EquiposCreatePage': ( _ ) => const EquiposCreatePage(),
        'CategoriaCreatePage': ( _ ) => const CategoriaCreatePage(),
        'CityCreatePage': ( _ ) => const CityCreatePage(),
        'EspCreatePage': ( _ ) => const EspCreatePage(),
        'EspUpdatePage': ( _ ) => const EspUpdatePage(),
        'EquiposSearchPage': ( _ ) => const EquiposSearchPage(),
        'HistoryPage':( _ ) => const HistoryPage(),
      },
      theme: ThemeData(
          primaryColor: MyColors.primaryColor,
        appBarTheme: AppBarTheme(backgroundColor: MyColors.primaryColor,elevation: 0)
      ),
    );
  }
}
