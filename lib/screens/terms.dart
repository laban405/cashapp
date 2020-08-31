import 'package:cashapp/res/commonwidgets.dart';
import 'package:cashapp/res/constants.dart';
import 'package:cashapp/screens/policytext.dart';
import 'package:cashapp/widgets/commonwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:page_transition/page_transition.dart';
class Terms extends StatefulWidget {
  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: dark1,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 7 * widthm,
              color: blue1,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Center(
                child: Text(
                  '  Policy and Agreement',
                  style: TextStyle(
                    fontSize: 2.5 * textm,
                    color: blue1,
                  ),
                ),
              ),
            ),
            Expanded(flex: 1, child: Container())
          ],
        ),
      ),
      backgroundColor: dark1,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
                //padding:EdgeInsets.fromLTRB(widthm *5, 0, widthm *5, 0),
              child: Column(
                children: [
                  Divider(
                    color: blue1,
                  ),

                  Container(

                    padding:EdgeInsets.fromLTRB(widthm *2, 0, widthm *2, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          terms1,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 1.8*textm,

                          ),
                        ),
                        SizedBox(
                          height:2*heightm
                        ),
                        Text(
                          terms2,
                          style: TextStyle(
                            color: blue1,
                            fontSize: 1.8*textm,
                            fontWeight: FontWeight.w600

                          ),
                        ),
                        SizedBox(
                            height:1*heightm
                        ),
                        Text(
                          terms3,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 1.8*textm,

                          ),
                        ),
                        SizedBox(
                            height:1*heightm
                        ),
                        Text(
                          terms4,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 1.8*textm,

                          ),
                        ),
                        SizedBox(
                            height:1*heightm
                        ),
                        Text(
                          terms5,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 1.8*textm,

                          ),
                        ),
                        SizedBox(
                            height:2*heightm
                        ),
                        Text(
                          terms6,
                          style: TextStyle(
                              color: blue1,
                              fontSize: 1.8*textm,
                              fontWeight: FontWeight.w600

                          ),
                        ),
                        SizedBox(
                            height:1*heightm
                        ),
                        Text(
                          terms7,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 1.8*textm,

                          ),
                        ),
                        SizedBox(
                            height:2*heightm
                        ),
                        Text(
                          terms8,
                          style: TextStyle(
                              color: blue1,
                              fontSize: 1.8*textm,
                              fontWeight: FontWeight.w600

                          ),
                        ),
                        SizedBox(
                            height:1*heightm
                        ),
                        Text(
                          terms9,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 1.8*textm,

                          ),
                        ),
                        SizedBox(
                            height:1*heightm
                        ),
                        Text(
                          terms10,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 1.8*textm,

                          ),
                        ),
                        SizedBox(
                            height:1*heightm
                        ),
                        Text(
                          terms11,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 1.8*textm,

                          ),
                        ),
                        SizedBox(
                            height:2*heightm
                        ),
                        Text(
                          terms12,
                          style: TextStyle(
                              color: blue1,
                              fontSize: 1.8*textm,
                              fontWeight: FontWeight.w600

                          ),
                        ),
                        SizedBox(
                            height:1*heightm
                        ),
                        Text(
                          terms13,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 1.8*textm,

                          ),
                        ),
                        SizedBox(
                            height:2*heightm
                        ),
                        Text(
                          terms14,
                          style: TextStyle(
                              color: blue1,
                              fontSize: 1.8*textm,
                              fontWeight: FontWeight.w600

                          ),
                        ),
                        SizedBox(
                            height:1*heightm
                        ),
                        Text(
                          terms15,
                          style:TextStyle(
                            color: Colors.grey[600],
                            fontSize: 1.8*textm,

                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

            ),
          )),
    );
  }




}
