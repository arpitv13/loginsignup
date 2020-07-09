import 'package:flutter/material.dart';
import 'package:loginapp/FirstTime/intro2.dart';
import 'package:loginapp/constant.dart';
class IntroPage1 extends StatefulWidget {
  @override
  _IntroPage1State createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
body:Container(
  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox()
      ,
      Column(children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('images/alcohol.jpg',width: MediaQuery.of(context).size.width-20,)),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('ENJOY a wide range of alcohol at one place!Delivered to your home in just one click!!',style: kHeadingStyle.copyWith(color: Colors.black),),)
        ,
        IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: (){
         Navigator.push(context,  MaterialPageRoute(builder: (context)=>IntroPage2()));

        })

      ],),


      Align(
          alignment: Alignment.bottomCenter,
          child: Text('BATLIWALE',style: kHeadingStyle.copyWith(color: Colors.black),))

    ],


  ),


),


    );
  }
}
