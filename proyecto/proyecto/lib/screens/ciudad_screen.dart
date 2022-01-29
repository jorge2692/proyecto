import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';



class CiudadScreen extends StatelessWidget {

  static const paddingHorizontalCommon = EdgeInsets.only(left: 9, right: 9);
  static const double productCardAspectRatio = (1.8/1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bogota'),
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.search_outlined),
                onPressed: () {})
          ],
        ),
      body: SingleChildScrollView(
        child: Container(
            width: double.infinity,
            height: 800,
            child: GridView.builder(
            padding: paddingHorizontalCommon.copyWith(bottom: 10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: productCardAspectRatio),
            itemBuilder: (context, index) => _CiudadPoster(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: 12,
            physics: NeverScrollableScrollPhysics(),
            ),
        ),
      ),
      );
  }
}

class _CiudadPoster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            width: 200,
            height: 100,
            child: Card(child: ListTile(
              leading: Icon(Icons.maps_home_work_rounded),
              title: Text('Nombre Edificio'),
              subtitle: Text('Direccion'),
              isThreeLine: true,
              onTap: () => Navigator.pushNamed(context, 'equipo'),
              tileColor: Colors.cyan,
            ),
            ),
          )
        ],

    );
  }
}


