import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loginapp/constant.dart';
class LoadingScreen extends StatefulWidget {
String content;
LoadingScreen(this.content);
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitWave(color: Colors.black87,),
            SizedBox(height: 5,),
            Text('${this.widget.content}',style: kHeadingStyle.copyWith(color: Colors.black),)

          ],


        ),

      ),

    );
  }
}