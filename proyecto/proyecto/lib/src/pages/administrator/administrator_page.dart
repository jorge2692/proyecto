import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/features/errors_list/bloc/errors_list_bloc.dart';
import 'package:proyecto/src/utils/my_colors.dart';
import 'package:proyecto/widgets/cerrar_sesion.dart';

class AdministratorPage extends StatefulWidget {

  const AdministratorPage({Key? key}) : super(key: key);

  @override
  _AdministratorPage createState() => _AdministratorPage();
}

class _AdministratorPage extends State<AdministratorPage> {

  final CerrarSesion _con = CerrarSesion();

  @override
  void initState(){
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Lavanti'),
        backgroundColor: MyColors.primaryColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: BlocProvider<ErrorsListBloc>(
            create: (context) => ErrorsListBloc(),
          child: BlocBuilder<ErrorsListBloc,ErrorListState>(
            builder: (context,state){
              if(state is LoadingErrors){
                return const Center(child: CircularProgressIndicator());
              }
              if(state is DataListErrors){
                return Column(
                  children: [
                    Text('Errores'),
                    Expanded(child:
                    ListView.builder(
                        itemCount: state.data.length,
                        itemBuilder: (context,index){
                          var error = state.data[index];
                          return Card(
                            child: ListTile(
                              title: Text(error.machineName ?? ''),
                              subtitle: Text(
                                'Voltaje ${error.voltage} - Corriente ${error.amp} - Alerta ${error.alert}',
                                maxLines: 3,
                              ),
                              trailing: Text('${error.createdAt?.year}/${error.createdAt?.month}/${error.createdAt?.day}  ${error.createdAt?.hour}:${error.createdAt?.minute}:${error.createdAt?.second}'),
                            ),
                          );
                    }),
                    )
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
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
                  style: const TextStyle(fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
                Text(
                  _con.user?.email?? '',
                  style: const TextStyle(fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                  maxLines: 1,
                ),
                Container(
                  height: 70,
                  margin: const EdgeInsets.only(top: 10),
                  child: _con.user?.image == null ? _notImg() : FadeInImage(
                    image: NetworkImage(_con.user?.image),
                    fit: BoxFit.contain,
                    fadeInDuration: const Duration(milliseconds: 50),
                    placeholder: const AssetImage('assets/iconavatar.jpeg'),
                  ),
                )
              ],
            )
        ),
        ListTile(
          onTap: _con.goToCategoriaCreate,
          title: const Text('Crear Categoria'),
          trailing: const Icon(Icons.account_tree_rounded),
        ),
        ListTile(
          onTap: _con.goToEdificioCreate,
          title: const Text('Crear Edificio'),
          trailing: const Icon(Icons.add_business),
        ),
        ListTile(
          onTap: _con.goToCityCreate,
          title: const Text('Crear Ciudad'),
          trailing: const Icon(Icons.add_location_outlined ),
        ),
        ListTile(
          onTap: _con.goToEquiposCreate,
          title: const Text('Crear Equipo'),
          trailing: const Icon(Icons.local_laundry_service_outlined),
        ),
        ListTile(
          onTap: _con.goToEspCreate,
          title: const Text('Crear Modulo Esp'),
          trailing: const Icon(Icons.account_tree_rounded),
        ),
        ListTile(
          onTap: _con.goToRoles,
          title: const Text('Seleccionar Rol'),
          trailing: const Icon(Icons.person_outline),
        ),
        ListTile(
          onTap: _con.logout,
          title: const Text('Cerrar Sesion'),
          trailing: const Icon(Icons.power_settings_new_rounded),
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
