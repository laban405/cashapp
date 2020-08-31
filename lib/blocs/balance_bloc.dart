import 'package:flutter/cupertino.dart';

class BalanceBloc extends ChangeNotifier{
  double _balance=0;

  double get balance=>_balance;

  set balance(double val){
    _balance=val;

    notifyListeners();
  }

  updateBalance(double val){
    _balance=val;
    notifyListeners();
  }

}