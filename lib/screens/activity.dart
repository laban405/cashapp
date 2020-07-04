import 'package:cashapp/apis/activityapi.dart';
import 'package:cashapp/res/constants.dart';
import 'package:flutter/material.dart';

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
                    color: Colors.white,
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
                      itemExtent: 10 * heightm,
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
      padding: EdgeInsets.symmetric(horizontal: 3 * widthm),
      child: Card(
        color: Colors.grey[300],
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
          ),
          title: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                              child: Text(
                  '${data[index].phone}',
                  style: TextStyle(
                    fontSize: 2.3 * textm,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                              child: Text(
                  '${data[index].debit <= 0 ? data[index].credit.toString() : data[index].debit.toString()}',
                  style: TextStyle(
                    fontSize: 2.3 * textm,
                    color:
                        data[index].debit <= 0 ? Colors.green : Colors.red[600],
                  ),
                ),
              ),
            ],
          ),
          subtitle: Text(
            '${data[index].narration}',
            style: TextStyle(
              fontSize: 2.0 * textm,
              color: Colors.grey[500],
            ),
          ),
          //trailing: Icon(Icons.keyboard_arrow_right),
          // onTap: () {
          //   print('horse');
          // },
          // selected: true,
        ),
      ),
    );
  }
}
