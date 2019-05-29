import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:shop_demo/config/servcie_url.dart';

Future request(url, formData) async{

  try{
    print('开始获取数据。。。。。。');
    Response response;
    Dio dio = Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    if(formData == null){
      response = await dio.post(serverPath[url]);
    }else
      response = await dio.post(serverPath[url], data: formData);

    if(response.statusCode == 200){
      return response.data;

    }else{
      throw Exception('后端接口异常');
    }
  }catch(e){
    return print('ERROR:=================>$e');
  }

}

Future getHomePageData() async{

  try{
    print('开始获取数据。。。。。。');
    Response response;
    Dio dio = Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    var formData= {'lon': '115.02932', 'lat': '35.76189'};
    response = await dio.post(serverPath['homePageContent'], data: formData);
    if(response.statusCode == 200){
      return response.data;

    }else{
      throw Exception('后端接口异常');
    }
  }catch(e){
    return print('ERROR:=================>$e');
  }

}

//获取商品火爆专区
Future getHomePageBelowData() async{

  try{
    print('开始获取火爆专区数据。。。。。。');
    Response response;
    Dio dio = Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    int page = 1;
    response = await dio.post(serverPath['homePageBelowContent'], data: page);
    if(response.statusCode == 200){
      return response.data;

    }else{
      throw Exception('后端接口异常');
    }
  }catch(e){
    return print('ERROR:=================>$e');
  }

}