import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'dart:convert';


class NetUtil{
  static final debug = true;
  static final baseUrl = 'http://cmp.xspinfo.com:90/jsonServer.php';
  static BuildContext context = null;

  //基础信息配置
  static final Dio _dio =  Dio(BaseOptions(
      method: "get",
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      followRedirects: true
  ));

  static String sessionid;

  static final LogicError unknowError = LogicError(-1, "未知异常");

  static Future<Map<String, dynamic>> getJson<T>(
      String uri, Map<String, dynamic> paras) =>
      _httpRequest("get", uri, data: paras).then(logicalErrorTransform);

  static Future<Map<String, dynamic>> getForm<T>(
      String action, Map<String, dynamic> paras) =>
      _httpRequest("get", action, data: paras, dataIsJson: false)
          .then(logicalErrorTransform);

  /// 表单方式的post
  static Future<Response<Map<String, dynamic>>> postForm<T>(
      String action, Map<String, dynamic> paras) =>
      _httpRequest("post", action, data: paras, dataIsJson: false);

  static Future<Response<Map<String, dynamic>>> _httpRequest(
      String method, String action, {Map<String, dynamic> data, dataIsJson = true}
      ){
      ///获取公共参数
      Map baseParams = getBaseParams();
      /// 加入action
      baseParams['action'] = action;
      /// 在data 在加入 公共参数 'clientVersion': '2.0',
      data['clientVersion'] = '2.0';
      /// 将 data 转成 json字符
      var jsonStr = json.encode(data);
      /// 将 jsonStr 加入到 baseParams中
      baseParams['jsonstr'] = jsonStr;

      if(sessionid != null && sessionid.length > 0 && action != 'Login'){
        baseParams['sessionid'] = sessionid;
      }

      if (debug) {
       print('<net action>------$action');
        print('<net params>------$baseParams');
      }

      /// 根据当前 请求的类型来设置 如果是请求体形式则使用json格式
      /// 否则则是表单形式的（拼接在url上）
      Options op;
      if (dataIsJson) {
        op = new Options(contentType: ContentType.parse("application/json"));
      } else {
        op = new Options(
            contentType: ContentType.parse("application/x-www-form-urlencoded"));
      }

      op.method = method;

      /// 统一带上sessionid
      return _dio.request<Map<String, dynamic>>(
          method == "get" ? baseUrl : "$baseUrl?token=$sessionid",
          data: baseParams,
          options: op);
  }


  /// 对请求返回的数据进行统一的处理
  /// 如果成功则将我们需要的数据返回出去，否则进异常处理方法，返回异常信息
  static Future<T> logicalErrorTransform<T>(Response<Map<String, dynamic>> resp) {
    if (resp.data != null) {
      if (resp.data["result"] == 1) {
        T realData = resp.data["content"];
        return Future.value(realData);
      }
    }

    if (debug) {
      print('resp--------$resp');
      print('resp.data--------${resp.data}');
    }

    LogicError error;
    if (resp.data != null && resp.data["reslut"] != 1) {
      if (resp.data['data'] != null) {
        /// 失败时  错误提示在 data中时
        /// 收到token过期时  直接进入登录页面
        Map<String, dynamic> realData = resp.data["data"];
        error = LogicError(resp.data["code"], realData['codeMessage']);
      } else {
        /// 失败时  错误提示在 message中时
        error = LogicError(resp.data["code"], resp.data["message"]);
      }
    } else {
      error = unknowError;
    }
    return Future.error(error);
  }

  ///获取授权token
  static getToken() async {
    return sessionid;
  }

  static getTimestamp(){

    String timeStamp = DateTime.now().toLocal().millisecondsSinceEpoch.toString();
    timeStamp = timeStamp.substring(0,10);
    print('time' + timeStamp);
    String timeStampSp = timeStamp + '_SPCMP';
    var bytes = utf8.encode(timeStampSp);
    return base64Encode(bytes);
  }

  static getBaseParams (){

    return {'stamp' : getTimestamp(),
           'clientVersion' : '2.0',
            'cid' : '6',
    };
  }

  static String getURLForClientMenuImageWithActionFlag(flowid){
    var parmar = {'actionFlag': 'flow_' + flowid};
    var jsonStr = json.encode(parmar);
    var stampStr = getTimestamp();
    var urlStr = baseUrl + '?stamp=$stampStr' +'&' + 'clientVersion=2.0' + '&' + 'cid=6'
        + '&' + 'sessionid=$sessionid' + '&' +'jsonstr=$jsonStr' + '&action=clientMenuImage';
    print('__________$urlStr');
    return urlStr;
  }

}


class LogicError {
  int errorCode;
  String msg;

  LogicError(errorCode, msg) {
    this.errorCode = errorCode;
    this.msg = msg;
  }
}