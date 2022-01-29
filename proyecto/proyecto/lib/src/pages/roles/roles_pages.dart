import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyecto/src/models/rol.dart';
import 'package:proyecto/src/pages/roles/roles_controller.dart';


class RolesPages extends StatefulWidget {
  const RolesPages({Key? key}) : super(key: key);

  @override
  _RolesPagesState createState() => _RolesPagesState();
}


class _RolesPagesState extends State<RolesPages> {

  RolesController _con = new RolesController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar un rol'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15),
        child: ListView(
          children:
            _con.user != null ? _con.user!.roles!.map((Rol rol) {
              return _cardRol(rol);
            }).toList(): [],

        ),
      ),

    );
  }
  
  Widget _cardRol(Rol rol) {
    print(rol.image);
    return GestureDetector(
      onTap: (){
        _con.goToPage(rol.route??'');
      },
      child: Column(
        children: [
          Container(

              height: 100,
              child: rol.image == null ? _notImg() : FadeInImage(
                image: NetworkImage(rol.image!),
                fit: BoxFit.contain,
                fadeInDuration: const Duration(milliseconds: 50),
                placeholder: AssetImage('assets/no-image.jpg'),
              )
            ),
          SizedBox(height: 20,),
          Text(
            rol.name ?? '',
            style: TextStyle(
            fontSize: 16,
            color: Colors.black,

          ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
    // ignore: dead_code

  }

  Widget _notImg(){
    return const FadeInImage(
      image: AssetImage('assets/no-image.jpg'),
      fit: BoxFit.contain,
      fadeInDuration: Duration(milliseconds: 50),
      placeholder: AssetImage('assets/no-image.jpg'),
    );
  }

  void refresh(){
    setState(() {});
  }
}

