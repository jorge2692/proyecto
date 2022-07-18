import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proyecto/src/pages/administrator/create/map/edificios_map_controller.dart';
import 'package:proyecto/src/utils/my_colors.dart';

class EdificiosMapPage extends StatefulWidget {

  const EdificiosMapPage({Key? key}) : super(key: key);

  @override
  _EdificiosMapPageState createState() => _EdificiosMapPageState();
}


class _EdificiosMapPageState extends State<EdificiosMapPage> {

  EdificiosMapController? _con;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con = EdificiosMapController();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con?.init(context, refresh);});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Direccion'),
        backgroundColor: MyColors.primaryColor,
      ),
      body: Stack(
        children: [
          _googleMaps(),
          Container(
            alignment: Alignment.center,
            child: _iconMyLocation(),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.topCenter,
            child: _cardAddress(),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: _buttonSelect(),
          )
        ],
      ),
    );
  }

  Widget _buttonSelect() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
      child: ElevatedButton(
        onPressed: _con?.selectRefPoint,
        child: const Text('Seleccionar este Punto'),
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



  Widget _cardAddress(){
    return SizedBox(
      child: Card(
        color: Colors.grey[500],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
            _con?.addressName ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
      ),
      )
    );
  }



  Widget _iconMyLocation(){
    return Image.asset(
      'assets/pngegg.png',
          width: 40,
          height: 40,
    );
  }

  Widget _googleMaps() {

    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _con!.initialPosition,
      onMapCreated: _con!.onMapCreated,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      onCameraMove: (position) {
        _con?.initialPosition = position;
      },
      onCameraIdle: () async{
        await _con?.setLocationDraggableInfo();
      },

    );
  }


  void refresh(){
    setState(() {

    });
  }
}






