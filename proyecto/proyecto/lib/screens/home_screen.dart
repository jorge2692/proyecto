
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyecto/src/utils/my_colors.dart';
import 'package:proyecto/src/utils/shared_pref.dart';
import 'package:proyecto/widgets/cerrar_sesion.dart';
import 'package:proyecto/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}): super(key: key);

  @override

  _HomeScreen  createState() =>_HomeScreen();

}

class _HomeScreen extends State<HomeScreen> {

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
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Lavanti'),
          backgroundColor: MyColors.primaryColor,
          elevation: 0,
        ),
        drawer: _drawer(_con),

        body: SingleChildScrollView(
          child: Column(
            children: [


              Cards(),


              EdificioSlider(),



            ],
          ),
        )
    );
  }

  Widget _drawer(_con){

    print(_con.user?.image);

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
            onTap: _con.goToUpdatePage,
            title: Text('Editar Perfil'),
            trailing: Icon(Icons.edit_attributes_outlined),
          ),
          ListTile(
            title: Text('Equipos'),
            trailing: Icon(Icons.local_laundry_service_outlined),
          ),

          _con.user != null?
          _con.user.roles.length > 1 ?

          ListTile(
            onTap: _con.goToRoles,
            title: Text('Seleccionar Rol'),
            trailing: Icon(Icons.person_outline),
          ) : Container() : Container(),
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


  void refresh(){
    setState(() {});
  }
}


