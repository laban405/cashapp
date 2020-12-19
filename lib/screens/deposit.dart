import 'dart:convert';
import 'package:cashapp/apis/httprequestsapi.dart';
import 'package:cashapp/apis/profiledata.dart';
import 'package:cashapp/blocs/balance_bloc.dart';
import 'package:cashapp/res/constants.dart';
import 'package:cashapp/widgets/commonwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:flutter_numpad_widget/flutter_numpad_widget.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Deposit extends StatefulWidget {
  @override
  _DepositState createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  final NumpadController _numpadController =
      NumpadController(hintText: 'Enter amount', format: NumpadFormat.NONE);

  static final String tokenizationKey = 'sandbox_rzdmq5vp_kyktcybpfgq5b99r';
  String clientToken;
  bool isLoading = false;
  var usdAmount;
  var fxRate=1.0;
  //double depositamt=20;

  getProfileData() async {
    try {
      localStorage = await SharedPreferences.getInstance();
      setState(() {
        balance = localStorage.getString('balance');
        phone = localStorage.getString('phone');
        email = localStorage.getString('email');
        lastlogin = localStorage.getString('lastlogin');
        name = localStorage.getString('name');
      });

      // print('my token is $mytoken');
    } catch (e) {
      print('profile error $e');
    }
  }

  getClientToken() async {
    var res = await getData('payment/token');
    var body = json.decode(res.body);
    clientToken = body['clientToken'];
    print('response client token is $clientToken');
  }

  convertCurrency() async {
    if (currency != "USD") {
      var data = {
        "base_currency": currency,
        "conversion_amt": _numpadController.formattedString,
        "quote_currency": "USD"
      };
      var res = await postData(
        data,
        'currency-converter',
      );
      var body = json.decode(res.body);

      print('converted currency $body');
      setState(() {
        usdAmount = body['content'][0]['converted_amt'].toString();
        fxRate=body['content'][0]['converted_amt'];
      });

      print('currency convert response $body');
      return usdAmount;
    } else {
      setState(() {
        usdAmount = _numpadController.formattedString;
      });

      return usdAmount;
    }
  }

  getCurrency() async {
    localStorage = await SharedPreferences.getInstance();
    currency = localStorage.getString('currency');
  }

  @override
  void initState() {
    getClientToken();
    getCurrency();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Loader.hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BalanceBloc balanceBloc = Provider.of<BalanceBloc>(context);
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
//              Navigator.push(context,
//                  PageTransition(child: Home(), type: PageTransitionType.rightToLeft));
//             Navigator.push( context, MaterialPageRoute( builder: (context) => Home()), ).then((value) => setState(() {
//               getProfileData();
//             }));
              Navigator.pop(context);
//              Navigator.push(
//                  context, MaterialPageRoute(builder: (BuildContext context) => Home(
//
//              )));
            }),
        title: Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Center(
                child: Text(
                  'Add Funds',
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
      backgroundColor: dark1,
      body: SafeArea(
          child: Container(
              child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(3 * widthm),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: NumpadText(
                  style: TextStyle(fontSize: 5 * textm, color: Colors.white),
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
                    onPressed: () async {
                      print('currency convert start ');
                      await convertCurrency();
                      print('currency convert end ');
                      print('braintree deposit start ');
                      await brainTreeDeposit(balanceBloc);
                      print('braintree deposit end ');
                    },
                    child: Text(
                      'Add Funds',
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
        ],
      ))),
    );
  }

  brainTreeDeposit(BalanceBloc balanceBloc) async {
    print('<<<<<<<braintree deposit start >>>>>');

    try {
      print('<<<<<<<braintree request start request 1 >>>>>');
      var request = BraintreeDropInRequest(
        cardEnabled: false,
        clientToken: clientToken,
        tokenizationKey: tokenizationKey,
        collectDeviceData: true,
//                  googlePaymentRequest: BraintreeGooglePaymentRequest(
//                    totalPrice: '4.20',
//                    currencyCode: 'USD',
//                    billingAddressRequired: false,
//                  ),
        paypalRequest: BraintreePayPalRequest(
          currencyCode: "USD",
          amount: usdAmount,
          displayName: 'Junubi Safe Payments',
        ),
      );

      print('<<<<<<<braintree request start request 1 end>>>>>');

      print('<<<<<<<braintree request function start >>>>>');
      BraintreeDropInResult result = await BraintreeDropIn.start(request);

      if (result != null) {
        print('result got back including nonce $result');
        showNonce(result.paymentMethodNonce, balanceBloc);
      }
      print('<<<<<<<braintree request function end >>>>>');
    } catch (e) {
      print("braintree error$e");
    }
  }

  void showNonce(
      BraintreePaymentMethodNonce nonce, BalanceBloc balanceBloc) async {
    print('start paypal deposit');
    var res;
    var body;

    Loader.show(
      context,
      progressIndicator: LinearProgressIndicator(backgroundColor: blue1),
      overlayColor: dark1,
    );
    try {
      ///redo changes here
    print('unconverted amt ${_numpadController.formattedString}');
      res = await postNoData(
          'make-payment?amount=${usdAmount.toString()}&exchageRate=$fxRate&payment_method_nonce=${nonce.nonce}&unconvertedAmt=${_numpadController.formattedString}');
      body = json.decode(res.body);
      print('response paypal is>>>>> ${res.body}');
    } catch (e) {
      showToast(context, "An Error Occurred");
    }


    if (res.statusCode == 200) {

      var _res = await getData('users?pageNo=0&pageSize=10');
      var profilebody = json.decode(_res.body);
      print('profile data>>> $profilebody');
      profilebody = profilebody['content'][0];

      print('profile status code ${res.statusCode}');

      if (_res.statusCode == 200) {
        balanceBloc.updateBalance(profilebody['account_balance']);
      }

      Loader.hide();
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
              Text(
               // '$currency ${body['content']['credit'].toString()}',
                '$currency  ${_numpadController.formattedString}',
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
                height: 6 * heightm,
                width: 40 * widthm,
                child: FlatButton(
                  color: dark1,
                  onPressed: () {
                    Navigator.pop(context);
                    //Navigator.pushReplacement(context, newRoute)
                  },
                  child: Text(
                    'Finish',
                    style: TextStyle(
                      fontSize: 1.8 * textm,
                      color: blue1,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Center(child: Text('Add Funds Unsuccessful')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Transaction Failed',
                style: TextStyle(
                  fontSize: 3 * textm,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 3 * heightm,
                width: 10 * widthm,
                child: FlatButton(
                  color: dark1,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Finish',
                    style: TextStyle(
                      fontSize: 1.8 * textm,
                      color: blue1,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
    print('end paypal deposit');
  }
}
