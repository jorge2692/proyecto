import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proyecto/providers/address_provider.dart';
import 'package:proyecto/providers/cities_provider.dart';
import 'package:proyecto/src/models/address.dart';
import 'package:proyecto/src/models/city.dart';
import 'package:proyecto/src/models/response_api.dart';
import 'package:proyecto/src/models/user.dart';
import 'package:proyecto/src/pages/administrator/create/map/edificios_map_page.dart';
import 'package:proyecto/src/utils/my_snackbar.dart';
import 'package:proyecto/src/utils/shared_pref.dart';

class EdificiosCreateController {

  BuildContext? context;
  TextEditingController refPointController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController neighborhoodController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  Map<String, dynamic>? refPoint;

  Function? refresh;

  final AddressProvider _addressProvider = AddressProvider();
  final CitiesProvider _citiesProvider = CitiesProvider();
  User? user;
  final SharedPref _sharedPref= SharedPref();

  List<City> cities = [];

  String? idCity;

  Future? init(BuildContext context, Function refresh) async {

    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    _addressProvider.init(context, user);
    _citiesProvider.init(context, user);

    getCities();

  }

  void getCities()async{
    cities = await _citiesProvider.getAll();
    refresh!();

  }

  void createEdificio() async {
    String name = nameController.text;
    String addressName = addressController.text;
    String neighborhood = neighborhoodController.text;
    //String city = cityController.text;
    double lat = refPoint?['lat'] ?? 0;
    double lng = refPoint?['lng'] ?? 0;


    if(name.isEmpty || addressName.isEmpty || neighborhood.isEmpty ){
      MySnackbar.show(context!,'Ingresar todos los campos');
      return;
    }



    if(idCity == null){

      MySnackbar.show(context!,'Seleccionar la Ciudad');
      return;

    }

    Address address = Address(
      name: name,
      address: addressName,
      neighborhood: neighborhood,
      idCity: int.parse(idCity!),
      lat: lat,
      lng: lng,

    );

    ResponseApi? responseApi = await _addressProvider.create(address);

    try {
      MySnackbar.show(context!,responseApi!.message!);
    } catch (e) {
      print(e);
    }

    if (responseApi!.success!){
      Fluttertoast.showToast(msg: responseApi.message!);
      Navigator.pop(context!);
    }

  }

  void openMap() async{
    try {
      refPoint  = await showMaterialModalBottomSheet(
          context: context!,
          isDismissible: false,
          enableDrag: false,
          builder: (context) => const EdificiosMapPage()
      );
      if (refPoint != null){
        refPointController.text = refPoint!['address'];
        refresh!();
      }
    } catch (e) {
      print(e);
    }
  }
}

