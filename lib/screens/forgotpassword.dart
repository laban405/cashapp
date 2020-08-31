import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cashapp/apis/httprequestsapi.dart';
import 'package:cashapp/res/commonwidgets.dart';
import 'package:cashapp/res/constants.dart';
import 'package:cashapp/widgets/commonwidgets.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'newpassword.dart';

String email;

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  bool isSendOtpLoading = false;
  bool isResetLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark1,
      body: SafeArea(
        child:SingleChildScrollView(
          child:
        Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
//                      Navigator.pushReplacement(
//                        context,
//                        PageTransition(
//                            type: PageTransitionType.leftToRight,
//                            child: ForgotPassword()),
//                      );
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        4*widthm, 4*widthm, 0, 0),
                    child: Icon(
                      Icons.arrow_back,
                      size: 8*widthm,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5 * heightm,
            ),
            logo(),
            forgotPasswordText(),
            Text(
              'Enter the email associated with your account',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 2 * textm),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  5 * widthm, 2 * heightm, 5 * widthm, 2 * heightm),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'EMAIL',
                      style:
                          TextStyle(color: Colors.grey, fontSize: 1.5 * textm),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.length < 1) {
                          return 'Enter valid email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        email = value;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            bottom: 0.2 * heightm, top: 1 * heightm),
                        hintText: 'Enter email',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: new UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5 * heightm,
                    ),
                    Center(
                      child: SizedBox(
                        width: 100 * widthm,
                        height: 6 * heightm,
                        child: FlatButton(
                          color: blue1,
                          disabledColor: blue1,
                          onPressed: isSendOtpLoading
                              ? null
                              : () {
                                  requestOTP();
                                },
                          child: isSendOtpLoading
                              ? spinkitwhite
                              : Text(
                                  'SUBMIT',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 2.3 * textm),
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),)
      ),
    );
  }

  Widget logo() {
    return Image.asset(
      'assets/images/logo.png',
      height: heightm * 24,
      width: heightm * 24,
      // color: Colors.white,
    );
  }

  Widget forgotPasswordText() {
    return Padding(
      padding: EdgeInsets.only(top: 4 * heightm, bottom: 2 * heightm),
      child: Text(
        'Forgot password?',
        textAlign: TextAlign.center,
        style: TextStyle(
            // fontStyle: FontStyle.italic,
            fontSize: 3.5 * textm,
            fontWeight: FontWeight.w700,
            color: Colors.white),
      ),
    );
  }

  requestOTP() async {
    setState(() {
      isSendOtpLoading = true;
    });

    var res;
    var data = {};
    var url = '${ipaddress}api/users/resetPassword?email=$email';

    if (!_formKey.currentState.validate()) {
      showToast(context, 'Enter valid details');

      return;
    } else {
      _formKey.currentState.save();
      try {
        res =
            await resetPassword(data, url).timeout(const Duration(seconds: 30));
        var body = json.decode(res.body);
        print('access reset response: $body');
        print('access reset status code ${res.statusCode}');

        if (res.statusCode == 200) {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.downToUp, child: NewPasswordReset()),
          );
          showToast(context, '${body['message']}');
        } else {
          showToast(context, '${body['message']}');
        }
      } on TimeoutException {
        showToast(context, 'Error: time out');
      } on SocketException {
        showToast(context, 'Error: cannot find server');
      }
    }

    setState(() {
      isSendOtpLoading = false;
    });
  }
}
