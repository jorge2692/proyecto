import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyecto/src/models/equipos.dart';
import 'package:proyecto/src/models/esp8266.dart';
import 'package:proyecto/src/pages/administrator/create/equipos/history/history_controller.dart';
import 'package:proyecto/src/utils/my_colors.dart';

class HistoryPage extends StatefulWidget {

  Equipos? equipos;
  HistoryPage({Key? key, @required this.equipos}): super(key: key);
  



  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool prueba = false;
  HistoryController _con = HistoryController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp){
      _con.init(context,refresh, widget.equipos!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, AsyncSnapshot<Esp8266?> snapshot){
      if(snapshot.connectionState==ConnectionState.waiting){

        return CircularProgressIndicator();

      }
      return Scaffold(
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height *0.9,
            child: Column(
              children: [
                _textName(),
                _textDescription(),
                _textData(),
                Spacer(),
                _buttonEncendido(snapshot.data)
              ],
            ),
          ),
        ),
      );

    },
      future: _con.getEspByMachine(widget.equipos!.id!),
    );

  }

  Widget _textName(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 30,top: 20, right: 10),
      child: Text(
          _con.equipos?.name ?? '',
          style: TextStyle(
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
                child: Text(
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
                child: Icon(Icons.power_settings_new_rounded),
                margin: EdgeInsets.only(left: 50, top: 10),
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
      margin: EdgeInsets.only(left: 30,top: 20, right: 10),
      child: Text(
          _con.equipos?.description ?? '',
          style: TextStyle(
            fontSize: 13,
          )
      ),
    );


  }

  Widget _textData(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 30,top: 20, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Serial: ${_con.equipos?.serial.toString() ?? ''}',
              style: TextStyle(
                fontSize: 17,
              )
          ),
          Text(
              'Model: ${_con.equipos?.model.toString() ?? ''}',
              style: TextStyle(
                fontSize: 17,
              )
          ),
          Text(
              'Voltaje: ${_con.equipos?.voltaje.toString() ?? ''}',
              style: TextStyle(
                fontSize: 17,
              )
          ),
          Text(
              'Corriente: ${_con.equipos?.corriente.toString() ?? ''}',
              style: TextStyle(
                fontSize: 17,
              )
          ),
          Text(
              'Potencia: ${_con.equipos?.potencia.toString() ?? ''}',
              style: TextStyle(
                fontSize: 17,
              )
          ),
        ],
      ),
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
