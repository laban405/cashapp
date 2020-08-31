import 'dart:convert';

import 'package:cashapp/apis/activityapi.dart';
import 'package:cashapp/apis/httprequestsapi.dart';
import 'package:cashapp/apis/profiledata.dart';
import 'package:cashapp/blocs/balance_bloc.dart';
import 'package:cashapp/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:flutter_numpad_widget/flutter_numpad_widget.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';




class Deposit extends StatefulWidget {
  @override
  _DepositState createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  final NumpadController _numpadController =
  NumpadController(hintText: 'Enter amount',format: NumpadFormat.NONE);

  static final String tokenizationKey = 'sandbox_rzdmq5vp_kyktcybpfgq5b99r';
  String clientToken;
  bool isLoading=false;
  //double depositamt=20;

  getProfileData() async {
    try {
      localStorage = await SharedPreferences.getInstance();
      setState(() {
        balance = localStorage.getString('balance');
        phone = localStorage.getString('phone');
        email=localStorage.getString('email');
        lastlogin=localStorage.getString('lastlogin');
        name=localStorage.getString('name');

      });

      // print('my token is $mytoken');
    } catch (e) {
      print('profile error $e');
    }
  }




  getClientToken()async{
    var res= await getData('payment/token');
    var body= json.decode(res.body);
    print('response client token${body}');

    clientToken=body['clientToken'];
    print('client token is $clientToken');
  }

  @override
  void initState() {
    getClientToken();
    // TODO: implement initState
    super.initState();
  }

    @override
    void dispose(){
    Loader.hide();
    super.dispose();
    }


  @override
  Widget build(BuildContext context) {
    final BalanceBloc balanceBloc=Provider.of<BalanceBloc>(context);
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
            }
            ),
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
            Expanded(
                flex: 1,
                child: Container())
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
                          onPressed: () async {
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
                                currencyCode: 'USD',
                                amount: _numpadController.formattedString,
                                displayName: 'Junubi App',
                              ),
                            );
                            BraintreeDropInResult result =
                            await BraintreeDropIn.start(request);
                            if (result != null) {
                              print('result got back including nonce $result');
                              showNonce(result.paymentMethodNonce, balanceBloc);
                            }
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
            )
          )),
    );
  }


  void showNonce(BraintreePaymentMethodNonce nonce, BalanceBloc balanceBloc) async{

    print('nonce itself $nonce');
    print('start paypal deposit');

    Loader.show(

      context,
      progressIndicator:
      LinearProgressIndicator(backgroundColor: blue1),
      overlayColor: dark1,
    );
    var res= await postNoData('make-payment?amount=${_numpadController.formattedString}&payment_method_nonce=${nonce.nonce}');
    var body=json.decode(res.body);
    print('response paypal is ${res.body}');


    if(res.statusCode==200){
      var _res = await getData('users');
      var profilebody = json.decode(_res.body);

      print('profile status code ${res.statusCode}');

      if(_res.statusCode==200) {
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
                '\$ ${body['content']['credit'].toString()}',
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

    }else{

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Center(child: Text('Add Funds Successful')),
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
                height: 3*heightm,
                width: 10*widthm,
                child: FlatButton(
                  color: dark1,
                  onPressed: (){
                    Navigator.pop(context);

                  },
                  child:Text(
                    'Finish',
                    style: TextStyle(
                      fontSize: 1.8 * textm,
                      color:blue1,
                    ),
                  ),),
              )
            ],
          ),
        ),
      );

    }
    print('end paypal deposit');

  }


  


}
