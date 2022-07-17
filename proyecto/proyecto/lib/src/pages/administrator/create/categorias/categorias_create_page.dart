import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyecto/src/pages/administrator/create/categorias/categorias_create_controller.dart';
import 'package:proyecto/src/utils/my_colors.dart';

class CategoriaCreatePage extends StatefulWidget {

  const CategoriaCreatePage({Key? key}) : super(key: key);

  @override
  _CategoriaCreatePageState createState() => _CategoriaCreatePageState();
}


class _CategoriaCreatePageState extends State<CategoriaCreatePage> {

  final CategoriaCreateController _con = CategoriaCreateController();

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
        title: const Text('Nueva Categoria'),
        backgroundColor: MyColors.primaryColor,
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          _textFieldCategoria(_con),
          const SizedBox(height: 30),
          _textFieldDescripcion(_con)

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
      onPressed:_con.createCategory,
      child: const Text('Crear Categoria'),
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

Widget _textFieldCategoria(_con) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
    ),
    child: TextField(
      controller:_con.nameController ,
      decoration: InputDecoration(
        hintText: 'Nombre de la Categoria',
        hintStyle: TextStyle(
            color: MyColors.primaryColorDark
        ),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(15),
        prefixIcon: Icon(
          Icons.list_alt_outlined,
          color: MyColors.primaryColor,),
      ),
    ),
  );
}

Widget _textFieldDescripcion(_con) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
    ),
    child: TextField(
      controller:_con.descriptionController ,
      maxLines: 3,
      maxLength: 255,
      decoration: InputDecoration(
        hintText: 'Descripcion',
        hintStyle: TextStyle(
            color: MyColors.primaryColorDark
        ),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(15),
        prefixIcon: Icon(
          Icons.description,
          color: MyColors.primaryColor,),
      ),
    ),
  );
}


