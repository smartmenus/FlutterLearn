import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app_test/models/flow.dart';

import 'package:flutter_app_test/tools/netutil.dart';

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
      'type': '1',
      'page': '1'
    };

    NetUtil.postForm('webgetFlowListV2', jsonDic).then((Response<Map<String, dynamic>> resp){

      if(resp.data['result'] == 1){
        List flowInfoData = resp.data['content'];
        List <Widget> tempList = [];
        for (var i = 0; i < flowInfoData.length; ++i) {
          var o = flowInfoData[i];
          var flowListModel = FlowList.fromJson(o);
          FlowListCell flowCell = FlowListCell();
          tempList.add(flowCell);
        }
        setState(() {
          flowListCells = tempList;
        });
      }
    });

  }
}


class FlowListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getUndoFlowList();
    return Scaffold(
      appBar: AppBar(
        title:Text('流程') ,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.featured_video),
            title: Text('测试流程   潘平 2019-04-29 14:24:29',style: TextStyle(fontSize: 16),),
            subtitle: Text('协作单', style: TextStyle(fontSize: 13, color: Colors.blueGrey),),
            isThreeLine: true,
          ),
          ListTile(
            leading: Icon(Icons.featured_video),
            title: Text('测试流程   潘平 2019-04-29 14:24:29',style: TextStyle(fontSize: 16),),
            subtitle: Text('协作单', style: TextStyle(fontSize: 13, color: Colors.blueGrey),),
            isThreeLine: true,
          ),
          FlowListCell(),
        ],
      ),
    );
  }

  Future<String> getUndoFlowList(){
    var jsonDic = {'s_search': '',
      'fid': '',
      'type': '1',
      'page': '1'
    };

    print(jsonDic);
    NetUtil.postForm('webgetFlowListV2', jsonDic).then((Response<Map<String, dynamic>> resp){

      if(resp.data['result'] == 1){
        List flowInfos = resp.data['content'];
      }
    });
  }
}

class FlowListCell extends StatelessWidget {

   final double _logo_w_h = 30.0;
  @override
  Widget build(BuildContext context) {
    return Row(

        children: <Widget>[
          Padding(
            //距离
            padding: const EdgeInsets.only(left: 8.0),
            child: Image.network(
              'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2613104448,3119831597&fm=27&gp=0.jpg',
              width: _logo_w_h,
              height: _logo_w_h,
            ),

          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 5.0),
                  width:  300.0,
                  height: 20.0,
                  child:  Text('测试流程   潘平 2019-04-29 14:24:29',style: TextStyle(fontSize: 16),),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5.0),
                  alignment: AlignmentDirectional.centerStart,
                  width:  300.0,
                  height: 20.0,
                  child:  Text('协作单',style: TextStyle(fontSize: 16),),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 0),

            child: Container(
              height: 20,
              width: 50,
              alignment: AlignmentDirectional.topStart,
              child: Text('17:36:17', style: TextStyle(fontSize: 12, color: Colors.grey),),
            ),
          ),
        ],

    );
  }
}

