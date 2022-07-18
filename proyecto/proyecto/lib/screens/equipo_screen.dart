import 'package:flutter/material.dart';

class EquipoScreen extends StatelessWidget {

  static const paddingHorizontalCommon = EdgeInsets.only(left: 9, right: 9);
  static const double productCardAspectRatio = (2.5/1);

  const EquipoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Studio 57'),
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
            itemBuilder: (context, index) => _EquipoPoster(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: 12,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }
}

class _EquipoPoster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 100,
      child: Column(
        children: [
          Card(child: ListTile(
            leading: const Icon(Icons.invert_colors_on_sharp),
            title: const Text('Lavadora/Secadora'),
            subtitle: const Text('Esp8266'),
            isThreeLine: true,
            onTap: () => Navigator.pushNamed(context, 'control'),
            tileColor: Colors.yellow,),
          ),
        ],
      ),
    );
  }
}

