import 'package:Food_Delivery_App/models/products_model.dart';
import 'package:get/get.dart';

import '../data/repository/recommended_product_repo.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

  List<Products> _recommendedProductList = [];
  // acsecc the get function any where
  List<Products> get recommendedProductList => _recommendedProductList;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getRecommendedProduct() async {
    Response response = await recommendedProductRepo.getRecommendedProductList();

    if (response.statusCode == 200) {
      _recommendedProductList = [];
      // Data In Model Server response json
      _recommendedProductList.addAll(ProductModel.fromJson(response.body).products);
      _isLoading = true;
      update();
    } else {}
  }
//______________________________________________________________________________
}
