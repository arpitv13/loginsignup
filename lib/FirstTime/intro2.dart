import 'package:flutter/material.dart';
import 'package:loginapp/Auth/signin_number.dart';
import 'package:loginapp/FirstTime/intro1.dart';
import 'package:loginapp/constant.dart';
import 'package:loginapp/landing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
class IntroPage2 extends StatefulWidget {
  @override
  _IntroPage2State createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 0,),
            Column(
              children: [ Center(child: Image.asset('images/shield.png')),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Batliwale is a certified company and we provide the customers original branded products ',style: kTextStyle.copyWith(color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>IntroPage1()));
                  }),
                  IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: ()async{
                    final Reference=await SharedPreferences.getInstance();
                    Reference.setString('isFirst', 'done');
                    Navigator.push(context,  MaterialPageRoute(builder: (context)=>LoginPage()));

                  })
                ],
              )

,
              ],
            ),

            Text('BATLIWALE',style: kHeadingStyle.copyWith(color: Colors.black),)

            
          ],
          
        ),


      )
    );
  }
}
