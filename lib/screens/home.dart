import 'package:cashapp/apis/profiledata.dart';
import 'package:cashapp/res/constants.dart';
import 'package:cashapp/screens/drawer.dart';
import 'package:flutter/material.dart';

GlobalKey<ScaffoldState> drawerKey = GlobalKey();


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    getProfileData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
                      'Junubi App',
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
                                  '\$ $balance',
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
                Text(
                  '    Recent transactions',
                  style: TextStyle(
                    fontSize: 2 * textm,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          )
        ]))));
  }
}
