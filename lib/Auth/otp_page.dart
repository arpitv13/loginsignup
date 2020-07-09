import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:loginapp/Auth/signin_number.dart';
import 'package:loginapp/constant.dart';
import 'package:loginapp/home_page.dart';
import 'package:loginapp/loading_screen.dart';
import 'package:provider/provider.dart';
import '../app_data.dart';
import 'new_user_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

String otp;

class OtpScreen extends StatefulWidget {
  String mobile;
  String authType;
  bool isNewUser;
  OtpScreen(this.mobile, this.isNewUser);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController _controller = TextEditingController();
  Future verifyOTP(BuildContext buildContext) async {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoadingScreen('verifying otp..')));
    print(this.widget.mobile);
    print(otp);
    print('implementing');

    http.Response response = this.widget.isNewUser
        ? await http.post('$baseurl/api/v1/auth/registration/',
            body: {
                'username': '${this.widget.mobile}',
                'otp': '$otp',
                'user_type_id': '2'
              })
        : await http.post('$baseurl/api/v1/auth/login/',
            body: {'username': '${this.widget.mobile}', 'otp': '$otp'});
    print(response.statusCode);

    print(response.body);
    var data = jsonDecode(response.body);
if (response.statusCode>=200&&response.statusCode<300) {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString('isLogin', data['token']);
  await preferences.setString('phone', this.widget.mobile);

  Provider.of<ProfileData>(context,listen: false).updateAuth(this.widget.mobile,data['token']);
  (this.widget.authType == '$baseurl/api/v1/auth/register')
      ? Navigator.push(
      context, MaterialPageRoute(builder: (context) => NewUserScreen()))
      : Navigator.push(context,
      MaterialPageRoute(builder: (context) => HomePage(data['token'])));
}
else {
  Navigator.pop(context);
  //Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPage()));
  Scaffold.of(buildContext).showSnackBar(SnackBar(content: Text('$data'),backgroundColor: Colors.red,));
}
  }

  @override
  void initState() {
    super.initState();
  }
  // TODO :UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Builder(
        builder: (context){

          return Container(
            child: Center(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PinFieldAutoFill(
                        codeLength: 4,
                        currentCode: '',
                        onCodeChanged: (code) {
                          otp = code;
                          print(otp);
                        },
                        onCodeSubmitted: (code) {
                          otp = code;
                          print(otp);
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton.extended(
                        onPressed: () {
                    verifyOTP(context);


                    },
                        label: Text('Confirm OTP')),
                  )
                ],
              ),
            ),
          );

        },
      ),
    );
  }
}