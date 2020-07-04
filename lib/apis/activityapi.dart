import 'dart:convert';

import 'package:cashapp/apis/httprequestsapi.dart';

class ActivityData{
  double debit;
  double credit;
  String narration;
  String fullname;
  String date;
  String phone;



  ActivityData(
    {
      this.debit,
      this.credit,
      this.narration,
      this.fullname,
      this.date,
      this.phone
    }
  );

   factory ActivityData.fromJson(Map<String, dynamic> json) {
    return  ActivityData(
      debit: json['debit'],
      credit: json['credit'],
      narration: json['narration'].toString(),
      fullname: json['debit'].toString(),
      date: json['transaction_time'].toString(),
      phone: json['phone_number'].toString(),
      
      
    );
  }



}



Future<List<ActivityData>> fetchActivities() async {
    var response = await getData('transactions-history');
   
    var res=json.decode(response.body);
     print('get categories response ${res['content']}');

    try {
      if (response.statusCode == 200) {
        List<ActivityData> list = parseActivities(response.body);
        return list;
      } else {
        throw Exception('Error fetching data');
      }
    } catch (e) {
      throw Exception('Error fetching data $e');
    }
  }
 
   List<ActivityData> parseActivities(String responseBody) {
    final parsed = json.decode(responseBody)['content'].cast<Map<String, dynamic>>();
    return parsed.map<ActivityData>((json) =>ActivityData.fromJson(json)).toList();
  }