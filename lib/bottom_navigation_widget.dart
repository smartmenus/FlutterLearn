import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'pages/address_screen.dart';
import 'pages/message_screen.dart';
import 'pages/person_screen.dart';
import 'pages/work_screen.dart';

class BottomNavgationWidget extends StatefulWidget {
  @override
  _BottomNavgationWidgetState createState() => _BottomNavgationWidgetState();
}

class _BottomNavgationWidgetState extends State<BottomNavgationWidget> {

  final _BottomNavigationColor = Colors.blue;
  int _currentIndex = 0;
  List<Widget> screensList = List();

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
    return Scaffold(
      body: screensList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              color: _BottomNavigationColor,
            ),
            title: Text(
              '消息',
              style: TextStyle(color: _BottomNavigationColor),
            )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.work,
                color: _BottomNavigationColor,
              ),
              title: Text(
                '工作',
                style: TextStyle(color: _BottomNavigationColor),
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard,
                color: _BottomNavigationColor,
              ),
              title: Text(
                '通讯录',
                style: TextStyle(color: _BottomNavigationColor),
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.near_me,
                color: _BottomNavigationColor,
              ),
              title: Text(
                '我',
                style: TextStyle(color: _BottomNavigationColor),
              )
          ),
        ],
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
