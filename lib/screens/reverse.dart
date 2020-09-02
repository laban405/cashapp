import 'dart:async';
import 'dart:convert';

import 'package:cashapp/apis/httprequestsapi.dart';
import 'package:cashapp/res/constants.dart';
import 'package:cashapp/widgets/commonwidgets.dart';
import 'package:flutter/material.dart';

class Reverse extends StatefulWidget {
  final String trxid;
  Reverse({this.trxid});
  @override
  _ReverseState createState() => new _ReverseState();
}

class _ReverseState extends State<Reverse> {
  Color _c = Colors.redAccent;
  bool _isLoading =false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(backgroundColor: dark1,title: Text(
      'Reverse transaction?',
      style: TextStyle(
        fontSize: 2 * textm,
        color: Colors.white,
      ),
    ),
//      content: Container(
//        color: _c,
//        height: 20.0,
//        width: 20.0,
//      ),
      actions: <Widget>[
        SizedBox(
          height: 4*heightm,
          width: 20*widthm,
          child: FlatButton(
              color: Colors.transparent,
              child: Text('Cancel',
                style: TextStyle(
                  fontSize: 2 * textm,
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              }
              )

        ),
        SizedBox(
          height: 4*heightm,
          width: 20*widthm,
          child: FlatButton(
            color:Colors.transparent,
              child:_isLoading?spinkitblue: Text('Reverse'),
              onPressed: () {
              reverseVirtualMoney();
    }
              )
        ),

      ],
    );
  }

  reverseVirtualMoney( ) async {
    setState(() {
      _isLoading = true;
    });



    try {
      var data = {
        "refund_narration": "Refund Money",
        "trx_id": widget.trxid
      };
      print('data is $data');

      var res =
      await postData(data, 'refund-transaction').timeout(const Duration(seconds: 30));
      var body = json.decode(res.body);

      print('reverse money response is ${res.body}');
      print('reverse money response is ${res.statusCode}');
      if (res.statusCode == 200) {
        showToast(context, '${body['message']}');

Navigator.pop(context);
      } else {
        showToast(context, '${body['message']}');
      }
    } on TimeoutException {
      showToast(context, 'Error: time out');
    }

    setState(() {
      _isLoading = false;
    });
  }
}