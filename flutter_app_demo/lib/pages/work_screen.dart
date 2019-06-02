import 'package:flutter/material.dart';
import 'package:flutter_app_demo/tools/netutil.dart';
import 'package:dio/dio.dart';

class WorkScreen extends StatefulWidget {
  @override
  _WorkScreenState createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // _getWorkEnergyData();
  }

//  void _getWorkEnergyData(){
//    Map params = {'clientAddr': 'http://cmp.xspinfo.com'};
//    NetUtil.getForm('getPositiveContent', params).then((Response<Map<String, dynamic>> resp){
//
//      print(resp.toString());
//    });
 // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('工作'),),
      body: Container(
        child: Text('工作'),
      ),
    );
  }


}


class WorkEnergy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

