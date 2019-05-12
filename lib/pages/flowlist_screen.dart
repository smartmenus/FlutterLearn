import 'package:flutter/material.dart';

class FlowListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('流程') ,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.fastfood),
            title: Text('测试流程'),
            subtitle: Text('请假流程'),
          ),
        ],
      ),
    );
  }
}
