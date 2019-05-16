import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/pages/flowlist_screen.dart';
import 'package:flutter_app_demo/tools/netutil.dart';
import 'dart:convert';
import 'package:flutter_app_demo/models/user.dart';

class MessageScreen extends StatelessWidget {
  final  double _titleFontSize = 18.0;
  @override
  Widget build(BuildContext context) {
    loginserver('pp', 'PPaZJ992560');
    return Scaffold(
      appBar: AppBar(
        title: Text('消息'),
        elevation: 1,
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
                  return FlowListPage();
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

  Future<String> loginserver(String name, String pwd) async {

    var jsonDic = {'souse': 'Eomp',
      'deviceID':'fdfdsfd',
      'user': name,
      'pwd': pwd};
//    NetUtil.postForm('Login', jsonDic).then((value){
//
//      print(value);
//      var user = User.fromJson(value);
//      NetUtil.sessionid = user.sessionid;
//      print(user.ename);
//    });
      NetUtil.postForm('Login', jsonDic).then((Response<Map<String, dynamic>> resp){

        if(resp.data['result'] == 1){

          var useInfo = resp.data['content'];
          var userModel = User.fromJson(useInfo);
          NetUtil.sessionid = userModel.sessionid;

          print(userModel.ename);
        }
      });
  }


}
