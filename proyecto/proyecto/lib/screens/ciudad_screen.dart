import 'package:flutter/material.dart';



class CiudadScreen extends StatelessWidget {

  static const paddingHorizontalCommon = EdgeInsets.only(left: 9, right: 9);
  static const double productCardAspectRatio = (1.8/1);

  const CiudadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bogota'),
          elevation: 0,
          actions: [
            IconButton(
                icon: const Icon(Icons.search_outlined),
                onPressed: () {})
          ],
        ),
      body: SingleChildScrollView(
        child: SizedBox(
            width: double.infinity,
            height: 800,
            child: GridView.builder(
            padding: paddingHorizontalCommon.copyWith(bottom: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: productCardAspectRatio),
            itemBuilder: (context, index) => _CiudadPoster(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: 12,
            physics:const NeverScrollableScrollPhysics(),
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
          SizedBox(
            width: 200,
            height: 100,
            child: Card(child: ListTile(
              leading: const Icon(Icons.maps_home_work_rounded),
              title: const Text('Nombre Edificio'),
              subtitle: const Text('Direccion'),
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


