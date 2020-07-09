import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginapp/Auth/new_user_page.dart';
import 'package:loginapp/Auth/otp_page.dart';
import 'package:loginapp/Auth/signin_number.dart';
import 'package:loginapp/FirstTime/intro2.dart';
import 'package:loginapp/app_data.dart';
import 'package:loginapp/constant.dart';
import 'package:loginapp/home_page.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:loginapp/landing_page.dart';
import 'package:loginapp/loading_screen.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'dart:developer' as developer;
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _formKey = GlobalKey<FormState>();
CountryCode code = CountryCode(code: '+91');
TextEditingController _controller = TextEditingController();
bool isFirstTime=true;
void main()async {
  runApp(MyApp());
}




class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileData(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Colors.black,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: LandingPage()
      )
    );
  }
}

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  void verifyForm() {
    if (_formKey.currentState.validate()) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoadingScreen('Sending otp...')));
      getPhoneNo();
    }
  }

  Future getPhoneNo() async {
    try {
      print(code.code);
      print(_controller.text);
      http.Response response =
          await http.post('$baseurl/api/v1/auth/generate-otp/', body: {
        "username": "${code.code}${_controller.text}",
      });
      print(response.statusCode);
      print(response.body);
      if (response.statusCode > 200 && response.statusCode < 300) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    OtpScreen('+91${_controller.text}', true)));
      }
    } catch (e) {
      print(e);
    }
  }
  

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
                Text(
                  'Signp',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey, width: 1)),
                    child: Row(
                      children: [
                        CountryCodePicker(
                          initialSelection: '+91',
                          favorite: ['+91'],
                          onChanged: (data) {
                            code = data;
                          },
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                hintText: "Enter your phone number",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 0)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30)),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 0))),
                            controller: _controller,
                            keyboardType: TextInputType.phone,
                            validator: (data) => (data.length == 10)
                                ? null
                                : 'The mobile number is not valid',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      verifyForm();
                    },
                    label: Text('Get OTP'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Text('Already Registered ?Click here'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                      heroTag: 'skip',
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(null)));

                      }, label:Text('Skip')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
