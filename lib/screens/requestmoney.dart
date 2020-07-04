import 'package:cashapp/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_numpad_widget/flutter_numpad_widget.dart';

class RequestMoney extends StatefulWidget {
  @override
  _RequestMoneyState createState() => _RequestMoneyState();
}

class _RequestMoneyState extends State<RequestMoney> {
  final NumpadController _numpadController =
      NumpadController(format: NumpadFormat.CURRENCY);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: dark1,
        appBar: AppBar(
          backgroundColor: dark1,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 7 * widthm,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SafeArea(
          child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding:  EdgeInsets.all(3*widthm),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                                          child: NumpadText(
                        style: TextStyle(fontSize: 5*textm, color: Colors.white),
                        controller: _numpadController,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Numpad(
                    controller: _numpadController,
                    buttonTextSize: 10*widthm,
                    buttonColor: dark1,
                    textColor: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(3*widthm,
                      3*widthm,
                      3*widthm,
                      3*widthm,
                      ),
                      child: SizedBox(
                        height: 8 * heightm,
                        width: MediaQuery.of(context).size.width/2,
                        child: FlatButton(
                          color: blue1,
                          onPressed: () {},
                          child: Text(
                            'REQUEST',
                            style: TextStyle(
                              fontSize: 2.5 * textm,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ]
              )
              ),
        ));
  }
}
