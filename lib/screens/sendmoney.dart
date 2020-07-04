import 'dart:async';
import 'dart:convert';

import 'package:cashapp/apis/httprequestsapi.dart';
import 'package:cashapp/apis/profiledata.dart';
import 'package:cashapp/res/commonwidgets.dart';
import 'package:cashapp/res/constants.dart';
import 'package:cashapp/widgets/commonwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_numpad_widget/flutter_numpad_widget.dart';

import 'package:native_contact_picker/native_contact_picker.dart';

class SendMoney extends StatefulWidget {
  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  final NativeContactPicker _contactPicker = NativeContactPicker();
  Contact _contact;
  final NumpadController _numpadController =
      NumpadController(format: NumpadFormat.NONE);
  bool _isLoading = false;

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
                InkWell(
                  onTap: () async {
                    Contact contact = await _contactPicker.selectContact();
                    setState(() {
                      _contact = contact;
                    });
                  },
                  child: SizedBox(
                    height: 8 * heightm,
                    width: 50 * widthm,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.add_circle,
                          size: 8 * widthm,
                          color: Colors.grey[500],
                        ),
                        Text(
                          _contact == null
                              ? '  CHOOSE RECIPIENT'
                              : '   CHANGE RECIPIENT',
                          style: TextStyle(
                              fontSize: 2 * textm,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2 * heightm,
                ),
                Text(
                  _contact == null
                      ? 'No contact selected.'
                      : _contact.phoneNumber.toString(),
                  style: TextStyle(
                      fontSize: 2.8 * textm,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(3 * widthm),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: NumpadText(
                        style:
                            TextStyle(fontSize: 5 * textm, color: Colors.white),
                        controller: _numpadController,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Numpad(
                    controller: _numpadController,
                    buttonTextSize: 10 * widthm,
                    buttonColor: dark1,
                    textColor: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        3 * widthm,
                        3 * widthm,
                        3 * widthm,
                        3 * widthm,
                      ),
                      child: SizedBox(
                        height: 8 * heightm,
                        width: MediaQuery.of(context).size.width / 2,
                        child: FlatButton(
                          color: blue1,
                          onPressed: _isLoading
                              ? null
                              : () {
                                  sendVirtualMoney();
                                },
                          child: _isLoading
                              ? spinkitwhite
                              : Text(
                                  'SEND',
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
              ]),
        ),
      ),
    );
  }

  sendVirtualMoney() async {
    setState(() {
      _isLoading = true;
    });

    var phone_number=_contact.phoneNumber.replaceAll(new RegExp(r"\s+"), "");
    var payeephone=phone_number.replaceAll(new RegExp(r'[^\w\s]+'),'');

    try {
      var data = {
        "amount": _numpadController.formattedString,
        "narration": "Sent Money",
        "payee_phone_number": payeephone
      };
      print('data is $data');

      var res =
          await postData(data, 'send-money').timeout(const Duration(seconds: 30));
      var body = json.decode(res.body);

      print('send money response is ${res.body}');
      print('send money response is ${res.statusCode}');
      if (res.statusCode == 200) {
        showToast(context, '${body['message']}');
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
