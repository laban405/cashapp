import 'dart:async';
import 'dart:convert';

import 'package:cashapp/apis/httprequestsapi.dart';
import 'package:cashapp/res/commonwidgets.dart';
import 'package:cashapp/res/constants.dart';
import 'package:cashapp/screens/login.dart';
import 'package:cashapp/widgets/commonwidgets.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  String username, email, phone, password, confirmpassword;
  bool _isLoading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark1,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                3 * heightm, 1 * heightm, 3 * heightm, 1 * heightm),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(child: logo()),
                  Center(child: welcomebackText()),
                  SizedBox(
                    height: 1 * heightm,
                  ),
                  Text(
                    'FULL NAME',
                    style: TextStyle(color: Colors.grey, fontSize: 1.5 * textm),
                  ),
                  TextFormField(
                    validator: (value) {
                      if(value.length<4){
                        return 'Enter correct username';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      username=value;
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding:EdgeInsets.only(bottom: 0.2*heightm, top: 1*heightm),
                      isDense: true,
                      hintText: 'Full Name',
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
                  Text(
                    'EMAIL',
                    style: TextStyle(color: Colors.grey, fontSize: 1.5 * textm),
                  ),
                  TextFormField(
                    validator: (value) {
                      if(value.length<4){
                        return 'Enter correct email';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email=value;
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                       contentPadding:EdgeInsets.only(bottom: 0.2*heightm, top: 1*heightm),
                      isDense: true,
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
                    height: 3* heightm,
                  ),
                  Text(
                    'PHONE NUMBER',
                    style: TextStyle(color: Colors.grey, fontSize: 1.5 * textm),
                  ),
                  TextFormField(
                    validator: (value) {
                      if(value.length<10){
                        return 'Enter correct phone number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      phone=value;
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                       contentPadding:EdgeInsets.only(bottom: 0.2*heightm, top: 1*heightm),
                      isDense: true,
                      hintText: 'Phone Number',
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
                  
                  SizedBox(
                    height: 3 * heightm,
                  ),
                  Text(
                    'PASSWORD',
                    style: TextStyle(color: Colors.grey, fontSize: 1.5 * textm),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.length<4) {
                        return 'Password is too short';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      password=value;
                      
                    },
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(
                       contentPadding:EdgeInsets.only(bottom: 0.2*heightm, top: 1*heightm),
                      isDense: true,
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
                  Text(
                    'CONFIRM PASSWORD',
                    style: TextStyle(color: Colors.grey, fontSize: 1.5 * textm),
                  ),
                  TextFormField(
                    validator: (value) {
                      if(value!=password){
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      confirmpassword=value;
                    },
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    
                    decoration: InputDecoration(
                       contentPadding:EdgeInsets.only(bottom: 0.2*heightm, top: 1*heightm),
                      isDense: true,
                      hintText: 'Confirm Password',
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot password?',
                      style:
                          TextStyle(color: Colors.grey, fontSize: 1.5 * textm),
                    ),
                  ),
                  SizedBox(
                    height: 4 * heightm,
                  ),
                  Center(
                    child: SizedBox(
                      width: 80 * widthm,
                      height: 6 * heightm,
                      child: FlatButton(
                        color: blue1,
                        disabledColor: blue1,
                        onPressed:_isLoading?null: () {
                          registerUser();
                          // Navigator.push(
                          //     context,
                          //     PageTransition(
                          //         child: DashBoard(),
                          //         type: PageTransitionType.rightToLeft));
                        },
                        child:_isLoading? spinkitwhite: Text(
                          'CREATE ACCOUNT',
                          style: TextStyle(
                              color: Colors.white, fontSize: 2.3 * textm),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2 * heightm,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: Login(),
                              type: PageTransitionType.leftToRight));
                    },
                    child: Center(
                      child: Text(
                        'Already Have an Account',
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
      height: heightm * 20,
      width: heightm * 20,
      // color: Colors.white,
    );
  }

  Widget welcomebackText() {
    return Text(
      'Welcome',
      textAlign: TextAlign.center,
      style: TextStyle(
          // fontStyle: FontStyle.italic,
          fontSize: 3 * textm,
          fontWeight: FontWeight.w700,
          color: Colors.white),
    );
  }

  
   registerUser() async {
    
    _formKey.currentState.save();
    if (!_formKey.currentState.validate()) {
      //  showToast(context, 'Enter valid details');
      return;
    }

    setState(() {
      _isLoading = true;
    });
    
  try{
    

    var data= {  
  "email": email,
  "full_name": username,
  "otp": true,
  "password": password,
  "phone_number": phone,
  "user_type_enum": "Customer"
};
    print('data is $data');
    

    var res = await registerpostData(data, 'users').timeout(const Duration(seconds: 30));
    var body= json.decode(res.body);

    print('register response is ${res.body}');
    print('register response is ${res.statusCode}');
    if(res.statusCode==200){
    Navigator.push(context,
        PageTransition(child: Login(), type: PageTransitionType.leftToRight));
    showToast(context, '${body['message']}');
    }
    else {
      showToast(context, '${body['message']}');
   }

  } on TimeoutException{
    showToast(context, 'Error: time out');
  } 


    
    setState(() {
      _isLoading = false;
    });
  }
}
