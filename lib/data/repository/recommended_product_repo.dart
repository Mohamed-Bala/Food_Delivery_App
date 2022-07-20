import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    return apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URL);
  }
//______________________________________________________________________________
}
