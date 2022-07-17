import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyecto/src/models/category.dart';
import 'package:proyecto/src/models/address.dart';
import 'package:proyecto/src/pages/administrator/create/equipos/equipos_create_controller.dart';
import 'package:proyecto/src/utils/my_colors.dart';


class EquiposCreatePage extends StatefulWidget {

  const EquiposCreatePage({Key? key}) : super(key: key);

  @override
  _EquiposCreatePageState createState() => _EquiposCreatePageState ();
}



class _EquiposCreatePageState extends State<EquiposCreatePage> {

  final EquiposCreateController _con = EquiposCreateController();

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
        title: const Text('Nuevo Equipo'),
        backgroundColor: MyColors.primaryColor,
      ),
      body: ListView(
          children: [
            const SizedBox(height: 25),
            _textFieldEquipo(),
            _textFieldDescripcion(),
            _textFieldSerial(),
            _textFieldModel(),
            _textFieldIdLavanti(),
            _textFieldvoltaje(),
            _textFieldCorriente(),
            _textFieldPotencia(),
            Container(
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _cardImage(_con.imageFile1, 1),
                  _cardImage(_con.imageFile2, 2)

                ],
              ),
            ),

            _dropDownCategories(_con.categories, _con),
            _dropDownEdificios(_con.address, _con)

          ],

      ),
      bottomNavigationBar: _buttonCreate(),
    );
  }

  Widget _dropDownCategories (List  <Category> categories, _con ){
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
                    'Categorias',
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
    for (var category in categories) {
      list.add(DropdownMenuItem(
        child: Text(category.name!),
        value: category.id,
      ));
    }
    return list;
  }

  List<DropdownMenuItem<String>> _dropDownIItems(List<Address> address){
    List<DropdownMenuItem<String>> list = [];
    for (var address in address) {
      list.add(DropdownMenuItem(
        child: Text(address.name!),
        value: address.id,
      ));
    }
    return list;
  }


  Widget _cardImage(File? imageFile, int numberFile){
    // BuildContext context;
    return GestureDetector(
      onTap: (){
        _con.showAlertDialog(numberFile);
      },
      child: imageFile != null ?
      Card(
        elevation: 3.0,
        child: SizedBox(
          height: 140,
          width: 150,
          child: Image.file(
            imageFile,
            fit: BoxFit.cover,
          ),
        ),
      )
      : const Card(
        elevation: 3.0,
          child: SizedBox(
            height: 140,
            width: 150,
            child: Image(
              image:AssetImage('assets/logo-lavanti.png'),
              fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buttonCreate() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: ElevatedButton(
        onPressed:_con.createEquipo,
        child: const Text('Crear Maquina'),
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

  Widget _textFieldEquipo() {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller:_con.nameController ,
        maxLines: 1,
        maxLength: 30,
        decoration: InputDecoration(
          hintText: 'Nombre de la Maquina',
          hintStyle: TextStyle(
              color: MyColors.primaryColorDark
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.local_laundry_service_outlined,
            color: MyColors.primaryColor,),
        ),
      ),
    );
  }

  Widget _textFieldDescripcion() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller:_con.descriptionController ,
        maxLines: 2,
        maxLength: 180,
        decoration: InputDecoration(
          hintText: 'Descripcion',
          hintStyle: TextStyle(
              color: MyColors.primaryColorDark
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.description,
            color: MyColors.primaryColor,),
        ),
      ),
    );
  }
  Widget _textFieldSerial() {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller:_con.serialController ,
        maxLines: 1,
        maxLength: 30,
        decoration: InputDecoration(
          hintText: 'Numero de Serial',
          hintStyle: TextStyle(
              color: MyColors.primaryColorDark
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.confirmation_number_outlined,
            color: MyColors.primaryColor,),
        ),
      ),
    );
  }

  Widget _textFieldModel() {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller:_con.modelController ,
        maxLines: 1,
        maxLength: 30,
        decoration: InputDecoration(
          hintText: 'Numero de Modelo',
          hintStyle: TextStyle(
              color: MyColors.primaryColorDark
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.model_training_outlined,
            color: MyColors.primaryColor,),
        ),
      ),
    );
  }

  Widget _textFieldIdLavanti() {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller:_con.idLavanti ,
        maxLines: 1,
        maxLength: 30,
        decoration: InputDecoration(
          hintText: 'Codigo Interno Empresa',
          hintStyle: TextStyle(
              color: MyColors.primaryColorDark
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.confirmation_number_outlined,
            color: MyColors.primaryColor,),
        ),
      ),
    );
  }

  Widget _textFieldvoltaje() {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller:_con.voltajeController ,
        keyboardType: TextInputType.number,
        maxLines: 1,
        maxLength: 30,
        decoration: InputDecoration(
          hintText: 'Voltaje de la Maquina',
          hintStyle: TextStyle(
              color: MyColors.primaryColorDark
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.broken_image_outlined,
            color: MyColors.primaryColor,),
        ),
      ),
    );
  }

  Widget _textFieldCorriente() {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller:_con.corrienteController ,
        keyboardType: TextInputType.phone,
        maxLines: 1,
        maxLength: 30,
        decoration: InputDecoration(
          hintText: 'Corriente de la Maquina',
          hintStyle: TextStyle(
              color: MyColors.primaryColorDark
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.warning_amber_outlined,
            color: MyColors.primaryColor,),
        ),
      ),
    );
  }
  Widget _textFieldPotencia() {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller:_con.potenciaController ,
        keyboardType: TextInputType.number,
        maxLines: 1,
        maxLength: 30,
        decoration: InputDecoration(
          hintText: 'Potencia de la Maquina',
          hintStyle: TextStyle(
              color: MyColors.primaryColorDark
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.power_rounded,
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






