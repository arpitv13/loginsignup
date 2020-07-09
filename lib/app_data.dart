

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loginapp/Address/address_page.dart';
import 'package:provider/provider.dart';
class ProfileData extends ChangeNotifier{
  String email;
  String username;
  File ImageFile;
  String phone;
  String token;
  Address currentAdd;
  void updateProfile(Username,Email,Image){
    email=Email;
    username=Username;
    ImageFile=Image;
    notifyListeners();
    print(ImageFile);
  }

  void updateAuth(username,authToken){
    phone=username;
    token=authToken;
    notifyListeners();
  }
  void updateAddress(address)
  {
    currentAdd=address;
notifyListeners();
  }




}

