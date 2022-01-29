import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyecto/src/pages/register/register_controller.dart';
import 'package:proyecto/src/utils/my_colors.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController _con = new RegisterController();

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
        body: Container(
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                  top: -80,
                left: -100,
                child: _circulo()
              ),
              Positioned(
                  top: 30,
                  left: 10,
                  child: _iconBack(_con)
              ),
              Container(
                margin: EdgeInsets.only(top: 135),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _imageRegister(_con),
                      SizedBox(height: 25),
                      _textFieldEmail(_con),
                      _textFieldName(_con),
                      _textFieldLastName(_con),
                      //_textFieldPhone(_con),
                      _textFieldPassword(_con),
                      _textFieldCheckPassword(_con),
                      _buttonRegister(_con),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
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

  return GestureDetector(
    onTap: _con.showAlertDialog,
      child: _con.imageFile == null? _notImg() : CircleAvatar(
            backgroundImage: FileImage(_con.imageFile),
            radius: 60,

  ),
  );

}

Widget _notImg(){
  return const CircleAvatar(
    backgroundImage: AssetImage('assets/no-image.jpg'),
    radius: 60,
    backgroundColor: Colors.grey,
  );
}


Widget _textFieldEmail(_con){

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30),
    ),
    child: TextField(
      controller: _con.emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
        hintStyle: TextStyle(
          color: MyColors.primaryColorDark,
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(15),
        prefixIcon: Icon(
          Icons.email,
          color: MyColors.primaryColor),
      ),
    ),
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
      controller: _con.idEspController,
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

Widget _textFieldPhone(_con) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30)
    ),
    child: TextField(
      controller: _con.phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: 'Phone Number',
        hintStyle: TextStyle(
            color: MyColors.primaryColorDark
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(15),
        prefixIcon: Icon(
          Icons.phone,
          color: MyColors.primaryColor,),
      ),
    ),
  );
}

Widget _textFieldPassword(_con) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    decoration: BoxDecoration(
      color: MyColors.primaryOpacityColor,
      borderRadius: BorderRadius.circular(30),
    ),
    child: TextField(
      controller: _con.passController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: TextStyle(
          color: MyColors.primaryColorDark
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(15),
        prefixIcon: Icon(
          Icons.lock,
          color: MyColors.primaryColor,
        )
      ),
    ),
  );
}

Widget _textFieldCheckPassword(_con){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
    decoration: BoxDecoration(
      color: MyColors.primaryOpacityColor,
      borderRadius: BorderRadius.circular(30),
    ),
    child: TextField(
      controller: _con.passCheckController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Confirm Your Password',
        hintStyle: TextStyle(
          color: MyColors.primaryColorDark,
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(15),
        prefixIcon: Icon(
          Icons.lock_outline,
          color: MyColors.primaryColor,
        )
      ),
    ),
  );
}

Widget _iconBack(_con) {
  return Container(
    child: IconButton(
        onPressed: _con.back,
        icon: Icon(Icons.arrow_back, color: Colors.white,)
    ),
  );
}

Widget _buttonRegister(_con) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ElevatedButton(
          onPressed:_con.isEnable ? _con.register : null,
          child: Text('Sign Up'),
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

