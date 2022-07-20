import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return apiClient.getData(AppConstants.POPULAR_PRODUCT_URL);
  }
//______________________________________________________________________________
}
