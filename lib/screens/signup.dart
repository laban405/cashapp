import 'package:cashapp/res/constants.dart';
import 'package:cashapp/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark1,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                5 * heightm, 1 * heightm, 5 * heightm, 1 * heightm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(child: logo()),
                Center(child: welcomebackText()),
                SizedBox(
                  height: 1 * heightm,
                ),
                Text(
                  'USERNAME',
                  style: TextStyle(color: Colors.grey, fontSize: 1.5 * textm),
                ),
                SizedBox(
                  height: 5*heightm,
                                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: new UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2 * heightm,
                ),
                Text(
                  'EMAIL',
                  style: TextStyle(color: Colors.grey, fontSize: 1.5 * textm),
                ),
                SizedBox(
                  height: 5*heightm,
                                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
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
                ),
                SizedBox(
                  height: 2 * heightm,
                ),
                Text(
                  'BANK ACC. NUMBER',
                  style: TextStyle(color: Colors.grey, fontSize: 1.5 * textm),
                ),
                SizedBox(
                  height: 5*heightm,
                                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Bank Acc. Number',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: new UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2 * heightm,
                ),
                Text(
                  'PASSWORD',
                  style: TextStyle(color: Colors.grey, fontSize: 1.5 * textm),
                ),
                SizedBox(
                  height: 5*heightm,
                                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(
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
                ),
                 SizedBox(
                  height: 2 * heightm,
                ),
                Text(
                  'CONFIRM PASSWORD',
                  style: TextStyle(color: Colors.grey, fontSize: 1.5 * textm),
                ),
                SizedBox(
                  height: 5*heightm,
                                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(
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
                ),
                SizedBox(
                  height: 3 * heightm,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(color: Colors.grey, fontSize: 1.5 * textm),
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
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     PageTransition(
                        //         child: DashBoard(),
                        //         type: PageTransitionType.rightToLeft));
                      },
                      child: Text(
                        'CREATE ACCOUNT',
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
}
