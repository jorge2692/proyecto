import 'package:flutter/material.dart';
import 'package:proyecto/widgets/widgets.dart';


class ControlScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        leading: IconButton(
          onPressed: () { },
          icon: Icon(Icons.more_vert_sharp),
        ),
        title: Text('Torre 1'), elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Valores(),

              Prueba()




            ],
          ),
        )
    );
  }
}




