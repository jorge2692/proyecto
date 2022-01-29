import 'package:flutter/material.dart';



class EquipoScreen extends StatelessWidget {

  static const paddingHorizontalCommon = EdgeInsets.only(left: 9, right: 9);
  static const double productCardAspectRatio = (2.5/1);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Studio 57'),
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
            itemBuilder: (context, index) => _EquipoPoster(),
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

class _EquipoPoster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      child: Column(
        children: [
          Card(child: ListTile(
            leading: Icon(Icons.invert_colors_on_sharp),
            title: Text('Lavadora/Secadora'),
            subtitle: Text('Esp8266'),
            isThreeLine: true,
            onTap: () => Navigator.pushNamed(context, 'control'),
            tileColor: Colors.yellow,),
          ),
        ],
      ),
    );
  }
}

