import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
final String ipaddress="https://www.junubicash.com:8081/";
final String _ipaddress = "https://www.junubicash.com:8081";
final String _contextPath = '/api/';
final String _url = _ipaddress + _contextPath;

var accesstoken;
String deleteitemid;

Future<String> requestToken(String phonev, String passwordv) async {
  String username = 'JunubiCash';
  String password = 'MaYzkSl100kmzoNz';
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
  //print('Basic auth $basicAuth');

  print('phone>>>>>>> $phonev and pass>>>>$passwordv');
  print("token start");
  http.Response response = await http.post(
      '$_ipaddress/oauth/token?grant_type=password&username=$phonev&password=$passwordv',
      headers: <String, String>{'authorization': basicAuth});
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    accesstoken = jsonResponse['access_token'];

  }
  print('Response Access token is: ${response.statusCode}');
  // print('Access token is: $accesstoken');

  return accesstoken;
}

Future<dynamic> postData(data, apiUrl) async {
  print('access token>>$accesstoken');
  var fullUrl = _url + apiUrl;
  return await http.post(fullUrl,
      body: jsonEncode(data), headers: _setHeaders());
}

Future<dynamic> postNoData(apiUrl) async {
  var fullUrl = _url + apiUrl;
  return await http.post(fullUrl,
      //body: jsonEncode(data),
      headers: _setHeaders());
}

Future<dynamic> resetPassword(data, apiUrl) async {
  var fullUrl = apiUrl;
  return await http.post(fullUrl,
      body: jsonEncode(data), headers:_registersetHeaders());
}

Future<dynamic> getData(apiUrl) async {
  print('access token>>$accesstoken');
  var fullUrl = _url + apiUrl;
  return await http.get(fullUrl, headers: _setHeaders());
}

Future<dynamic> getDataRegister(apiUrl) async {
  print('access token>>$accesstoken');
  var fullUrl = _url + apiUrl;
  return await http.get(fullUrl, headers: _registersetHeaders());
}

Future<dynamic> putData(data, apiUrl) async {

  var fullUrl = _url + apiUrl;
  // make PUT request
  return await put(fullUrl, headers: _setHeaders(), body: jsonEncode(data));
}

// Future<dynamic> deleteData(apiUrl) async {
//   var fullUrl = _url + apiUrl;
//   // print('deleting item $fullUrl');
//   // make DELETE request
//   return await delete(fullUrl, headers: _setHeaders());
// }

Future<dynamic> deleteData(deleteApi) async {
  final deleteUrl = '$_url$deleteApi';
  print('deleting item $deleteUrl');
  // make DELETE request
  return await delete(deleteUrl, headers: _setHeaders());
}

Future<String> deleteWithBodyExample(apiUrl, deleteitemid) async {
  var fullUrl = _url + apiUrl;
  final fullerURL = '$fullUrl/$deleteitemid';
  final url = Uri.parse(fullerURL);
  final request = http.Request("DELETE", url);
  request.headers.addAll(<String, String>{
    'Authorization': 'Bearer $accesstoken',
    'Content-type': 'application/json',
    'Accept': 'application/json',
  });
  //request.body = jsonEncode({"id": 4});
  final response = await request.send();
  //print(response.statusCode);
  if (response.statusCode != 200)
    return Future.error("error: status code ${response.statusCode}");
  return await response.stream.bytesToString();
}

_setHeaders() => {
      'Authorization': 'Bearer $accesstoken',
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

Future<dynamic> registerpostData(data, apiUrl) async {
  var fullUrl = _url + apiUrl;
  return await http.post(fullUrl,
      body: jsonEncode(data), headers: _registersetHeaders());
}

_registersetHeaders() => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };