import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyecto/src/models/city.dart';
import 'package:proyecto/src/pages/administrator/create/equipos/equipos_building/equipos_building_page.dart';
import 'package:proyecto/src/pages/administrator/search/equipos_search_controller.dart';
import 'package:proyecto/src/utils/my_colors.dart';


class EquiposSearchPage extends StatefulWidget {

  const EquiposSearchPage({Key? key}) : super(key: key);

  @override
  _EquiposSearchPageState createState() => _EquiposSearchPageState();
}

class _EquiposSearchPageState extends State<EquiposSearchPage> {

  final EquiposSearchController _con = EquiposSearchController();


  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
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
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        elevation: 2.0,
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.search,
                    color: MyColors.primaryColor,
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    'Ciudades',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  hint: const Text(
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
    for (var city in cities) {
      list.add(DropdownMenuItem(
        child: Text(city.name!),
        value: city.id,
      ));
    }
    return list;
  }

  void refresh(){
    setState(() {

    });
  }
}

