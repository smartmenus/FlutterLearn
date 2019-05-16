import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:shop_demo/config/servcie_url.dart';

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