import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyecto/src/pages/administrator/create/city/city_create_controller.dart';
import 'package:proyecto/src/utils/my_colors.dart';


class CityCreatePage extends StatefulWidget {

  const CityCreatePage({Key? key}) : super(key: key);

  @override
  _CityCreatePageState createState() => _CityCreatePageState();
}

class _CityCreatePageState extends State<CityCreatePage> {

  final CityCreateController _con = CityCreateController();

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
        title: const Text('Nueva Ciudad'),
        backgroundColor: MyColors.primaryColor,
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          _textFieldCity(_con),
          const SizedBox(height: 30),
          _textFieldDepartment(_con)

        ],
      ),
      bottomNavigationBar: _buttonCreate(_con),
    );
  }

  void refresh(){
    setState(() {

    });
  }
}
Widget _buttonCreate(_con) {
  return Container(
    height: 50,
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    child: ElevatedButton(
      onPressed:_con.createCity,
      child: const Text('Crear Nueva Ciudad'),
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

Widget _textFieldCity(_con) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    child: TextField(
        controller: _con?.nameController,
        decoration: InputDecoration(
            labelText:  'Nombre de la Ciudad',
            suffixIcon: Icon(Icons.account_balance,
              color: MyColors.primaryColorDark,)
        )
    ),
  );
}

Widget _textFieldDepartment(_con) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    child: TextField(
        controller: _con?.departmentController,
        maxLength: 125,
        decoration: InputDecoration(
            labelText:  'Departamento',
            suffixIcon: Icon(Icons.location_city,
              color: MyColors.primaryColorDark,)
        )
    ),
  );
}



