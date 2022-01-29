import 'package:flutter/material.dart';
import 'package:proyecto/screens/equipo_screen.dart';

class EdificioScreen extends StatelessWidget {

  static const paddingHorizontalCommon = EdgeInsets.only(left: 9, right: 9);
  static const double productCardAspectRatio = (2.5/1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edificios'),
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.search_outlined),
              onPressed: () {})
        ],
      ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              EdificioScreen()



            ],
          ),
        )
    );
  }
}
