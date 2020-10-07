import 'dart:async';
import 'dart:convert';

import 'package:cashapp/apis/httprequestsapi.dart';
import 'package:cashapp/apis/profiledata.dart';
import 'package:cashapp/blocs/balance_bloc.dart';
import 'package:cashapp/res/commonwidgets.dart';
import 'package:cashapp/res/constants.dart';
import 'package:cashapp/widgets/commonwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_numpad_widget/flutter_numpad_widget.dart';

import 'package:native_contact_picker/native_contact_picker.dart';
import 'package:provider/provider.dart';

class SendMoney extends StatefulWidget {
  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  final NativeContactPicker _contactPicker = NativeContactPicker();
  Contact _contact;
  final NumpadController _numpadController =
      NumpadController(hintText: "Enter amount", format: NumpadFormat.NONE);
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final BalanceBloc balanceBloc = Provider.of<BalanceBloc>(context);
    return Scaffold(
      backgroundColor: dark1,
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
                  'Send Money',
                  style: TextStyle(
                    fontSize: 3 * textm,
                    color: blue1,
                  ),
                ),
              ),
            ),
            Expanded(flex: 1, child: Container())
          ],
        ),
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
                    width: 55 * widthm,
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
                              : '  CHANGE RECIPIENT',
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 1.8 * textm,
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
                           // print("phone number $_contact");
                                  sendVirtualMoney(balanceBloc);
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

  sendVirtualMoney(BalanceBloc balanceBloc) async {
    setState(() {
      _isLoading = true;
    });
   // print("phone number ${_contact.phoneNumber}");
    if(_contact==null){
      showToastRed(context, "No contact selected");
    }else {
      try {
        var phone_number = _contact.phoneNumber.replaceAll(
            new RegExp(r"\s+"), "");
        var payeephone = phone_number.replaceAll(new RegExp(r'[^\w\s]+'), '');


        var data = {
          "amount": _numpadController.formattedString,
          "narration": "Send Money to $payeephone",
          "payee_phone_number": payeephone
        };
        print('data is $data');

        var res = await postData(data, 'send-money')
            .timeout(const Duration(seconds: 30));
        var body = json.decode(res.body);

        print('send money response is ${res.body}');
        print('send money response is ${res.statusCode}');
        if (res.statusCode == 200) {
          var _res = await getData('users?pageNo=0&pageSize=10');
          var profilebody = json.decode(_res.body);
          profilebody = profilebody['content'][0];

          print('profile status code ${res.statusCode}');
          print('account balance${profilebody['account_balance']}');

          if (_res.statusCode == 200) {
            balanceBloc.updateBalance(profilebody['account_balance']);
          }
          showToast(context, '${body['message']}');
        } else {
          var _res = await getData('users?pageNo=0&pageSize=10');

          var profilebody = json.decode(_res.body);
          print('response>>>>>>profile>>>>>$profilebody');
          profilebody = profilebody['content'][0];

          print('profile status code ${_res.statusCode}');
          print('profile data $profilebody');

          if (_res.statusCode == 200) {
            balanceBloc.updateBalance(profilebody['account_balance']);
          }
          showToast(context, '${body['message']}');
        }
      } on TimeoutException {
        showToast(context, 'Error: time out');
      }
    }

    setState(() {
      _isLoading = false;
    });
  }
}
