import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'pages/address_screen.dart';
import 'pages/message_screen.dart';
import 'pages/person_screen.dart';
import 'pages/work_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavgationWidget extends StatefulWidget {
  @override
  _BottomNavgationWidgetState createState() => _BottomNavgationWidgetState();
}

class _BottomNavgationWidgetState extends State<BottomNavgationWidget> {

  final _BottomNavigationColor = Colors.blue;
  int _currentIndex = 0;
  List<Widget> screensList = List();
  final List<BottomNavigationBarItem> bottomList = [
    BottomNavigationBarItem(
      icon: Icon(Icons.message),
      title: Text('消息'),
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.apps),
        title: Text('工作')
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.contacts),
        title: Text('通讯录')
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.portrait),
        title: Text('我')
    )
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ..建造者模式
    screensList
      ..add(MessageScreen())
      ..add(WorkScreen())
      ..add(AddressScreen())
      ..add(PersonScreen());

  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true)..init(context);
    return Scaffold(
      body: screensList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items:bottomList,
        type: BottomNavigationBarType.fixed,
        //哪个被选中了
        currentIndex: _currentIndex,
        onTap: (int index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
