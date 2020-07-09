import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginapp/Address/location_page.dart';
import 'package:loginapp/app_data.dart';
import 'package:loginapp/constant.dart';
import 'package:http/http.dart' as http;
import 'package:loginapp/Widgets/appbar_widgets.dart';
import 'package:loginapp/home_page.dart';
import 'package:loginapp/loading_screen.dart';
import 'package:provider/provider.dart';
import '../order_page.dart';

List<Address> addresses = [];
String phoneNumber;
int id;
int radioValue = 0;
bool isLoading = true;
bool isError = false;
bool isOrderSuccessful;
var data;


class Address {
  int id;
  double lat;
  double long;
  String address;
  String city;
  int pincode;
  String note;
  String name;

  Address(this.id, this.lat, this.long, this.address, this.city, this.pincode,
      this.note, this.name);
  Map toJson() {
    return {
      "lat": lat,
      "long": long,
      "address": address,
      "city": city,
      "zipcode": pincode,
      "note": note,
      "name": name
    };
  }
}

class AddressPage extends StatefulWidget {
  Address address;
  AddressPage(this.address);
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {

  Future addAddres() async {
    print(jsonEncode(this.widget.address.toJson()));
    http.Response response =
        await http.post('$baseurl/api/v1/auth/add-location/',
            headers: {
              'Authorization': 'Bearer $authToken',
              "Accept": "application/json",
              "content-type": "application/json"
            },
            body: jsonEncode(this.widget.address.toJson()));

    print(response.statusCode);
    var data = jsonDecode(response.body);
    print(data);
    setState(() {
      addresses.add(Address(
          data['id'],
          double.parse(data['location_lat']),
          double.parse(data['location_long']),
          data['address'],
          data['city'],
          data['zip_code'],
          data['note'],
          data['name']));
    });
  }
  Future getLocations() async {
    http.Response response = await http.get(
        '$baseurl/api/v1/auth/get-locations/',
        headers: {'Authorization': 'Bearer $authToken'});
    print(response.body);
    print(response.statusCode);
    var data;
    if (response.statusCode >= 200 && response.statusCode < 300) {
      data = jsonDecode(response.body);
      setState(() {
        addresses = [];
        for (var location in data) {
          addresses.add(Address(
              location['id'],
              double.parse(location['location_lat']),
              double.parse(location['location_long']),
              location['address'],
              location['city'],
              location['zip_code'],
              location['note'],
              location['name']));
        }
      });
      isLoading = false;
      setState(() {
        isError = false;
      });
      return jsonDecode(response.body);
    } else {
      data = null;
      isLoading = false;

      setState(() {
        isError = true;
      });
      return data;
    }
  }

  Future deleteLocation(int id) async {
    setState(() {});
    print(id);
    try {
      setState(() {
        addresses.removeWhere((element) => element.id == id);
      });
      http.Response response = await http.delete(
          '$baseurl/api/v1/auth/delete-location/$id/',
          headers: {'Authorization': 'Bearer $authToken'});
      print(response.statusCode);
      print(response.body);
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  Future updateLocation(int id, Address address) async {
    print(id);
    print(jsonEncode(address.toJson()));
    http.Response response = await http.put(
      '$baseurl/api/v1/auth/update-location/$id/',
      headers: {
        'Authorization': 'Bearer $authToken',
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: jsonEncode(address.toJson()),
    );
    getLocations();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    setState(() {
      print('added');
      print(addresses.length);
      if (this.widget.address != null) {
        addAddres();
      } else {
        data = getLocations();
      }
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
onWillPop: ()async{
  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(null)));
  return true;
},
      child: Scaffold(
          appBar: AppBar(
            actions: [],
            automaticallyImplyLeading: false,
          ),
          body: Builder(builder: (context) {
            return (isLoading)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ((isError)
                    ? Center(
                        child: Container(
                        child: Text('Something went wrong'),
                      ))
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                return AddressWidget(index, context);
                              },
                              itemCount: addresses.length,
                            ),
                          ),
                          FloatingActionButton(
                            heroTag: '1',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LocationScreen()));
                            },
                            child: Icon(Icons.add),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18.0),
                            child: FloatingActionButton.extended(
                                onPressed: ()  {
                                  if (addresses.length!=0)
                                    {setState(() {
                                      isAddressChosen=true;
                                    });

                                    }
                                  Provider.of<ProfileData>(context,listen: false).updateAddress(addresses[radioValue]);
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(null)));
                                },
                                label: Text('Confirm Address')),
                          ),
                        ],
                      ));
          })),
    );
  }


  Padding AddressWidget(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black87, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Radio(
                      value: index,
                      groupValue: radioValue,
                      activeColor: Colors.white,
                      onChanged: (value) {
                        setState(() {
                          radioValue = index;
                          id = addresses[index].id;
                          print(value);
                        });
                      }),
                  Text(
                    'User Name',
                    style: kHeadingStyle,
                  ),
                  Text(
                    '${addresses[index].name}',
                    style: TextStyle(
                        backgroundColor: Colors.white, color: Colors.black87),
                  ),
                  IconButton(
                    onPressed: () {
                      showBottomSheet(
                          context: context,
                          builder: (context) {
                            TextEditingController _address =
                                TextEditingController();
                            TextEditingController _city =
                                TextEditingController();
                            TextEditingController _pincode =
                                TextEditingController();
                            TextEditingController _name =
                                TextEditingController();
                            TextEditingController _note =
                                TextEditingController();
                            _address.text = addresses[index].address;
                            _city.text = addresses[index].city;
                            _pincode.text = addresses[index].pincode.toString();
                            _name.text = addresses[index].name;
                            _note.text = addresses[index].note;

                            return Container(
                              child: Column(
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        hintText: 'Update your address'),
                                    controller: _address,
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        hintText: 'Update your city'),
                                    controller: _city,
                                  ),
                                  TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          hintText: 'Update your pincode'),
                                      controller: _pincode),
                                  TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        hintText: 'Update your name'),
                                    controller: _name,
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        hintText: 'Update your note'),
                                    controller: _note,
                                  ),
                                  FloatingActionButton.extended(
                                      onPressed: () {
                                        updateLocation(
                                            addresses[index].id,
                                            Address(
                                                addresses[index].id,
                                                addresses[index].lat,
                                                addresses[index].long,
                                                _address.text,
                                                _city.text,
                                                int.parse(_pincode.text),
                                                _note.text,
                                                _name.text));
                                        Navigator.pop(context);
                                      },
                                      label: Text('Confirm'))
                                ],
                              ),
                            );
                          });
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Are you sure you want to delete'),
                                actions: [
                                  FlatButton(
                                      onPressed: () {
                                        deleteLocation(addresses[index].id);
                                        Navigator.pop(context);
                                      },
                                      child: Text('Delete')),
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel'))
                                ],
                              );
                            });
                      })
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              child: Text(
                '${addresses[index].address},${addresses[index].city},${addresses[index].pincode}',
                style: kTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              child: Text(
                'Note:${addresses[index].note}',
                style: kTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              child: Text(
                '${Provider.of<ProfileData>(context,listen: false).phone}',
                style: kTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
