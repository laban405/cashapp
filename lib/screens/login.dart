import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cashapp/apis/httprequestsapi.dart';
import 'package:cashapp/apis/profiledata.dart';
import 'package:cashapp/blocs/balance_bloc.dart';
import 'package:cashapp/res/commonwidgets.dart';
import 'package:cashapp/res/constants.dart';
import 'package:cashapp/screens/forgotpassword.dart';
import 'package:cashapp/screens/home.dart';
import 'package:cashapp/screens/signup.dart';
import 'package:cashapp/widgets/commonwidgets.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _username, _password;
  bool _isLoading = false;
  //final BalanceBloc balanceBloc=Provider.of<BalanceBloc>();

  @override
  Widget build(BuildContext context) {
    final BalanceBloc balanceBloc = Provider.of<BalanceBloc>(context);
    return Scaffold(
      backgroundColor: dark1,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                5 * heightm, 1 * heightm, 5 * heightm, 1 * heightm),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(child: logo()),
                  Center(child: welcomebackText()),
                  SizedBox(
                    height: 8 * heightm,
                  ),
                  Text(
                    'EMAIL',
                    style: TextStyle(color: Colors.grey, fontSize: 1.5 * textm),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.length < 4) {
                        return 'Enter correct email';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _username = value;
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          bottom: 0.2 * heightm, top: 1 * heightm),
                      hintText: 'Email',
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
                    height: 6 * heightm,
                  ),
                  Text(
                    'PASSWORD',
                    style: TextStyle(color: Colors.grey, fontSize: 1.5 * textm),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.length < 4) {
                        return 'Password it too short';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _password = value;
                    },
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          bottom: 0.2 * heightm, top: 1 * heightm),
                      hintText: 'Password',
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
                    height: 3 * heightm,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          PageTransition(
                              child: ForgotPassword(),
                              type: PageTransitionType.rightToLeft));
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                            color: Colors.grey, fontSize: 1.5 * textm),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6 * heightm,
                  ),
                  Center(
                    child: SizedBox(
                      width: 80 * widthm,
                      height: 6 * heightm,
                      child: FlatButton(
                        color: blue1,
                        disabledColor: blue1,
                        onPressed: _isLoading
                            ? null
                            : () {
                                _loginUser(balanceBloc);
                              },
                        child: _isLoading
                            ? spinkitwhite
                            : Text(
                                'LOGIN',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 2.3 * textm),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3 * heightm,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: Signup(),
                              type: PageTransitionType.rightToLeft));
                    },
                    child: Center(
                      child: Text(
                        'Create Account?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // fontStyle: FontStyle.italic,
                            fontSize: 2.3 * textm,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
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

  Widget welcomebackText() {
    return Text(
      'Welcome back!',
      textAlign: TextAlign.center,
      style: TextStyle(
          // fontStyle: FontStyle.italic,
          fontSize: 3.5 * textm,
          fontWeight: FontWeight.w700,
          color: Colors.white),
    );
  }

  _loginUser(BalanceBloc balanceBloc) async {
    print("pass $_username, $_password");
    var res;
    setState(() {
      _isLoading = true;
      accesstoken = null;
    });

    if (_formKey.currentState.validate()) {
      try {
        res = await requestToken(_username, _password)
            .timeout(const Duration(seconds: 30));
        //print('access token response: $res');
        if (res != null) {
          var _res = await getData('users');
          print('profile data ${_res.body}');

          var profilebody = json.decode(_res.body);
          profilebody=profilebody['content'][0];

          if (_res.statusCode == 200) {
            SharedPreferences localData = await SharedPreferences.getInstance();
            setState(() {
              localData.setString(
                  'balance',
                  profilebody['account_balance'] == null
                      ? ""
                      : profilebody['account_balance'].toString());
              localData.setString('phone', profilebody['phone_number']);
              localData.setString('email', profilebody['email']);
              localData.setString('lastlogin', profilebody['last_login']);
              localData.setString('name', profilebody['full_name']);
              localData.setString('currency', profilebody['currency']);
            });

            setState(() {
              balance = profilebody['account_balance'].toString();
            });
            balanceBloc.updateBalance(profilebody['account_balance']);
          }
          print('profile body $profilebody');
          Navigator.push(
              context,
              PageTransition(
                  child: Home(), type: PageTransitionType.rightToLeft));
          showToast(context, 'Login successful');
        } else {
          print("res  $res");
          showToast(context, 'Invalid login credentials');
        }
      } on TimeoutException {
        showToast(context, 'Error: time out');
      } on SocketException {
        showToast(context, 'Error: cannot find server');
      }
    } else {
      showToast(context, 'Enter valid details');
    }

    setState(() {
      _isLoading = false;
      accesstoken = res;
    });
  }
}
