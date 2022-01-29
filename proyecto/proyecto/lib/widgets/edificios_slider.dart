import 'package:flutter/material.dart';


class EdificioSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical:5 ),
          child: Text('Edificios', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
           GestureDetector(
             onTap: () => Navigator.pushNamed(context, 'equipo'),
             child: SizedBox(child:ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage('https://via.placeholder.com/300x400'),
                width: 140,
                height: 140,
                fit: BoxFit.cover
              ),
             ),
             ),
           ),
          SizedBox(height: 5,),
          Text("Hola si no lees esto es que es muy largo entonces estamos corrigiendo eso",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

