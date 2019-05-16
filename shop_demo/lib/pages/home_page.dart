import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shop_demo/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = '正在获取数据';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+'),),
      body: FutureBuilder(
        future: getHomePageData(),
        builder: (context, snapshort){
          if(snapshort.hasData){
            var data = json.decode(snapshort.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast();
            List<Map> navigatorList = (data['data']['category'] as List).cast();

            return Column(
              children: <Widget>[
                SwiperDiy(swiperDataList: swiper,),
                TopNavigator(navigatorList: navigatorList),
              ],
            );

          }else{
            return Center(
              child: Text('加载中'),
            );

          }
        },
      ),
    );
  }
}

/// 首页轮播组件
class SwiperDiy extends StatelessWidget {

  //接受参数
  final List swiperDataList;
  SwiperDiy({Key key, this.swiperDataList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(333),
      child: Swiper(
        itemBuilder: (BuildContext context, int index){
          return Image.network('${swiperDataList[index]['image']}', fit: BoxFit.fill,);
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
      ),
    );
  }
}

class TopNavigator extends StatelessWidget {

  final List navigatorList;
  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItem(BuildContext context, item){

    return InkWell(
      onTap: (){
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil.getInstance().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    if(this.navigatorList.length > 10){
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }

    return Container(
      height: ScreenUtil.getInstance().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item){
            return  _gridViewItem(context, item);
        }).toList(),

      ),
    );
  }
}






