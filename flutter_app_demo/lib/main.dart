import 'package:flutter/material.dart';
import 'bottom_navigation_widget.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: '首页导航',
      theme: ThemeData.light(),
      home: BottomNavgationWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}