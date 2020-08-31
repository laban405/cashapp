import 'package:cashapp/res/commonwidgets.dart';
import 'package:cashapp/res/constants.dart';
import 'package:cashapp/widgets/commonwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:page_transition/page_transition.dart';
class HelpSupport extends StatefulWidget {
  @override
  _HelpSupportState createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {

  bool _isLoading=false;
  static String subject;
  static String body;
  final _formKey = GlobalKey<FormState>();
  //'junubisafepayment@gmail.com'

  final Email email = Email(
    body: body,
    subject: subject,
    recipients: ['laban1738@gmail.com'],
    cc: [],
   bcc: [],
    //attachmentPaths: ['/path/to/attachment.zip'],
    isHTML: false,
  );


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
                  'Help',
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
          child: SingleChildScrollView(
            child: Container(
              padding:EdgeInsets.fromLTRB(widthm *5, 0, widthm *5, 0),
              child:Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   // Center(child: logo()),
                    SizedBox(
                      height: 6 * heightm,
                    ),
                    Text(
                      'Leave us a message, we will be glad to help you. ',
                      style: TextStyle(color: Colors.grey, fontSize: 2 * textm),
                    ),
                    SizedBox(
                      height: 2 * heightm,
                    ),

//                    Text(
//                      'Email ',
//                      style: TextStyle(color: Colors.grey, fontSize: 1.5 * textm),
//                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.length < 4) {
                          return 'Enter your email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        subject = value;
                      },
                      style: TextStyle(
                      //  height: 1,
                          color: Colors.white),
                      decoration: InputDecoration(

                        contentPadding: EdgeInsets.only(
                          left:3*widthm,
                            bottom:-2 * heightm, top: 0 * heightm),
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2 * heightm,
                    ),
//                    Text(
//                      'Subject',
//                      style: TextStyle(color: Colors.grey, fontSize: 1.5 * textm),
//                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.length < 4) {
                          return 'Enter subject';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        subject = value;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left:3*widthm,
                            bottom:-2 * heightm, top: 0 * heightm),
                        hintText: 'Subject',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2 * heightm,
                    ),
//                    Text(
//                      'Description',
//                      style: TextStyle(color: Colors.grey, fontSize: 1.5 * textm),
//                    ),
                    SizedBox(
                      height:2*heightm
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.length < 4) {
                          return 'Description is too short';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        body = value;
                      },
                      style: TextStyle(color: Colors.white),
                      maxLines: 8,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ) ,
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ) ,

                        hintText: 'Description',
                        hintStyle: TextStyle(color: Colors.white),

                      ),
                    ),
//                  SizedBox(
//                    height: 3 * heightm,
//                  ),
                    Text(
                      'Leave us a message, we will be glad to help you. ',
                      style: TextStyle(color: Colors.grey, fontSize: 2 * textm),
                    ),

                    SizedBox(
                      height: 4* heightm,
                    ),
                    Center(
                      child: SizedBox(
                        width: 100 * widthm,
                        height: 6 * heightm,
                        child: FlatButton(
                          color: blue1,
                          disabledColor: blue1,
                          onPressed: _isLoading
                              ? null
                              : () {
                            _sendMail();
                          },
                          child: _isLoading
                              ? spinkitwhite
                              : Text(
                            'Send',
                            style: TextStyle(
                                color: Colors.white, fontSize: 2.3 * textm),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )

            ),
          )),
    );
  }

  Widget logo() {
    return Image.asset(
      'assets/images/logo.png',
      height: heightm * 15,
      width: heightm * 15,
      // color: Colors.white,
    );
  }

  _sendMail() async {
    print("pass $subject, $body");

    setState(() {
      _isLoading = true;
    });

    if (_formKey.currentState.validate()) {
      try{



       await FlutterEmailSender.send(email);


      }catch(e){
        print('email res${e.toString()}');

      }

    } else {
      showToast(context, 'Enter valid details');
    }

    setState(() {
      _isLoading = false;

    });
  }
}
