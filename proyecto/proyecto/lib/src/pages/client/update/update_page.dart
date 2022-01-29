import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyecto/src/pages/client/update/update_controller.dart';
import 'package:proyecto/src/pages/register/register_controller.dart';
import 'package:proyecto/src/utils/my_colors.dart';

class UpdatePage extends StatefulWidget {
  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  UpdateController _con = new UpdateController();

  @override

  void initState(){

    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);}
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text('Editar perfil')
      ),
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                _imageRegister(_con),
                    SizedBox(height: 25),
                      _textFieldName(_con),
                      _textFieldLastName(_con),
              ],
            ),
          ),
        ),
      bottomNavigationBar:  _buttonRegister(_con),
    );
  }

  void refresh(){
    setState((){

    });
  }
}


Widget _circulo() {
  return Container(
    width: 240,
    height: 240,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(120),
      color: MyColors.primaryColor,
    ),
  );
}


Widget _imageRegister(_con){
  if(_con.user?.image == null){

    return GestureDetector(
        onTap: _con.showAlertDialog,
        child: _con.imageFile == null? _notImg() : CircleAvatar(
          backgroundImage: FileImage(_con.imageFile),
        radius: 60,

    )
  );
  }
else{
  return GestureDetector(
        onTap: _con.showAlertDialog,
        child: _con.imageFile == null? _imageUser(_con) : CircleAvatar(
          backgroundImage: FileImage(_con.imageFile),
          radius: 60,

  ),
    );

  }

}

Widget _notImg(){
  return const CircleAvatar(
    backgroundImage: AssetImage('assets/no-image.jpg'),
    radius: 60,
    backgroundColor: Colors.grey,
  );
}

Widget _imageUser(_con){
  return CircleAvatar(
    backgroundImage: NetworkImage(_con.user?.image),
    radius: 60,
  );


}



Widget _textFieldName(_con) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    decoration: BoxDecoration(
      color: MyColors.primaryOpacityColor,
      borderRadius: BorderRadius.circular(30),
    ),
    child: TextField(
      controller: _con.nameController,
      decoration: InputDecoration(
          hintText: 'Name',
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(
            Icons.person,
            color: MyColors.primaryColor,
          )
      ),
    ),

  );
}

Widget _textFieldLastName(_con) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
    ),
    child: TextField(
      controller: _con.lastNameController,
      decoration: InputDecoration(
        hintText: 'Last Name',
        hintStyle: TextStyle(
            color: MyColors.primaryColorDark
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(15),
        prefixIcon: Icon(
          Icons.person_outline,
          color: MyColors.primaryColor,),
      ),
    ),
  );
}


Widget _buttonRegister(_con) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    child: ElevatedButton(
      onPressed:_con.isEnable ? _con.update : null,
      child: Text('Actualizar'),
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

