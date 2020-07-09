import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginapp/constant.dart';
import 'package:loginapp/home_page.dart';
final _formkey=GlobalKey<FormState>();
class NewUserScreen extends StatefulWidget {
  @override
  _NewUserScreenState createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  File imageFile;
  void verifyForm()
  {
    if (_formkey.currentState.validate())
{
  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage('null')));

}
  }
  Future uploadId(ImageSource imageSource)async{
    PickedFile image=await ImagePicker().getImage(source:imageSource);
    setState(() {
      imageFile=File(image.path);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text('Welcome new user',style: kHeadingStyle.copyWith(color: Colors.black),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(

                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),hintText: "Enter Name here"),

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),hintText: "Enter email here"),
                validator: (data){return (data.contains('@')&&data.contains('.'))?null:'The email is badly formatted';}

              ),
            ), Text('UPLOAD YOUR GOVERNMENT ID ',style: kHeadingStyle.copyWith(color: Colors.black),),
            (imageFile!=null)?Expanded(child: Image.file(imageFile)):Image.asset('images/pass.png')
            ,Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                IconButton(icon: FaIcon(FontAwesomeIcons.image), onPressed: (){
                  uploadId(ImageSource.gallery);

                }),
                IconButton(icon: FaIcon(FontAwesomeIcons.camera), onPressed: (){
                  uploadId(ImageSource.camera);
                }),
              ],),
            ),


 FloatingActionButton.extended(onPressed: (){}, label:Text('Confirm Details'))

          ],

        ),
      ),

    );
  }
}
