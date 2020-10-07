import 'package:cashapp/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();



//spinkit
final spinkitblue = SpinKitThreeBounce(
  color: blue1,
  size: 5*widthm,
);
final spinkitblack = SpinKitThreeBounce(
  color: Colors.black,
  size: 20.0,
);

final spinkitred = SpinKitThreeBounce(
  color: Colors.red,
  size: 15.0,
);

void showToast(BuildContext context, String text) {
  
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    
    backgroundColor: Colors.white,
    textColor: blue1,
    fontSize: 2*textm,
  );
}

void showToastRed(BuildContext context, String text) {
  
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    
    backgroundColor: Colors.red[600],
    textColor: Colors.white,
    fontSize:2*textm,
  );
}

showSnackBar(BuildContext context, String message) {
  
  scaffoldKey.currentState
    ..showSnackBar(SnackBar(
      duration: Duration(
        seconds: 2,
      ),
      backgroundColor: Colors.black87,
      content: SizedBox(
        height: 5*heightm,
        child: Center(
          child: Text(
            '$message',
            style: TextStyle(color: Colors.white, fontSize: 2*textm),
          ),
        ),
      ),
    ));
}

