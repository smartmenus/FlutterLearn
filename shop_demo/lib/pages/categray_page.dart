import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_demo/service/service_method.dart';
import '../model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategrayPage extends StatefulWidget {
  @override
  _CategrayPageState createState() => _CategrayPageState();
}

class _CategrayPageState extends State<CategrayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品分类'),),
      body: Row(
          children: <Widget>[
            LeftCategoryNav(),
          ],
      ),

    );
  }

}

//左侧大类导航
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {

  List list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1, color: Colors.black12)
        )
      ),
      child: ListView.builder(itemBuilder: (context, index){
        return _leftInkWell(index);
      }, itemCount: list.length,),
    );
  }

  Widget _leftInkWell(int index){

    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12)
          )
        ),

        child: Text(list[index].mallCategoryName, style: TextStyle(fontSize: ScreenUtil().setSp(28)),),
      ),
    );

  }

  void _getCategory() async{
    request('getCategory').then((val){

      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
      //list.data.forEach((item)=> print(item.mallCategoryName));
    });
  }
}


