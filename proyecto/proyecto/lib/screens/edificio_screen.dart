import 'package:flutter/material.dart';

class EdificioScreen extends StatelessWidget {

  static const paddingHorizontalCommon = EdgeInsets.only(left: 9, right: 9);
  static const double productCardAspectRatio = (2.5/1);

  const EdificioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edificios'),
        elevation: 0,
        actions: [
          IconButton(
              icon: const Icon(Icons.search_outlined),
              onPressed: () {})
        ],
      ),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              EdificioScreen()
            ],
          ),
        )
    );
  }
}
