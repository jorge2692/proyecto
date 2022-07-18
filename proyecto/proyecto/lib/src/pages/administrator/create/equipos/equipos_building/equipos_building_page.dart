import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyecto/src/models/equipos.dart';
import 'package:proyecto/src/pages/administrator/create/equipos/equipos_building/equipos_building_controller.dart';
import 'package:proyecto/src/pages/administrator/search/equipos_search_controller.dart';
import 'package:proyecto/widgets/no_data_widget.dart';

class EquiposBuildingPage extends StatefulWidget {

  const EquiposBuildingPage({Key? key, required this.buildingId}): super(key: key);
  final String buildingId;

  @override
  _EquiposBuildingPageState createState() => _EquiposBuildingPageState();
}

class _EquiposBuildingPageState extends State<EquiposBuildingPage> {

  EquiposBuildingController _con = EquiposBuildingController();

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
      body: SafeArea(
        child: FutureBuilder(
            future: _con.getEquipos(widget.buildingId),
            builder: (context, AsyncSnapshot<List<Equipos>> snapshot){

              if (snapshot.hasData){
                if(snapshot.data!.length > 0){
                  return GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (_, index) {
                        return _cardEquipo(snapshot.data![index],context);
                      }
                  );
                }
                else{
                  return NoDataWidget(text: 'no hay equipos');
                }
              }
              else{
                return NoDataWidget(text: 'no hay equipos');
              }

            }
        ),
      ),
    );
  }




  Widget _cardEquipo(Equipos equipos, BuildContext context){

    return GestureDetector(
      onTap: (){
        _con.openBottomSheet(equipos,context );
      },
      child: Container(
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
                    padding: EdgeInsets.all(10),
                    child: equipos.image1 == null ?  _notImg() : FadeInImage(
                      image:NetworkImage(equipos.image1!),
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/lavadora-sinfondo.png'),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    height: 30,
                    child: Text(
                      equipos.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                          equipos.serial ??'',// esto es para ver la opcion del historial de la maquina "opcional'
                          style: TextStyle(
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
