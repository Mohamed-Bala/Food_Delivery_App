import 'package:Food_Delivery_App/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/popular_product_controller.dart';
import 'controller/recommended_product_controller.dart';
import 'pages/food_detail/food_detail.dart';
import 'pages/food_detail/recommened_food_detail.dart';
import 'helper/dependencies.dart' as dep;
import 'pages/home/main_food_page.dart';
import 'utils/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProduct();
    Get.find<RecommendedProductController>().getRecommendedProduct();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: lightTheme,
      home: const MainFoodPage(),
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}
