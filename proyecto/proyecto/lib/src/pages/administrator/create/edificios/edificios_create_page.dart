import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyecto/src/models/city.dart';
import 'package:proyecto/src/pages/administrator/create/edificios/edificios_create_controller.dart';
import 'package:proyecto/src/utils/my_colors.dart';

class EdificiosCreatePage extends StatefulWidget {

  const EdificiosCreatePage({Key? key}) : super(key: key);

  @override
  _EdificiosCreatePageState createState() => _EdificiosCreatePageState();
}


class _EdificiosCreatePageState extends State<EdificiosCreatePage> {

  EdificiosCreateController? _con;

  @override
  void initState() {
    // TODO: implement initState
    _con = EdificiosCreateController();
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con?.init(context, refresh);});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Edificio'),
        backgroundColor: MyColors.primaryColor,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 50),
          _textFieldEdificio(),
          _textFieldAddress(),
          _textFieldNeighborhood(),
          _dropDownCities(_con!.cities,_con),
          _textFieldRefPoint(),




        ],
      ),
      bottomNavigationBar: _buttonCreate(_con),
    );
  }

  Widget _buttonCreate(_con) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: ElevatedButton(
        onPressed:_con.createEdificio,
        child: const Text('Crear Edificio'),
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

  Widget _textFieldEdificio() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con?.nameController,
          decoration: InputDecoration(
              labelText:  'Nombre de Edificio',
              suffixIcon: Icon(Icons.account_balance,
                color: MyColors.primaryColorDark,)
          )
      ),
    );
  }

  Widget _textFieldAddress() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
          controller: _con?.addressController,
          decoration: InputDecoration(
              labelText:  'Direccion',
              suffixIcon: Icon(Icons.location_city,
                color: MyColors.primaryColorDark,)
          )
      ),
    );
  }

  Widget _textFieldNeighborhood() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
          controller: _con?.neighborhoodController,
          decoration: InputDecoration(
              labelText:  'Barrio',
              suffixIcon: Icon(Icons.location_on,
                color: MyColors.primaryColorDark,)
          )
      ),
    );
  }

  Widget _dropDownCities(List<City> cities, _con ){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
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
                  value: _con!.idCity,
                  onChanged: (option){
                    setState(() {
                      print('Ciudad seleccionada: $option');
                      _con!.idCity= option;
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

  Widget _textFieldRefPoint() {
    return GestureDetector(
      onTap: (){
        _con?.openMap();
      },
      child: AbsorbPointer(
        absorbing: true,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: TextField(
              controller: _con?.refPointController,
              autofocus: false,
              focusNode: AlwaysDisabledFocusNode(),
              decoration: InputDecoration(
                  labelText:  'Punto de Referencia',
                  suffixIcon: Icon(Icons.map,
                    color: MyColors.primaryColorDark,)
              )
          ),
        ),
      ),
    );
  }


  void refresh(){
    setState(() {

    });
  }
}

class AlwaysDisabledFocusNode extends FocusNode{

  @override
  bool get hasFocus => false;


}





