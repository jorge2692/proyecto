import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;

class EdificiosMapController{

  BuildContext? context;
  Function? refresh;
  Position? _position;

  String? addressName;
  LatLng? addressLatLng;

  CameraPosition initialPosition = CameraPosition(
      target: LatLng(4.6413175,-74.1592189),
    zoom: 15
  );

  Completer<GoogleMapController>_mapController = Completer();

  Future? init(BuildContext context, Function refresh){
    this.context = context;
    this.refresh = refresh;
    checkGPS();
  }

  void selectRefPoint(){
    Map<String, dynamic>? data = {
      'address': addressName,
      'lat': addressLatLng!.latitude,
      'lng': addressLatLng!.longitude,

    };

    Navigator.pop(context!, data);

  }

  Future<Null> setLocationDraggableInfo() async{

    if(initialPosition != null) {

      double lat = initialPosition.target.latitude;
      double lng = initialPosition.target.longitude;

      List<Placemark> address = await placemarkFromCoordinates(lat, lng);

      if(address != null){
        if(address.length > 0){
          String? direction = address[0].thoroughfare;
          String? street = address[0].subThoroughfare;
          String? city = address[0].locality;
          String? deparment = address[0].administrativeArea;
          String? country = address[0].country;
          addressName = '$direction #$street, $city, $deparment';
          addressLatLng = new LatLng(lat, lng);
          print('LAT: ${addressLatLng?.latitude}');
          print('LNG: ${addressLatLng?.longitude}');
          refresh!();
        }
      }

    }

  }

  void onMapCreated(GoogleMapController controller){

    _mapController.complete(controller);

  }

  void updateLocation() async{

    try{
      await _determinePosition();
      _position = await Geolocator.getLastKnownPosition();
      animateCameraToPosition(_position!.latitude, _position!.longitude);

    }catch(e){
      print('Error: $e');
    }
  }

  void checkGPS()async{

    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();


    if(isLocationEnabled){

      updateLocation();

    }
    else{

      bool locationGPS = await location.Location().requestService();

      if(locationGPS){

        updateLocation();

      }

    }

  }

  Future animateCameraToPosition(double lat,double lng) async {
    GoogleMapController controller = await _mapController.future;
    if(controller != null){

      controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(lat,lng),
              zoom: 15,
              bearing: 0,
          )
        )
      );

    }

  }


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }


    return await Geolocator.getCurrentPosition();
  }


}