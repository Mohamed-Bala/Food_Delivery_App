import 'package:e_commerce_app/data/api/api_client.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    return apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URL);
  }
//______________________________________________________________________________
}
