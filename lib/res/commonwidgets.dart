import 'package:cashapp/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';


final spinkitwhite = SpinKitThreeBounce(
  color: Colors.white,
  size: 20.0,
);
final spinkitgreen = SpinKitThreeBounce(
  color: defaultgreen,
  size: 20.0,
);

final spinkitred = SpinKitThreeBounce(
  color: Colors.red,
  size: 15.0,
);

class BusinessTimePicker extends StatefulWidget {
  @override
  _BusinessTimePickerState createState() => _BusinessTimePickerState();
}

class _BusinessTimePickerState extends State<BusinessTimePicker> {
  DateTime _dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(top: 1*heightm),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 1 * widthm),
              child: Text(
                _dateTime.hour.toString().padLeft(2, '0') +
                    ':' +
                    _dateTime.minute.toString().padLeft(2, '0'),
                    //  +
                    // ':' +
                    // _dateTime.second.toString().padLeft(2, '0'),
                style: TextStyle(
                  color: dark1,
                    fontSize: 2.5 * textm, fontWeight: FontWeight.w600),
              ),
            ),
            Divider(
              color: dark1,
              thickness: 1*widthm,

            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical:2*heightm),
              child: hourMinute12H(),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                      width: 35 * widthm,
                      height: 5 * heightm,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          // side: BorderSide(color: Colors.red)
                        ),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                          // Navigator.push(context, PageTransition(child: DashBoard(), type: PageTransitionType.rightToLeft) );
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: dark1, fontSize: 2.4 * textm),
                        ),
                      ),
                    ),
                    // Expanded(
                    //                       child: VerticalDivider(
                    //     color: dark1,
                    //   ),
                    // ),
                    SizedBox(
                      width: 35 * widthm,
                      height: 5 * heightm,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          // side: BorderSide(color: Colors.red)
                        ),
                        color: Colors.white,
                        onPressed: () {
                          // Navigator.push(context, PageTransition(child: DashBoard(), type: PageTransitionType.rightToLeft) );
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(
                              color: dark1, fontSize: 2.4 * textm),
                        ),
                      ),
                    ),
              ],

            ),
            
          ],
        ),
      ),
    );
  }

  /// SAMPLE
  Widget hourMinute12H() {
    return TimePickerSpinner(
      itemHeight: 6*heightm,
      highlightedTextStyle: TextStyle(
        
        color: dark1,
        fontSize: 3*textm

      ),
      normalTextStyle: TextStyle(
        color: grey,
        fontSize: 3*textm

      ),
      is24HourMode: false,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
    );
  }
}
