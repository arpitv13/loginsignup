import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginapp/home_page.dart';
import 'package:loginapp/app_data.dart';
import 'package:provider/provider.dart';
import 'profile_screen.dart';
File profilePic;
String username;
String email;
File imageFile;
TextEditingController _Emailcontroller=TextEditingController();
TextEditingController _usernameController=TextEditingController();


final _formKey=GlobalKey<FormState>();

class BottomContainer extends StatefulWidget {
  @override
  _BottomContainerState createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> {

  Future getImage(ImageSource source)async{
    File image=await ImagePicker.pickImage(source: source);
    File croppedImage=await ImageCropper.cropImage(sourcePath: image.path
      ,aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],


    );
    setState(() {
      profilePic=croppedImage;
    });

  }

  @override
  void initState() {
    _Emailcontroller.text=Provider.of<ProfileData>(context,listen: false).email;
    _usernameController.text=Provider.of<ProfileData>(context,listen: false).username;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [

            ClipRRect(
              child:(profilePic!=null)?Image.file(profilePic,height: 100,width: 150,):Icon(Icons.supervised_user_circle,size: 150,),

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(icon: Icon(Icons.camera),onPressed: (){
                  print('kjfkdjk');
                  getImage(ImageSource.camera);},
                ),
                IconButton(icon: Icon(Icons.image),onPressed: (){getImage(ImageSource.gallery);},),

              ],),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                            ,hintText: 'Enter New Username'
                        ),
                        controller: _usernameController
                        ,        onSaved: (data){
                        username=data;

                      },


                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (data){
                          return(data.contains('@')&&data.contains('.')?null:'email is badly formatted');

                        },
                        controller: _Emailcontroller,
                        onSaved: (data){
                          email=data;

                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),hintText: 'Enter new email'
                        ),
                      ),
                    ),
                    Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.black,

                        child: MaterialButton(onPressed: (){saveForm();


                        },child: Text('Save',style: TextStyle(color: Colors.white),),)


                    )

                  ],
                ))


          ],


        ),


      ),
    );
  }
  void saveForm()
  {
    if (_formKey.currentState.validate())
    {
      _formKey.currentState.save();

      Provider.of<ProfileData>(context,listen: false).updateProfile(username, email, profilePic);
      print(profilePic);
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage('')));


    }
  }
}
