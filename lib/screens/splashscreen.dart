import 'dart:async';

import 'package:cashapp/res/commonwidgets.dart';
import 'package:cashapp/res/constants.dart';
import 'package:cashapp/screens/login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
  return new Timer(Duration(seconds: 5), onDoneLoading);
}

onDoneLoading() async {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
}
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark1,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: dark1,
                  ),
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height:16*heightm,
              ),
              safePayment(),
               SizedBox(
                height:1*heightm,
              ),

              withText(),
               SizedBox(
                height:1*heightm,
              ),
              junubiText(),
               SizedBox(
                height:15*heightm,
              ),
              logo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget safePayment() {
    return Text(
      'Safe Payment',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 3.5 * textm,
          fontWeight: FontWeight.w700,
          color: blue1),
    );
  }

  Widget withText() {
    return Text(
      'with',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 3.5 * textm,
          fontWeight: FontWeight.w700,
          color: Colors.white),
    );
  }

  Widget junubiText() {
    return Text(
      'JUNUBI',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontStyle: FontStyle.italic,
          fontSize: 3.5 * textm,
          fontWeight: FontWeight.w700,
          color: blue1),
    );
  }

  Widget logo() {
    return Image.asset(
      'assets/images/logo.png',
      height: heightm * 30,
     width: heightm * 30,
     // color: Colors.white,
    );
  }

  Widget spinkit() {
    return spinkitwhite;
  }
}
