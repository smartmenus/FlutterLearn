import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app_demo/models/flow.dart';
import 'dart:io';

import 'package:flutter_app_demo/tools/netutil.dart';

class FlowListPage extends StatefulWidget {
  @override
  _FlowListPageState createState() => _FlowListPageState();

}

class _FlowListPageState extends State<FlowListPage> {
  List<Widget> flowListCells = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUndoFlowList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('流程') ,
      ),
      body:ListView(
        children: flowListCells,
      ),
    );
  }

  getUndoFlowList() async{
    var jsonDic = {'s_search': '',
      'fid': '',
      'type': '2',
      'page': '1'
    };

    NetUtil.postForm('webgetFlowListV2', jsonDic).then((Response<Map<String, dynamic>> resp){

      if(resp.data['result'] == 1){
        List flowInfoData = resp.data['content'];
        List <Widget> tempList = [];
        for (var i = 0; i < flowInfoData.length; ++i) {
          var o = flowInfoData[i];
          FlowList flowListModel = FlowList.fromJson(o);
          FlowListCell flowCell = FlowListCell(flowListInfo: flowListModel,);
          tempList.add(flowCell);
        }
        setState(() {
          flowListCells = tempList;
        });
      }
    });

  }
}

class FlowListCell extends StatelessWidget {

   FlowList  flowListInfo;
   final double _logo_w_h = 30.0;
   FlowListCell({this.flowListInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            //距离
            padding: const EdgeInsets.only(left: 8.0),
            child: FadeInImage.assetNetwork(
              image: NetUtil.getURLForClientMenuImageWithActionFlag(flowListInfo.flowId),
              placeholder: 'images/yingyong-icon-img8.png',
              width: _logo_w_h,
              height: _logo_w_h,

            ),

          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 15),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 5.0),
                  width:  300.0,
                  height: 20.0,
                  child:  Text(flowListInfo.msgTitleShort,style: TextStyle(fontSize: 18),),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5.0, top: 5.0),
                  alignment: AlignmentDirectional.centerStart,
                  width:  300.0,
                  height: 20.0,
                  child:  Text(flowListInfo.flowName,style: TextStyle(fontSize: 13),),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 8),
            child: Container(
              height: 30,
              width: 50,
              alignment: AlignmentDirectional.topStart,
              child: Text(flowListInfo.msgTime.substring(10, 19), style: TextStyle(fontSize: 12, color: Colors.grey),),
            ),
          ),
        ],

      )
    );
  }
}

