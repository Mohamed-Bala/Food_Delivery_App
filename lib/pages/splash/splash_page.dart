import 'dart:async';

import 'package:Food_Delivery_App/controller/popular_product_controller.dart';
import 'package:Food_Delivery_App/controller/recommended_product_controller.dart';
import 'package:Food_Delivery_App/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  // load Data form Server
  Future<void> _loadData() async {
    await Get.find<PopularProductController>().getPopularProduct();
    await Get.find<RecommendedProductController>().getRecommendedProduct();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    );

    // time when he take to next page
    Timer(
      const Duration(seconds: 4),
      () => Get.offNamed(RouteHelper.getInitial()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
                child: Image.asset(
              'assets/images/food-logo.jpg',
              width: 350,
            )),
          ),
          Image.asset(
            'assets/images/text.png',
            width: 250,
          ),
        ],
      ),
    );
  }
}
