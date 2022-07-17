import 'package:flutter/material.dart';


class EdificioSlider extends StatelessWidget {

  const EdificioSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text('Edificios',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
                children: List.generate (9, (index) => _EdificioPoster()
                ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EdificioPoster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
           GestureDetector(
             onTap: () => Navigator.pushNamed(context, 'equipo'),
             child: SizedBox(child:ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: const FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage('https://via.placeholder.com/300x400'),
                width: 140,
                height: 140,
                fit: BoxFit.cover
              ),
             ),
             ),
           ),
          const SizedBox(height: 5,),
          const Text("Hola si no lees esto es que es muy largo entonces estamos corrigiendo eso",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

