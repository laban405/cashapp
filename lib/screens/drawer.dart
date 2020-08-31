import 'package:cashapp/apis/profiledata.dart';
import 'package:cashapp/res/constants.dart';
import 'package:cashapp/screens/activity.dart';
import 'package:cashapp/screens/braintree.dart';
import 'package:cashapp/screens/deposit.dart';
import 'package:cashapp/screens/help.dart';
import 'package:cashapp/screens/sendmoney.dart';
import 'package:cashapp/screens/paymoney.dart';
import 'package:cashapp/screens/samplecontacts.dart';
import 'package:cashapp/screens/withdraw.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'login.dart';

drawerFunction(BuildContext context) {
 
  return Drawer(
    child: Container(
      color: dark1,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            //color: dark1,
            height: 22*heightm,
            width: MediaQuery.of(context).size.width,
            child: DrawerHeader(
              
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  1*widthm,
                  1*widthm,
                  1*widthm,
                  1*widthm,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: dark1,
                            radius:8*widthm,
                            child: Icon(
                              Icons.person,
                              size: 12*widthm,
                              color: blue1,

                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                         
                         
                          // Text(
                          //   'Junubi',
                          //   style: TextStyle(
                          //     fontSize: 3.5*textm,
                          //     color: Colors.white,
                          //   ),
                          // ),
                          SizedBox(
                            height: 1*heightm,
                          ),
                          Text(
                            '$name ',
                            style: TextStyle(
                              fontSize: 2*textm,
                              color: dark1,
                            ),
                          ),
                           SizedBox(
                            height: 1*heightm,
                          ),
                          Text(
                            '$email',
                            style: TextStyle(
                              fontSize: 1.5*textm,
                              color: dark1,
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: blue1,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.payment,
            color: blue1,
            ),
            title: Text(
                            'Pay',
                            style: TextStyle(
                              fontSize: 2.5*textm,
                              color: blue1,
                            ),
                          ),
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: PayMoney(), type: PageTransitionType.leftToRight));
            },
          ),
         
          ListTile(
            leading: Icon(Icons.send,color: blue1,),
            title:  Text(
                            'Send',
                            style: TextStyle(
                              fontSize: 2.5*textm,
                              color: blue1,
                            ),
                          ),
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: SendMoney(),
                      type: PageTransitionType.leftToRight));
            },
          ),
           ListTile(
            leading: Icon(Icons.add,color: blue1,),
            title:  Text(
                            'Add Funds',
                            style: TextStyle(
                              fontSize: 2.5*textm,
                              color: blue1,
                            ),
                          ),
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: Deposit(),
                      type: PageTransitionType.rightToLeft));
            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_downward,color: blue1,),
            title:  Text(
              'Withdraw Funds',
              style: TextStyle(
                fontSize: 2.5*textm,
                color: blue1,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: WithdrawMoney(),
                      type: PageTransitionType.rightToLeft));
            },
          ),
          ListTile(
            leading: Icon(Icons.history,color: blue1,),
            title:  Text(
                            'Activity',
                            style: TextStyle(
                              fontSize: 2.5*textm,
                              color: blue1,
                            ),
                          ),
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: Activity(),
                      type: PageTransitionType.rightToLeft));
            },
          ),
          ListTile(
            leading: Icon(Icons.help_outline,color: blue1,),
            title: Text(
              'Help',
              style: TextStyle(
                fontSize: 2.5*textm,
                color: blue1,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: HelpSupport(), type: PageTransitionType.rightToLeft));
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app,color: blue1,),
            title: Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 2.5*textm,
                              color: blue1,
                            ),
                          ),
            onTap: () {
               Navigator.pushReplacement(
                   context,
                   PageTransition(
                       child: Login(), type: PageTransitionType.rightToLeft));
            },
          ),
        ],
      ),
    ),
  );
}