import 'package:shared_preferences/shared_preferences.dart';

//Future<SharedPreferences> localdata = SharedPreferences.getInstance();


String balance;
String phone;
SharedPreferences localStorage;
String email;
String lastlogin;
String name;

getProfileData() async {
  try {
    localStorage = await SharedPreferences.getInstance();
    balance = localStorage.getString('balance');
    phone = localStorage.getString('phone');
    email=localStorage.getString('email');
    lastlogin=localStorage.getString('lastlogin');
    name=localStorage.getString('name');
   // print('my token is $mytoken');
  } catch (e) {
    print('profile error $e');
  }
}