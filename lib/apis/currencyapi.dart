import 'dart:convert';

import 'package:cashapp/apis/httprequestsapi.dart';

class CurrencyData{
  String name;
  String code;
  String abbr;
  String id;



  CurrencyData(
      {
        this.name,
        this.code,
        this.abbr,
        this.id
      }
      );

  factory CurrencyData.fromJson(Map<String, dynamic> json) {
    return CurrencyData(
      name: json['currency_name'],
      code: json['currency_code'],
      abbr: json['currency_abbreviation'].toString(),
      id: json['currency_id'].toString(),



    );
  }



}



// fetchCurrencies() async {
//  var response = await getDataRegister('users/currency-types');
//
//  var res=json.decode(response.body);
//  print('get ccurrencies response ${res['content']}');
//
//  try {
//    if (response.statusCode == 200) {
//      List<CurrencyData> list = parseCurrencies(response.body);
//      return list;
//    } else {
//      throw Exception('Error fetching data');
//    }
//  } catch (e) {
//    throw Exception('Error fetching data $e');
//  }
//}
//
//List<CurrencyData> parseCurrencies(String responseBody) {
//  final parsed = json.decode(responseBody)['content'].cast<Map<String, dynamic>>();
//  return parsed.map<CurrencyData>((json) =>CurrencyData.fromJson(json)).toList();
//}