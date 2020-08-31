import 'dart:math';

import 'package:cashapp/apis/profiledata.dart';
import 'package:cashapp/blocs/balance_bloc.dart';
import 'package:cashapp/res/constants.dart';
import 'package:cashapp/screens/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

GlobalKey<ScaffoldState> drawerKey = GlobalKey();


class Home extends StatefulWidget {
  static const String route = '/';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  static int decimals = 2;
  int fac = pow(10, decimals);



  @override
  void initState() {
    getProfileData();
    super.initState();
  }
  getProfileData() async {
    try {
      localStorage = await SharedPreferences.getInstance();
      setState(() {
        balance = localStorage.getString('balance');
        phone = localStorage.getString('phone');
        email=localStorage.getString('email');
        lastlogin=localStorage.getString('lastlogin');
        name=localStorage.getString('name');
        currency=localStorage.getString('currency');

      });

      // print('my token is $mytoken');
    } catch (e) {
      print('profile error $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    final BalanceBloc balanceBloc=Provider.of<BalanceBloc>(context);

    return Scaffold(
        key: drawerKey,
        drawer: Drawer(
          child: drawerFunction(context),
        ),
        backgroundColor: dark1,
        body: SafeArea(
            child: Container(
                child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5 * widthm),
            child: Container(
              //color: Colors.green,
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      drawerKey.currentState.openDrawer();
                    },
                    child: Image.asset(
                      'assets/images/menu.png',
                      height: 12 * widthm,
                      width: 12 * widthm,
                      color:blue1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5 * widthm),
                    child: Text(
                      'Junubi Cash',
                      style: TextStyle(
                          fontSize: 3 * textm,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3 * widthm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '    Account overview',
                  style: TextStyle(
                    fontSize: 2 * textm,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(
                  height: .5 * heightm,
                ),
                Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(2 * widthm)),
                    ),
                    color: blue1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(2 * widthm)),
                        gradient: LinearGradient(
                            colors: [blue2, blue1],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      padding: EdgeInsets.all(5 * widthm),
                      height: 20 * heightm,
                      width: MediaQuery.of(context).size.width * .95,
                      child: Row(
                        children: <Widget>[
                          // Expanded(
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: <Widget>[
                          //       Text(
                          //         'Hello again,',
                          //         style: TextStyle(
                          //           fontSize: 2 * textm,
                          //           color: dark1,
                          //         ),
                          //       ),
                          //       Text(
                          //         'John ',
                          //         style: TextStyle(
                          //           fontSize: 2.3 * textm,
                          //           color: dark1,
                          //           fontWeight: FontWeight.w500
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  'Junubi Balance ',
                                  style: TextStyle(
                                    fontSize: 2.5 * textm,
                                    color: dark1,
                                    fontWeight: FontWeight.w800
                                  ),
                                ),
                                Text(
                                  '$currency ${balanceBloc.balance>0?balanceBloc.balance.toStringAsFixed(2):balanceBloc.balance}',

                                  //'\$ ${balanceBloc.balance.toStringAsFixed(2) }',
                                  style: TextStyle(
                                    fontSize: 5 * textm,
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                                Text(
                                  'Available',
                                  style: TextStyle(
                                    fontSize: 2.3 * textm,
                                    color: dark1,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                SizedBox(
                  height: 2 * heightm,
                ),
//                Text(
//                  '    Recent transactions',
//                  style: TextStyle(
//                    fontSize: 2 * textm,
//                    color: Colors.grey[400],
//                  ),
//                ),
              ],
            ),
          )
        ]))));
  }
}
