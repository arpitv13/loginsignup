import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loginapp/Auth/signin_number.dart';
import 'package:loginapp/constant.dart';
import 'package:provider/provider.dart';
import 'package:loginapp/Screens/intro.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_data.dart';
import 'home_page.dart';
class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Future loggedIn()async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    if (preferences.getString('isFirst')==null)
     {Navigator.push(context, MaterialPageRoute(builder: (context)=>intro()));
     }
   else{

    if (preferences.getString('isLogin')!=null)
    {print(preferences.getString('isLogin'));

    Provider.of<ProfileData>(context,listen: false).updateAuth(preferences.getString('phone'), preferences.getString('isLogin'));
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(preferences.getString('isLogin'))));

    }
  else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    }
  }}
@override
  void initState() {
    super.initState();
  loggedIn();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 1,),

          Center(
            child: FaIcon(
              FontAwesomeIcons.wineGlassAlt,color: Colors.white,size: 100,
            ),
          ),
          Text('BATLIWALE',style: kHeadingStyle,)

        ],


      ),


    );
  }
}