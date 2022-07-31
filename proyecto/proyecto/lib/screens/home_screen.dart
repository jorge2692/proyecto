import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyecto/src/models/category.dart';
import 'package:proyecto/src/models/equipos.dart';
import 'package:proyecto/src/utils/my_colors.dart';
import 'package:proyecto/widgets/cerrar_sesion.dart';
import 'package:proyecto/widgets/no_data_widget.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}): super(key: key);

  @override

  _HomeScreen  createState() =>_HomeScreen();

}

class _HomeScreen extends State<HomeScreen> {

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
    // TODO: implement build
    return DefaultTabController(
      length: _con.categories.length,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight * 2),
            child: AppBar(
              centerTitle: true,
              title: const Text('Lavanti'),
              backgroundColor: MyColors.primaryColor,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: MyColors.primaryColorDark,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                tabs: List<Widget>.generate(_con.categories.length,(index) {
                  return Tab(
                    child: Text(_con.categories[index].name ?? ''),
                  );
                }),
              ),
            ),
          ),
          drawer: _drawer(_con),

          body: TabBarView(

            children: _con.categories.map((Category category){
              return FutureBuilder(
                future: _con.getEquipos(category.id!),
              builder: (context, AsyncSnapshot<List<Equipos>> snapshot){

                  if (snapshot.hasData){
                    if(snapshot.data!.isNotEmpty){
                      return GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.9,
                            ),
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (_, index) {
                            return _cardEquipo(snapshot.data![index]);
                          }
                      );
                    }
                    else{
                      return const NoDataWidget(text: 'no hay equipos');
                    }
                  }
                  else{
                    return const NoDataWidget(text: 'no hay equipos');
                  }

              }
              );
            }).toList(),
          )
      ),
    );
  }

  Widget _cardEquipo(Equipos equipos){

    return GestureDetector(
      onTap: (){_con.openBottomSheet(equipos);
      },
      child: SizedBox(
        height: 250,
        child:  Card(
          elevation: 3.0,
          shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    padding: const EdgeInsets.all(10),
                    child: equipos.image1 == null ?  _notImg() : FadeInImage(
                      image:NetworkImage(equipos.image1!),
                      fit: BoxFit.cover,
                      fadeInDuration: const Duration(milliseconds: 50),
                      placeholder: const AssetImage('assets/lavadora-sinfondo.png'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    height: 30,
                    child: Text(
                      equipos.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        equipos.serial ??'',// esto es para ver la opcion del historial de la maquina "opcional'
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      )
                    )
                  )
                ],
              )
            ],
          ),
        ),

      ),
    );

     }

  Widget _drawer(_con){

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
            onTap: _con.goToUpdatePage,
            title: const Text('Editar Perfil'),
            trailing: const Icon(Icons.edit_attributes_outlined),
          ),
          ListTile(
            onTap: _con.goToEquiposSearch,
            title: const Text('Equipos'),
            trailing: const Icon(Icons.local_laundry_service_outlined),
          ),

          _con.user != null?
          _con.user.roles.length > 1 ?

          ListTile(
            onTap: _con.goToRoles,
            title: const Text('Seleccionar Rol'),
            trailing: const Icon(Icons.person_outline),
          ) : Container() : Container(),
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

  void refresh(){
    setState(() {});
  }
}


