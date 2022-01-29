import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyecto/src/models/category.dart';
import 'package:proyecto/src/models/address.dart';
import 'package:proyecto/src/pages/administrator/create/esp8266/esp_create_controller.dart';
import 'package:proyecto/src/utils/my_colors.dart';


class EspCreatePage extends StatefulWidget {
  @override
  _EspCreatePageState createState() => _EspCreatePageState ();
}



class _EspCreatePageState extends State<EspCreatePage> {
  EspCreateController _con = new EspCreateController();



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
      appBar: AppBar(
        title: Text('Nuevo Modulo Esp'),
        backgroundColor: MyColors.primaryColor,
      ),
      body: ListView(
        children: [
          SizedBox(height: 25),
          _textFieldIdEsp(),
          _textFieldSsid(),
          _textFieldPassword(),

          _dropDownCategories(_con.categories, _con),
          _dropDownEdificios(_con.address, _con)

        ],

      ),
      bottomNavigationBar: _buttonCreate(),
    );
  }

  Widget _dropDownCategories (List  <Category> categories, _con ){
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
                    Icons.search_outlined,
                    color: MyColors.primaryColor,
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Categorias',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
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
                  hint: Text(
                    'Seleccionar Categoria',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  items: _dropDownItems(categories),
                  value: _con.idCategory,
                  onChanged: (option) {
                    setState((){
                      print('Categoria seleccionada: $option');
                      _con.idCategory = option;

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


  Widget _dropDownEdificios (List  <Address> address, _con ){
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
                    Icons.search_outlined,
                    color: MyColors.primaryColor,
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Edificios',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
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
                  hint: Text(
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
                      _con.idAddress = option;

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



  List<DropdownMenuItem<String>> _dropDownItems(List<Category> categories){
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((category) {
      list.add(DropdownMenuItem(
        child: Text(category.name!),
        value: category.id,
      ));
    });
    return list;
  }

  List<DropdownMenuItem<String>> _dropDownIItems(List<Address> address){
    List<DropdownMenuItem<String>> list = [];
    address.forEach((address) {
      list.add(DropdownMenuItem(
        child: Text(address.name!),
        value: address.id,
      ));
    });
    return list;
  }

  Widget _buttonCreate() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: ElevatedButton(
        onPressed:_con.createEsp8266,
        child: Text('Crear Modulo Esp'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            padding: EdgeInsets.symmetric(vertical: 12)
        ),
      ),
    );

  }

  Widget _textFieldIdEsp() {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
          contentPadding: EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.account_tree_rounded,
            color: MyColors.primaryColor,),
        ),
      ),
    );
  }

  Widget _textFieldSsid() {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
          contentPadding: EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.wifi_sharp,
            color: MyColors.primaryColor,),
        ),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
          contentPadding: EdgeInsets.all(10),
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






