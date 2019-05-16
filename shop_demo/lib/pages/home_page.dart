import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shop_demo/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

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
            String adPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImage = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];
            List <Map> recommendList = (data['data']['recommend'] as List).cast();

            return SingleChildScrollView(
              child:  Column(
                children: <Widget>[
                  SwiperDiy(swiperDataList: swiper,),
                  TopNavigator(navigatorList: navigatorList),
                  AdBanner(adPicture: adPicture,),
                  LeaderPhone(leaderImage: leaderImage, leaderPhone: leaderPhone,),
                  Recommand(recommandList: recommendList,),
                ],
              ),
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

/// 菜单分类
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
      height: ScreenUtil.getInstance().setHeight(280),
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

///广告
class AdBanner extends StatelessWidget {
  
  final String adPicture;
  AdBanner({Key key , this.adPicture}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0),
      child: Image.network(adPicture),
    );
  }
}

///拨打电话
class LeaderPhone extends StatelessWidget {

  final String  leaderPhone;
  final String  leaderImage;
  LeaderPhone({Key key, this.leaderPhone, this.leaderImage}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: (){
          _launcherURL();
        },
        child: Image.network((leaderImage)),
      ),
    );
  }

  _launcherURL() async{
    String url = 'tel:' + leaderPhone;
    if( await canLaunch(url)){
      await launch(url);
    }else{
      throw 'url 不能进行访问，异常';
    }
  }
}

// 商品推荐
class Recommand extends StatelessWidget {
  final List recommandList;
  Recommand({Key key, this.recommandList}):super(key: key);

  //标题方法
  Widget _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.black12),
        ),
      ),
      child: Text('商品推荐', style: TextStyle(color: Colors.pink),),
    );
  }
  // 商品单独箱方法
  Widget _item(index){
    return InkWell(
      onTap: (){

      },
      child: Container(
        height: ScreenUtil.getInstance().setHeight((330)),
        width: ScreenUtil.getInstance().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border:Border(
            left: BorderSide(width: 0.5, color: Colors.black12),
          ),
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommandList[index]['image']),
            Text('￥${recommandList[index]['mallPrice']}'),
            Text('￥${recommandList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),)
          ],
        ),
      ),
    );
  }

  //横向列表
  Widget _recommandList(){
    return Container(
      height: ScreenUtil.getInstance().setHeight(330),
      margin: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommandList.length,
        itemBuilder: (context, index){
          return _item(index);
       },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(380),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommandList(),
        ],
      ),
    );
  }
}









