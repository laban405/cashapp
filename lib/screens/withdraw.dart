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
import 'package:shared_preferences/shared_preferences.dart';

class WithdrawMoney extends StatefulWidget {
  @override
  _WithdrawMoneyState createState() => _WithdrawMoneyState();
}

class _WithdrawMoneyState extends State<WithdrawMoney> {
  final NativeContactPicker _contactPicker = NativeContactPicker();
  Contact _contact;
  final NumpadController _numpadController =
  NumpadController(hintText: "Enter amount",format: NumpadFormat.NONE);
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final BalanceBloc balanceBloc=Provider.of<BalanceBloc>(context);
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
                  'Withdraw Money',
                  style: TextStyle(
                    fontSize: 3 * textm,
                    color: blue1,
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container())
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                SizedBox(
                  height: 2 * heightm,
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
                            withdrawVirtualMoney(balanceBloc);
                          },
                          child: _isLoading
                              ? spinkitwhite
                              : Text(
                              'WITHDRAW',
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

 withdrawVirtualMoney( BalanceBloc balanceBloc) async {
    setState(() {
      _isLoading = true;
    });

    //var phone_number=_contact.phoneNumber.replaceAll(new RegExp(r"\s+"), "");
    //var payeephone=phone_number.replaceAll(new RegExp(r'[^\w\s]+'),'');

    try {
      var myphone;
      localStorage = await SharedPreferences.getInstance();
      setState(() {
        myphone = localStorage.getString('phone');
      });

      var data={
        "amount": _numpadController.formattedString,
        "narration": "Withdraw money",
        "payee_phone_number": myphone
      };
      print('data is $data');

      var res =
      await postData(data, 'withdrawal-money').timeout(const Duration(seconds: 30));
      var body = json.decode(res.body);

      print('withdraw money response is ${res.body}');
      print('withdraw money response is ${res.statusCode}');
      if (res.statusCode == 200) {
        var _res = await getData('users');
        var profilebody = json.decode(_res.body);

        print('profile status code ${res.statusCode}');

        if(_res.statusCode==200) {
          balanceBloc.updateBalance(profilebody['account_balance']);
        }
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

  withdrawSuccess(){
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: blue1,
        title: Center(
          child: Text(
            'Funds Deposit Successful',
            style: TextStyle(
              fontSize: 2.3 * textm,
              color: dark1,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have successfully deposited',
              style: TextStyle(
                fontSize: 1.8 * textm,
                color: dark1,
              ),
            ),
            Text("jjjj",
              //'\$ ${body['content']['credit'].toString()}',
              style: TextStyle(
                fontSize: 3 * textm,
                color: Colors.white,
              ),
            ),
            Text(
              'to your Junubi account',
              style: TextStyle(
                fontSize: 1.8 * textm,
                color: dark1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 6*heightm,
              width: 40*widthm,
              child: FlatButton(
                color: dark1,
                onPressed: (){
                  Navigator.pop(context);
                  //Navigator.pushReplacement(context, newRoute)

                },
                child:Text(
                  'Finish',
                  style: TextStyle(
                    fontSize: 1.8* textm,
                    color: blue1,
                  ),
                ),),
            )
          ],
        ),
      ),
    );
  }
}
