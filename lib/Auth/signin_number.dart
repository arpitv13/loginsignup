import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:logging/logging.dart';
import 'package:loginapp/Auth/otp_page.dart';
import 'package:loginapp/app_data.dart';
import 'package:loginapp/constant.dart';
import 'package:loginapp/home_page.dart';
import 'package:loginapp/loading_screen.dart';
import 'package:loginapp/main.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
TextEditingController _controller=TextEditingController();
CountryCode code=CountryCode(code: '+91');

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey=GlobalKey<FormState>();
  Future getPhoneNo()async
  {Navigator.push(context, MaterialPageRoute(builder: (context)=>LoadingScreen('getting otp...')));
    try {
    http.Response response = await http.post(
        '$baseurl/api/v1/auth/generate-otp/', body: {
      "username": "${code.code}${_controller.text}",
    });
    print(response.statusCode);
    print(response.body);
    if (200<=response.statusCode&&response.statusCode<300)
    {

      Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen('+91${_controller.text}',false)));

    }

  }
  catch(e){print(e);}
  }


  void verifyForm()
  {if(_formKey.currentState.validate())
     { 
      getPhoneNo();
    }
  }
  Future loggedIn()async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    if (preferences.getString('isLogin')!=null)
      {print(preferences.getString('isLogin'));

        Provider.of<ProfileData>(context,listen: false).updateAuth(preferences.getString('phone'), preferences.getString('isLogin'));
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(preferences.getString('isLogin'))));

      }



  }

  @override
  void initState() {
    loggedIn();
    Logger logger=Logger('logger');
    logger.severe('App started');
    super.initState();
  }

@override
  void dispose() {
    super.dispose();
  }
 // TODO: UI login page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(

        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text('Login',style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey,width: 1)

                    ),
                    child: Row(
                      children: [
                        CountryCodePicker(
                          initialSelection: '+91',
                          favorite: ['+91'],
                          onChanged: (data){
                            code=data;
                          },
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(prefixIcon: Icon(Icons.phone),hintText: "Ente number",border: OutlineInputBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30)),borderSide: BorderSide(color:Colors.grey,width: 0)),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30)),borderSide: BorderSide(color:Colors.grey,width: 0))),



                            controller: _controller,
                            keyboardType: TextInputType.phone,
                            validator: (data)=>(data.length==10)? null:'The mobile number is not valid',

                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                    onPressed: (){
                      verifyForm();

                    },
                    label: Text('Get OTP'),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(child: Text('New User?Register Here'),
                    onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));

                    },
                  ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                      heroTag: 'skip',
                      onPressed: (){
                        Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(null)));

                  }, label:Text('Skip')),
                )

              ],

            ),


          )
          ,


        ),

      ),

    );
  }
}