import 'package:flutter/material.dart';
import 'pages/index_page.dart';
import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/categroy_goods_list.dart';
import 'package:fluro/fluro.dart';
import './routers/routers.dart';
import './routers/application.dart';
import './provide/details_info.dart';


void main(){
  var counter = Counter();
  var childCategory = ChildCategory();
  var categroyGoodsList = CategoryGoodsListProvide();
  var detailInfoProvide = DetailsInfoProvide();
  var providers = Providers();
  providers
  ..provide(Provider<Counter>.value(counter))
  ..provide(Provider<ChildCategory>.value(childCategory))
  ..provide(Provider<CategoryGoodsListProvide>.value(categroyGoodsList))
  ..provide(Provider<DetailsInfoProvide>.value(detailInfoProvide));

  runApp(ProviderNode(child: MyApp(), providers: providers,));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false, ///去掉显示debug
        theme: ThemeData(
          primaryColor: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}
