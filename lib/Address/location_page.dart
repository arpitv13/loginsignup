import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:loginapp/Address/address_page.dart';
import 'package:loginapp/loading_screen.dart';
class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Marker _marker;
  TextEditingController _controller=TextEditingController();
  GoogleMapController _googleMapController;
  Position chosenAddress;
List<Placemark>addedAddress=[];
  Future getLocation()async
  {Position position=await Geolocator().getCurrentPosition();
  chosenAddress=position;
  addedAddress=await Geolocator().placemarkFromCoordinates(chosenAddress.latitude, chosenAddress.longitude);
  List<Placemark> placemark=await Geolocator().placemarkFromCoordinates(position.latitude,position.longitude);
  setState(() {
    _controller.text='${placemark[0].name},${placemark[0].locality},${placemark[0].postalCode}';
  });
  _googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude,position.longitude),zoom: 18)));
  setState(() {
    _marker=Marker(markerId: MarkerId('location'),
        position: LatLng(position.latitude,position.longitude),
        icon: BitmapDescriptor.defaultMarker,
        draggable: true,
        onTap: (){print('tap');},
        infoWindow: const InfoWindow(
          title: 'info',
        ),
        onDragEnd: (position)
        {print(position);

        }
    );
  });
  }

  Future updateLocation ()async{
    List<Placemark> placemark=await Geolocator().placemarkFromAddress('${_controller.text}');
    chosenAddress=placemark[0].position;
    print(chosenAddress.longitude);
    addedAddress=await Geolocator().placemarkFromCoordinates(chosenAddress.latitude, chosenAddress.longitude);
    _googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(placemark[0].position.latitude,placemark[0].position.longitude),zoom: 18)));
  setState(() {
    _marker=Marker(markerId: MarkerId('location'),
    position: LatLng(placemark[0].position.latitude,placemark[0].position.longitude),
      icon: BitmapDescriptor.defaultMarker,
      draggable: true,
      onTap: (){print('tap');},
        infoWindow: const InfoWindow(
          title: 'info',
        ),
      onDragEnd: (position)
        {print(position);

        }
    );

  });

  }
@override
  void initState() {
    getLocation();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        Address address=Address(addresses.length+1,addedAddress[0].position.latitude, addedAddress[0].position.longitude,addedAddress[0].name,
            addedAddress[0].locality, int.parse(addedAddress[0].postalCode), 'This is the note', 'Home');
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressPage(address)));},label: Text('Confirm'),),
      body: Container(
        child: Column(
         children: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: TextField(
                controller: _controller,
                 decoration: InputDecoration(border: OutlineInputBorder(),hintText: 'enter your location',
                     suffixIcon: IconButton(icon:Icon(Icons.search),onPressed: (){
                       updateLocation();
                     },),),

               ),
             ),
           Expanded(child: GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(26.2, 75.83),zoom: 10),
            onMapCreated: (controller){
              _googleMapController=controller;
            },
             markers: (_marker!=null)?Set.of([_marker]):null,
           ),

           )
         ],

        ),

      ),

    );
  }
}
