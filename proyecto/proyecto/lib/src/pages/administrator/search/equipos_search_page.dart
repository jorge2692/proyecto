import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyecto/src/models/city.dart';
import 'package:proyecto/src/models/equipos.dart';
import 'package:proyecto/src/pages/administrator/create/equipos/equipos_building/equipos_building_page.dart';
import 'package:proyecto/src/pages/administrator/search/equipos_search_controller.dart';
import 'package:proyecto/src/utils/my_colors.dart';
import 'package:proyecto/src/models/address.dart';


class EquiposSearchPage extends StatefulWidget {
  @override
  _EquiposSearchPageState createState() => _EquiposSearchPageState();
}

class _EquiposSearchPageState extends State<EquiposSearchPage> {

  EquiposSearchController _con = new EquiposSearchController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(

            children: [_dropDownCities(_con.cities, _con),
                Expanded (child: ListView.builder(

                  itemCount:_con.edificios.length,
                  itemBuilder: (context, int index) {
                    print("hello");

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EquiposBuildingPage(buildingId: _con.edificios[index].id??'')));

                          print("Gesture Detector");
                        });
                      },
                      child: ListTile(
                        title: Text('${_con.edificios[index].name}'),
                      ),
                    );
                  },

                  ),
                ),
            ],
          ),
        ),
    );
  }



  Widget _dropDownCities(List<City> cities, EquiposSearchController _con ){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        elevation: 2.0,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.search,
                    color: MyColors.primaryColor,
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Ciudades',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child : DropdownButton(
                  underline: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_drop_down_circle,
                      color: MyColors.primaryColor,
                    ),
                  ),
                  elevation: 3,
                  isExpanded: true,
                  hint: Text(
                    'Selecionar Ciudad',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  items:_dropDownCitie(cities),
                  value: _con.idCity,
                  onChanged: (option){
                    setState(() {
                      print('Ciudad seleccionada: $option');
                      _con.idCity= option.toString();
                      _con.getEdificios(_con.idCity??'');


                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownCitie(List<City> cities ){
    List<DropdownMenuItem<String>> list = [];
    cities.forEach((city) {
      list.add(DropdownMenuItem(
        child: Text(city.name!),
        value: city.id,
      ));
    });
    return list;
  }




  // Widget _CardEje (List <Address> address, EquiposSearchController _con){
  //
  //   return Center(
  //     child: Card(
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           const ListTile(
  //             leading: Icon(Icons.album),
  //             title: Text(address.name),
  //             subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             children: <Widget>[
  //               TextButton(
  //                 child: const Text('BUY TICKETS'),
  //                 onPressed: () {/* ... */},
  //               ),
  //               const SizedBox(width: 8),
  //               TextButton(
  //                 child: const Text('LISTEN'),
  //                 onPressed: () {/* ... */},
  //               ),
  //               const SizedBox(width: 8),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  //
  // }

  void refresh(){
    setState(() {

    });
  }
}

