import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  final String? text;

  const NoDataWidget({Key? key, this.text}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          Image.asset('assets/no-image.jpg'),
          Text(text!)
        ],
      ),
    );
  }
}
