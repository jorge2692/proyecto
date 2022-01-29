

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyecto/src/pages/login/login_controller.dart';
import 'package:proyecto/src/utils/my_colors.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  LoginController _con = new LoginController();

  @override

  void initState(){

    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _con.init(context);
    }
    );
}

  Widget build(BuildContext context) {

    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                  top: -80,
                  left: -80,
                  child: _circulo()
              ),
              Column(
                children: [
                  _logoLavanti(context),
                  _campoUser(_con),
                  _campoPassword(_con),
                  _boton(_con),
                  _textDontHaveAccount(context),


                ],
              ),
            ],
          ),
        ),
      ),
    );
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


Widget _logoLavanti(BuildContext context){
  return Container(
        margin:EdgeInsets.only(top: 150,
            bottom: MediaQuery.of(context).size.height*0.15
        ),
      child: CircleAvatar(
        backgroundImage: AssetImage(
          'assets/logo-lavanti.png',
        ),
        radius: 100,
      ),
    );
}

Widget _campoUser(_con) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
    decoration: BoxDecoration(
      color: MyColors.primaryOpacityColor,
      borderRadius: BorderRadius.circular(30),
    ),
    child: TextField(
      controller: _con.emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'User',
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
          border: InputBorder.none,
      contentPadding: EdgeInsets.all(15),
        prefixIcon: Icon(
            Icons.email_outlined,
            color: MyColors.primaryColor)
      ),
    ),
  );
}

Widget _campoPassword(_con) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
    decoration: BoxDecoration(
      color: MyColors.primaryOpacityColor,
      borderRadius: BorderRadius.circular(30)
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
        prefixIcon: Icon(Icons.lock,
        color: MyColors.primaryColor,)
      ),
    ),
  );
}

Widget _boton(_con) {
  return  Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
    child: ElevatedButton(
        onPressed: _con.login,
        child: Text('Sign In'),
      style: ElevatedButton.styleFrom(primary: MyColors.primaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
      ),
          padding: EdgeInsets.symmetric(vertical: 12)
      ),
    ),
  );
}

Widget _textDontHaveAccount(BuildContext context) {
  return  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text('Forget your password',
            style: TextStyle(color: MyColors.primaryColor)
        ),
      SizedBox(width: 7),


      GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'register'),
        child: Text('Sign Up',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.primaryColor)
        ),
      ),
    ],
  );
}