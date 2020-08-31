import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cashapp/apis/httprequestsapi.dart';
import 'package:cashapp/res/commonwidgets.dart';
import 'package:cashapp/res/constants.dart';
import 'package:cashapp/screens/forgotpassword.dart';
import 'package:cashapp/screens/login.dart';
import 'package:cashapp/widgets/commonwidgets.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NewPasswordReset extends StatefulWidget {
  @override
  _NewPasswordResetState createState() => _NewPasswordResetState();
}

class _NewPasswordResetState extends State<NewPasswordReset> {
  String _password;
  String _confirmpassword;
  String _code;
  bool _isLoading = false;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: dark1,
          body:SafeArea(child:SingleChildScrollView(child: Column(
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
              Padding(
                padding: EdgeInsets.fromLTRB(
                    5*widthm, 5*widthm,5*widthm, 0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 5*heightm,
                    ),
//                    Container(
//                      width: 20*widthm,
//                      height:  20*widthm,
//                      decoration: BoxDecoration(
//                        shape: BoxShape.circle,
//                      ),
//                      child: Center(
//                        child: Image.asset('assets/images/usernamepass.png'),
//                      ),
//                    ),
                    SizedBox(
                      height:5*heightm,
                    ),
                    Text(
                      'Reset password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 3*textm,
                      ),
                    ),
                    SizedBox(
                      height:2*heightm,
                    ),
                    Text(
                      'Enter reset code we just sent you!',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 2*textm,
                      ),
                    ),
                    SizedBox(
                      height: 5*heightm,
                    ),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            onChanged: (val) {
                              _code = val;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "You cannot have an empty code!";
                              }else{
                                return null;
                              }
                            },
                            style: TextStyle(
                              fontSize:2*textm,
                              color: Colors.white
                            ),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                fontSize: 2*textm,
                                color:Colors.grey
                              ),
                              contentPadding: EdgeInsets.all(4.0),
                              isDense: true,
                              hintText: 'Enter the code you received',
                              hintStyle: TextStyle(
                                fontSize: 2*textm,
                                  color:Colors.grey
                              ),
                              // helperText: 'Enter valid phone number.',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: blue1)),
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(
                            height: 8*heightm,
                          ),
                          TextFormField(
                            onChanged: (val) {
                              _password = val;
                            },
                            // onSaved: (String val) => setState(() => ),
                            validator: (value) {
                              if (value.length < 4) {
                                return "Password is too short";
                              }else{
                                return null;
                              }

                            },
                            style: TextStyle(
                              fontSize:2*textm,
                             color:Colors.white
                            ),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                fontSize: 2*textm,
                                 // color:Colors.grey
                              ),
                              contentPadding: EdgeInsets.all(4.0),
                              isDense: true,
                              hintText: 'New password',
                              hintStyle: TextStyle(
                                fontSize: 2*textm,
                                  color:Colors.grey
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: blue1)),
                            ),

                          ),
                          SizedBox(
                            height:8*heightm,
                          ),
                          TextFormField(
                            onChanged: (value) {
                              _confirmpassword = value;
                            },
                            // onSaved: (String val) => setState(() => _confirmpassword = val),
                            validator: (value) {
                              if (_confirmpassword != _password) {
                                return "Passwords do not match!";
                              }else{
                                return null;
                              }
                            },
                            style: TextStyle(
                              fontSize: 2*textm,
                                color:Colors.white
                            ),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                fontSize: 2*textm,
                              ),
                              contentPadding: EdgeInsets.all(4.0),
                              isDense: true,
                              hintText: 'Confirm password',
                              hintStyle: TextStyle(
                                fontSize:2*textm,
                                  color:Colors.grey
                              ),
                              // helperText: 'Enter valid phone number.',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: blue1)),
                            ),

                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10*heightm,
                    ),
                    Material(
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(0*widthm),
                      color: blue1,
                      child: MaterialButton(
                        disabledColor: Colors.grey,
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () {
                          _passwordresetRequest();
                        },
                        child: _isLoading
                            ? spinkitwhite
                            : Text('Continue',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 2*textm,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
    )
    ),
    ));
  }

  _passwordresetRequest() async {
    var res;
    var data = { "email": email, "new_password": _password, "otpcode": _code};
    print('reset data $data');
    var url = '${ipaddress}api/users/reset-Password';
    setState(() {
      _isLoading = true;
      //accesstoken=null;
    });
    if (!_formkey.currentState.validate()) {
      showToast(context, 'Enter valid details');
      setState(() {
        _isLoading = false;
        //accesstoken = res;
      });
      return;
    } else {
      _formkey.currentState.save();
      try {
        res =
        await resetPassword(data, url).timeout(const Duration(seconds: 30));
        var body = json.decode(res.body);
        print('reset success response: $body');
        if (res.statusCode == 200) {
          Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: Login()),
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
      _isLoading = false;
      //accesstoken = res;
    });
  }}