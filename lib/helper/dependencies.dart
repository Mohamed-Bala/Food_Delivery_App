import 'package:e_commerce_app/controller/cart_controller.dart';
import 'package:e_commerce_app/data/repository/cart_repo.dart';
import 'package:get/get.dart';

import '../controller/popular_product_controller.dart';
import '../controller/recommended_product_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/popular_product_repo.dart';
import '../data/repository/recommended_product_repo.dart';
import '../utils/constants.dart';

Future<void> init() async {
  // Api Client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BAES_URL));

  // Repository
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());

  // Controller
  Get.lazyPut(() => PopularProductController(productRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
