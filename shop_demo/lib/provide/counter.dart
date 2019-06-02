import 'package:flutter/material.dart';

//不对听众进行管理，谁都可以监听
class Counter with ChangeNotifier{

  int value = 0;

  increment(){
    value++;
    //通知听众，局部刷新
    notifyListeners();
  }
}