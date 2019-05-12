import 'package:flutter/material.dart';
import 'package:flutter_app/pages/flowlist_screen.dart';

class MessageScreen extends StatelessWidget {
  final  double _titleFontSize = 18.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('message'),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.email),
              title: Text('邮件小助手', style: TextStyle(fontSize: _titleFontSize),),
            ),
            ListTile(
              leading: Icon(Icons.filter_list),
              title: Text('流程小助手',style: TextStyle(fontSize: _titleFontSize),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                  return FlowListScreen();
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('消息小助手',style: TextStyle(fontSize: _titleFontSize),),
            )
          ],
        ),
      ),
    );
  }
}
