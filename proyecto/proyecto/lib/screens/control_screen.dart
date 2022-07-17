import 'package:flutter/material.dart';
import 'package:proyecto/widgets/widgets.dart';


class ControlScreen extends StatelessWidget {

  const ControlScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        leading: IconButton(
          onPressed: () { },
          icon: const Icon(Icons.more_vert_sharp),
        ),
        title: const Text('Torre 1'), elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Valores(),
              const Prueba()
            ],
          ),
        )
    );
  }
}




