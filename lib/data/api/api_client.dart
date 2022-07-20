import 'package:get/get.dart';

import '../../utils/constants.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = AppConstants.TOKEN;
    _mainHeaders = {
      'Content-type': 'application/json;charset=UTF-8',
      'Authorization': 'bearer $token'
    };
  }
// Get Fuction
  Future<Response> getData(String uri) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (error) {
      return Response(
        statusCode: 1,
        statusText: error.toString(),
      );
    }
  }
//______________________________________________________________________________
}
