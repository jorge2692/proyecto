
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyecto/src/models/address.dart';
import 'package:proyecto/src/models/city.dart';
import 'package:proyecto/src/models/equipos.dart';
import 'package:proyecto/src/pages/administrator/create/esp8266/esp_create_controller.dart';
import 'package:proyecto/src/utils/my_colors.dart';


class EspCreatePage extends StatefulWidget {

  const EspCreatePage({Key? key}) : super(key: key);

  @override
  _EspCreatePageState createState() => _EspCreatePageState ();
}



class _EspCreatePageState extends State<EspCreatePage> {
  final EspCreateController _con = EspCreateController();

  List<Address> address = [];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);});
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Modulo Esp'),
        backgroundColor: MyColors.primaryColor,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 25),
          _textFieldIdEsp(),
          _textFieldSsid(),
          _textFieldPassword(),
          _dropDownCities(_con.cities,_con),
          _dropDownEdificios(_con.edificios, _con),
          _dropDownEquipos(_con.equipos, _con),
        ],

      ),
      bottomNavigationBar: _buttonCreate(),
    );
  }

  Widget _dropDownEquipos (  List<Equipos> equipos, EspCreateController _con ){
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
                    Icons.search_outlined,
                    color: MyColors.primaryColor,
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    'Equipos',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
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
                    'Seleccionar Equipo',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  items: _dropDownItems(equipos),
                  value: _con.idLavanti,
                  onChanged: (option) {
                    setState((){
                      print('Equipo seleccionado: $option');
                      _con.idLavanti = option.toString();

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


  Widget _dropDownEdificios (List  <Address> address, EspCreateController _con ){
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
                    Icons.search_outlined,
                    color: MyColors.primaryColor,
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    'Edificios',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
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
                    'Seleccionar Edificio',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  items: _dropDownIItems(address),
                  value: _con.idAddress,
                  onChanged: (option) {
                    setState((){
                      print('Edificio seleccionada: $option');
                      _con.getEquipos(option.toString());
                      _con.idAddress = option.toString();
                      _con.idLavanti = null;

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

  Widget _dropDownCities(List<City> cities, EspCreateController _con ){
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
                      _con.getEdificios(option.toString());
                      _con.idCity= option.toString();
                      _con.idAddress = null;
                      _con.idLavanti = null;

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

  List<DropdownMenuItem<String>> _dropDownIItems(List<Address> address){
    List<DropdownMenuItem<String>> list = [];
    for (var item in address) {
      list.add(DropdownMenuItem(
        child: Text(item.name ?? 'address'),
        value: item.id,
      ));
    }
    print(list);
    return list;
  }


  List<DropdownMenuItem<String>> _dropDownItems(  List<Equipos> equipos){
    List<DropdownMenuItem<String>> list = [];
    for (var item in equipos) {
      list.add(DropdownMenuItem(
        child: Text(item.name!),
        value: item.id,
      ));
    }
    print(list);
    return list;
  }


  Widget _buttonCreate() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: ElevatedButton(
        onPressed:_con.createEsp8266,
        child: const Text('Crear Modulo Esp'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            padding: const EdgeInsets.symmetric(vertical: 12)
        ),
      ),
    );

  }

  Widget _textFieldIdEsp() {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller:_con.idEspController ,
        maxLines: 1,
        maxLength: 30,
        decoration: InputDecoration(
          hintText: 'Id Modulo Esp',
          hintStyle: TextStyle(
              color: MyColors.primaryColorDark
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.account_tree_rounded,
            color: MyColors.primaryColor,),
        ),
      ),
    );
  }

  Widget _textFieldSsid() {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller:_con.ssidController ,
        maxLines: 1,
        maxLength: 30,
        decoration: InputDecoration(
          hintText: 'SSID',
          hintStyle: TextStyle(
              color: MyColors.primaryColorDark
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.wifi_sharp,
            color: MyColors.primaryColor,),
        ),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller:_con.passwordController ,
        maxLines: 1,
        maxLength: 30,
        decoration: InputDecoration(
          hintText: 'Contraseña',
          hintStyle: TextStyle(
              color: MyColors.primaryColorDark
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.lock,
            color: MyColors.primaryColor,),
        ),
      ),
    );
  }




  void refresh(){
    setState(() {

    });
  }
}






