import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier{

  List<BxMallSubDto> childCategoryList = [];

  int childIndex = 0; //子类高亮索引
  String categoryId = '4';  //大类ID
  String categorySubId = ''; //小类ID
  int page = 1;   //页数
  String noMoreText = ''; //显示没有数据的文字

  //点击大类时候，归零
  getChildCategory(List<BxMallSubDto> list, String id){

    page = 1;
    noMoreText = '';
    childIndex = 0;
    categoryId = id;
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallSubName = '全部';
    all.mallCategoryId = '00';
    all.comments = 'null';
    
    childCategoryList = [all] ;
    childCategoryList.addAll(list);
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(index, String id){

    page = 1;
    noMoreText = '';
    childIndex = index;
    categorySubId = id;
    notifyListeners();
  }

  //增加page的方法
  addPage(){
    page++;
    notifyListeners();
  }

  chageNomoreText(String text){
    noMoreText = text;
    notifyListeners();
  }
}