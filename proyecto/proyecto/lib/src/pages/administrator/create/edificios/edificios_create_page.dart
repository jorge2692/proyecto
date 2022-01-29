import 'package:flutter/material.dart';


class EdificiosCreatePage extends StatefulWidget {
  @override
  _EdificiosCreatePageState createState() => _EdificiosCreatePageState();
}

class _EdificiosCreatePageState extends State<EdificiosCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Edificio'),
      ),
    );
  }
}
