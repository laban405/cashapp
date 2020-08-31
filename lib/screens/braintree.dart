import 'dart:convert';

import 'package:cashapp/apis/httprequestsapi.dart';
import 'package:cashapp/screens/tokengen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';

class BrainTreeSample extends StatefulWidget {
  @override
  _BrainTreeSampleState createState() => _BrainTreeSampleState();
}

class _BrainTreeSampleState extends State<BrainTreeSample> {
  static final String tokenizationKey = 'sandbox_rzdmq5vp_kyktcybpfgq5b99r';
  String clientToken;
  double depositamt = 20;

  void showNonce(BraintreePaymentMethodNonce nonce) async {
    var data = {"amount": 20, "payment_method_nonce": nonce.nonce};
    print('nonce itself $nonce');
    print('n0nce data>>>> paypal is $data');
    print('start paypal deposit');
    var res = await postNoData(
        'make-payment?amount=$depositamt&payment_method_nonce=${nonce.nonce}');
    print('end paypal deposit');
    print('response paypal is ${res.body}');
//    showDialog(
//      context: context,
//      builder: (_) => AlertDialog(
//        title: Text('Payment method nonce:'),
//        content: Column(
//          mainAxisSize: MainAxisSize.min,
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: <Widget>[
//            Text('Nonce: ${nonce.nonce}'),
//            SizedBox(height: 16),
//            Text('Type label: ${nonce.typeLabel}'),
//            SizedBox(height: 16),
//            Text('Description: ${nonce.description}'),
//            Text('Nonce: ${nonce.isDefault}'),
//            SizedBox(height: 16),
//            Text('Type label: ${nonce.typeLabel}'),
//            SizedBox(height: 16),
//            Text('Description: ${nonce.description}'),
//          ],
//        ),
//      ),
//    );
  }

  getClientToken() async {
    var res = await getData('payment/token');
    var body = json.decode(res.body);
    print('response client token${body}');

    clientToken = body['clientToken'];
    print('client token is $clientToken');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClientToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Braintree example app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
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
                    amount: '4.20',
                    displayName: 'Junubi App',
                  ),
                );
                BraintreeDropInResult result =
                    await BraintreeDropIn.start(request);
                if (result != null) {
                  print('result got back including nonce $result');
                  showNonce(result.paymentMethodNonce);
                }
              },
              child: Text('LAUNCH NATIVE DROP-IN'),
            ),
//            RaisedButton(
//              onPressed: () async {
//                final request = BraintreeCreditCardRequest(
//                  cardNumber: '4111111111111111',
//                  expirationMonth: '12',
//                  expirationYear: '2021',
//                );
//                BraintreePaymentMethodNonce result =
//                    await Braintree.tokenizeCreditCard(
//                  tokenizationKey,
//                  request,
//                );
//                if (result != null) {
//                  showNonce(result);
//                }
//              },
//              child: Text('TOKENIZE CREDIT CARD'),
//            ),
            RaisedButton(
              onPressed: () async {
                final request = BraintreePayPalRequest(
                  currencyCode: 'USD',
                  amount: '4.55',
                  billingAgreementDescription:
                      'I hearby agree that flutter_braintree is great.',
                  displayName: 'Your Company',
                );
                BraintreePaymentMethodNonce result =
                    await Braintree.requestPaypalNonce(
                  tokengen,

                  //tokenizationKey,
                  request,
                );
                if (result != null) {
                  showNonce(result);
                }
              },
              child: Text('PAYPAL VAULT FLOW'),
            ),
            RaisedButton(
              onPressed: () async {
                final request = BraintreePayPalRequest(amount: '13.37');
                BraintreePaymentMethodNonce result =
                    await Braintree.requestPaypalNonce(
                  tokengen,
                  request,
                );
                if (result != null) {
                  showNonce(result);
                }
              },
              child: Text('PAYPAL CHECKOUT FLOW'),
            ),
          ],
        ),
      ),
    );
  }
}
