import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:proyecto/src/models/equipos.dart';
import 'package:proyecto/src/models/esp8266.dart';
import 'package:proyecto/src/pages/administrator/create/equipos/details/details_create_controller.dart';
import 'package:proyecto/src/utils/my_colors.dart';

class EquiposDetailsPage extends StatefulWidget {

  final Equipos? equipos;

  const EquiposDetailsPage({Key? key, @required this.equipos}): super(key: key);

  @override
  _EquiposDetailsPageState createState() => _EquiposDetailsPageState();
}

class _EquiposDetailsPageState extends State<EquiposDetailsPage> {
  bool prueba = false;
  final EquiposDetailsController _con = EquiposDetailsController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp){
      _con.init(context,refresh, widget.equipos!);
    });
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, AsyncSnapshot<Esp8266?> snapshot){
      if(snapshot.connectionState==ConnectionState.waiting){
        return const CircularProgressIndicator();
      }
      return SizedBox(
        height: MediaQuery.of(context).size.height *0.9,
        child: Column(
          children: [
            _imageSlideshow(),
            _textName(),
            _textDescription(),
            const Spacer(),
            _buttonEncendido(snapshot.data)
          ],
        ),
      );

    },
    future: _con.getEspByMachine(widget.equipos!.id!),
    );


  }

  Widget _textName(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 30,top: 20, right: 10),
      child: Text(
        _con.equipos?.name ?? '',
        style: const TextStyle(
        fontSize: 20,
          fontWeight: FontWeight.bold
        )
      ),
    );


  }

  Widget _buttonEncendido(Esp8266? data){

    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
      child: ElevatedButton(
        onPressed: () => data == null ? null : suma(data),
        style: ElevatedButton.styleFrom(primary: data== null ? Colors.grey :( (data.gpio0 ?? false)? MyColors.primaryColor: Colors.red),
          padding: const EdgeInsets.symmetric(vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          )
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  'On',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: const Icon(Icons.power_settings_new_rounded),
                margin: const EdgeInsets.only(left: 50, top: 10),
                height: 30,
              ),
            )

          ],
        ),
      ),
    );


  }

  Widget _textDescription(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 30,top: 20, right: 10),
      child: Text(
          _con.equipos?.description ?? '',
          style: const TextStyle(
              fontSize: 13,
          )
      ),
    );


  }



  Widget _imageSlideshow(){
    return
    Stack(
      children: [
        ImageSlideshow(
          width: double.infinity,
          height: MediaQuery.of(context).size.height *0.4,
          initialPage: 0,
          indicatorColor: MyColors.primaryColor,
          indicatorBackgroundColor: Colors.grey,
          children: [
            Container(
              child: _con.equipos?.image1! == null ?  _notImg() :
              FadeInImage(
                  image:NetworkImage(_con.equipos!.image1!),
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 50),
                  placeholder: const AssetImage('assets/lavadora-sinfondo.png'),
              ),
            ),

            Container(
              child: _con.equipos?.image2! == null ?  _notImg() :
              FadeInImage(
                image:NetworkImage(_con.equipos!.image2!),
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 50),
                placeholder: const AssetImage('assets/lavadora-sinfondo.png'),
              ),
            ),
          ],

          onPageChanged: (value) =>  print('Page changed: $value'),

          autoPlayInterval: 10000,
          isLoop: true,
        ),
        Positioned(
          left: 20,
            top: 10,
            child: IconButton(
              onPressed: (){},
              icon: Icon(
                Icons.arrow_back_ios,
                color: MyColors.primaryColorDark),
            ))
      ],
    );
  }

  Widget _notImg(){
    return const FadeInImage(
      image: AssetImage('assets/iconavatar.jpeg'),
      fit: BoxFit.contain,
      placeholder: AssetImage('assets/iconavatar.jpeg'),
    );
  }

  void suma(Esp8266? esp8266)async{
    await _con.updateMachineStatus(esp8266);
    refresh();
  }


  void refresh(){
    setState(() {});
  }
}