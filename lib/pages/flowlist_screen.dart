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
            child: Text('测试流程   潘平 2019-04-29 14:24:29',style: TextStyle(fontSize: 16),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 30),
            child: Text('协作单', style: TextStyle(fontSize: 13, color: Colors.blueGrey),),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text('17:36:17', style: TextStyle(fontSize: 10, color: Colors.grey),),
          ),


        ],

    );
  }
}

