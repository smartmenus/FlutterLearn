import 'dart:convert';
import '../provide/child_category.dart';
import 'package:provide/provide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_demo/service/service_method.dart';
import '../model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/category_good.dart';
import '../provide/categroy_goods_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList()
              ],
            )
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
  int listIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategory();
    _getGoodsList();
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
    bool isChlick = false;
    isChlick = (index == listIndex)?true:false;
    return InkWell(
      onTap: (){
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        Provide.value<ChildCategory>(context).getChildCategory(childList,categoryId);
        _getGoodsList(categoryId:categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          color: isChlick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
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
      Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
    });
  }

   void _getGoodsList({String categoryId}) async{
        var data = {
          'categoryId': categoryId==null? '4' : categoryId,
          'categorySubId': '',
          'page': '1'
        };
        await request('getMallGoods', formData: data).then((val){
          var data = json.decode((val.toString()));
          CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
          Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
        });
  }
}

//小类右侧导航
class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, childCategory){
       return Container(
            height: ScreenUtil().setHeight(80),
            width: ScreenUtil().setWidth(570),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(width: 1,color: Colors.black12))
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: childCategory.childCategoryList.length,
              itemBuilder: (context, index){
                return _rightInkWell(index, childCategory.childCategoryList[index]);
              },
      ),
    );
      },
    );
  }

  Widget _rightInkWell(int index, BxMallSubDto item){
    bool isChlick = false;
    isChlick = (index == Provide.value<ChildCategory>(context).childIndex)? true : false;
    return InkWell(
      onTap: (){
        Provide.value<ChildCategory>(context).changeChildIndex(index, item.mallSubId);
        _getGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style:TextStyle(
            fontSize:ScreenUtil().setSp(28), 
            color: isChlick ? Colors.pink : Colors.black
            )
          ),
      ),
    );
  }

  void _getGoodsList(String categorySubId){
        var data = {
          'categoryId': Provide.value<ChildCategory>(context).categoryId,
          'categorySubId': categorySubId,
          'page': '1'
        };
         request('getMallGoods', formData: data).then((val){
          var data = json.decode((val.toString()));
          CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
          if(goodsList.data == null){
            Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]); 
          }else
            Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
        });
  }
}

// 商品列表  可以上拉加载
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {

  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
  var scrollController = new ScrollController();
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data){
        try{
          if(Provide.value<ChildCategory>(context).page == 1){
            //列表位置放到最上面
            scrollController.jumpTo(0.0);
          }
        }catch(e){
          print('进入页面第一次初始化：${e}');
        }
        if(data.goodsList.length > 0){
          return  Expanded(
            child: Container(
                  width: ScreenUtil().setWidth(570),
                  child: EasyRefresh(
                    refreshFooter: ClassicsFooter(
                      key: _footerKey,
                      bgColor: Colors.white,
                      textColor: Colors.pink,
                      moreInfoColor: Colors.pink,
                      showMore: true,
                      noMoreText: Provide.value<ChildCategory>(context).noMoreText,
                      moreInfo: '加载中',
                      loadReadyText: '上拉加载',
                    ),
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: data.goodsList.length,
                      itemBuilder: (context, index){
                        return _listWidge(data.goodsList, index);
                    },
                  ),
                    loadMore: () async{
                      print('上拉加载更多');
                      _getMoreList();
                    },
                   
              ),
            ),
          );
        }else{
          return Text('暂时没有数据');
        } 
      },
    );
  }

  void _getMoreList(){
    Provide.value<ChildCategory>(context).addPage();
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': Provide.value<ChildCategory>(context).categorySubId,
      'page': Provide.value<ChildCategory>(context).page,
    };
    request('getMallGoods', formData: data).then((val){
      var data = json.decode((val.toString()));
      print('<<<<<<<<<<<<${data}');
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if(goodsList.data == null){
        Fluttertoast.showToast(
          msg: '已经到底',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16.0
        );
        Provide.value<ChildCategory>(context).chageNomoreText('没有更多数据了'); 
      }else
        Provide.value<CategoryGoodsListProvide>(context).getMoreList(goodsList.data);
    });
  }

  Widget _goodsImage(List newList , int index){
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }

  Widget _goodsName(List newList, int index){
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].goodsName,
        maxLines:2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodsPrices(List newList,int index){
    return Container(
      width: ScreenUtil().setWidth(370),
      margin: EdgeInsets.only(top:20),
      child: Row(
        children: <Widget>[
          Text(
            '价格:￥${newList[index].presentPrice}',
            style: TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            '价格:￥${newList[index].oriPrice}',
             style: TextStyle(color: Colors.black26, decoration: TextDecoration.lineThrough),
          ),
        ],
      ),
    );
  }

  Widget _listWidge(List newList, int index){
    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12)
          )
          ),
        child: Row(
          children: <Widget>[
            _goodsImage(newList, index),
            Column(
              children: <Widget>[
                _goodsName(newList, index),
                _goodsPrices(newList, index)
              ],
            )
          ],
        ),
      ),
    );
  }
}


