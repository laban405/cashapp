import 'package:cashapp/apis/activityapi.dart';
import 'package:cashapp/res/constants.dart';
import 'package:cashapp/screens/reverse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Activity extends StatefulWidget {
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
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
              flex: 2,
              child: Center(
                child: Text(
                  'Activity',
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
        child: FutureBuilder<List<ActivityData>>(
            future: fetchActivities(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemExtent: 14 * heightm,
                      // reverse: true, //makes the list appear in descending order
                      itemBuilder: (BuildContext context, int index) {
                        return activityDetails(snapshot.data, index);
                      })
                  : Center(
                      child: CircularProgressIndicator(
                        backgroundColor: blue1,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
            }),
      )),
    );
  }

  Widget activityDetails(List<ActivityData> data, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1 * widthm),
      child: Container(
          color: dark1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ListTile(
                  leading: data[index].debit <= 0 ? CircleAvatar(
                    backgroundColor: Colors.green,
                    child:  Icon(Icons.done,
                        color: Colors.white,
                      )
                  ):
                  CircleAvatar(
                    backgroundColor: Colors.lime,
                    child: IconButton(icon: Icon(Icons.refresh,
                      color: Colors.black,
                    ), onPressed: (){
                      showDialog(
                          context: context,
                          builder: (_) {
                            return Reverse(trxid:data[index].trxid);
                          });
                    }),
                  ),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Text(
                          '${data[index].phone}',
                          style: TextStyle(
                              fontSize: 2 * textm,
                              color: Colors.grey[300],
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '\$ ${data[index].debit <= 0 ? data[index].credit.toString() : data[index].debit.toString()}',
                          style: TextStyle(
                            fontSize: 2* textm,
                            fontWeight: FontWeight.w800,
                            color: data[index].debit <= 0
                                ? Colors.green
                                : Colors.red[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                          child: Text(
                            '${data[index].activity}',
                            style: TextStyle(
                              fontSize: 1.8 * textm,
                              color: Colors.grey[500],
                            ),
                          ),),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '${data[index].date}',
                          style: TextStyle(
                            fontSize: 1.8 * textm,
                            color: Colors.grey[500],
                          ),
                        ),),


                    ],
                  )
                  //trailing: Icon(Icons.keyboard_arrow_right),
                  // onTap: () {
                  //   print('horse');
                  // },
                  // selected: true,
                  ),
              Divider(
                height: .1 * heightm,
                color: blue1,
              )
            ],
          )),
    );
  }
}
