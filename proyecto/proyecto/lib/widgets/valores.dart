import 'package:flutter/material.dart';


class Valores extends StatelessWidget {

  const Valores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;


    return SizedBox(
      width: double.infinity,
      height: size.height * 0.4,
      child: Center(
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Icon(Icons.battery_charging_full_rounded, color: Colors.lightBlueAccent[500],size: 60),
                const Text('Voltaje:'),
                const Text('120'),
              ],
            ),
            Column(
              children: [
                Icon(Icons.offline_bolt, color: Colors.lightBlueAccent[500],size: 60),
                const Text('Amperios:'),
                const Text('10'),
              ],
            ),
            Column(
              children: [
                Icon(Icons.power, color: Colors.lightBlueAccent[500], size: 60,),
                const Text('Potencia:'),
                const Text('1200 W'),
              ],
            ),
          ],

        ),
      ),
    );
  }
}
