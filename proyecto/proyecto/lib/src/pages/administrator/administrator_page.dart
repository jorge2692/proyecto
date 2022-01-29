import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyecto/src/utils/my_colors.dart';
import 'package:proyecto/widgets/cerrar_sesion.dart';

class AdministratorPage extends StatefulWidget {
  @override
  _AdministratorPage createState() => _AdministratorPage();
}

class _AdministratorPage extends State<AdministratorPage> {

  CerrarSesion _con = new CerrarSesion();

  @override
  void initState(){
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Lavanti'),
        backgroundColor: MyColors.primaryColor,
        elevation: 0,
      ),
      drawer: _drawer(_con),
    );
  }

  void refresh(){
    setState(() {});
  }

}

Widget _drawer(_con) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [

        DrawerHeader(
            decoration: BoxDecoration(
              color: MyColors.primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_con.user?.name?? ''} ${_con.user?.lastname?? ''}',
                  style: TextStyle(fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
                Text(
                  _con.user?.email?? '',
                  style: TextStyle(fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                  maxLines: 1,
                ),
                Container(
                  height: 70,
                  margin: EdgeInsets.only(top: 10),
                  child: _con.user?.image == null ? _notImg() : FadeInImage(
                    image: NetworkImage(_con.user?.image),
                    fit: BoxFit.contain,
                    fadeInDuration: Duration(milliseconds: 50),
                    placeholder: AssetImage('assets/iconavatar.jpeg'),
                  ),
                )
              ],
            )
        ),
        ListTile(
          onTap: _con.goToCategoriaCreate,
          title: Text('Crear Categoria'),
          trailing: Icon(Icons.add_business),
        ),
        ListTile(
          onTap: _con.goToEdificioCreate,
          title: Text('Crear Edificio'),
          trailing: Icon(Icons.add_business),
        ),
        ListTile(
          onTap: _con.goToEquiposCreate,
          title: Text('Crear Equipo'),
          trailing: Icon(Icons.local_laundry_service_outlined),
        ),
        ListTile(
          onTap: _con.goToRoles,
          title: Text('Seleccionar Rol'),
          trailing: Icon(Icons.person_outline),
        ),
        ListTile(
          onTap: _con.logout,
          title: Text('Cerrar Sesion'),
          trailing: Icon(Icons.power_settings_new_rounded),
        ),

      ],
    ),
  );
}


Widget _notImg(){
  return const FadeInImage(
    image: AssetImage('assets/iconavatar.jpeg'),
    fit: BoxFit.contain,
    placeholder: AssetImage('assets/iconavatar.jpeg'),
  );
}
