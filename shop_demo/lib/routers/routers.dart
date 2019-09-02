import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handle.dart';

class Routes {
   static String root = '/';
   static String detailPage = '/detail';
   static void configureRoutes(Router router){
     router.notFoundHandler = new Handler(
       handlerFunc: (BuildContext context, Map<String, List<String>>params){
         print('ERROR====> ROUTE WAS NOT FONFUND');
       }
     );

     router.define(detailPage, handler: detailsHandler);
   }
}