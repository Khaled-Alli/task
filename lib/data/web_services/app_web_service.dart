
import 'package:dio/dio.dart';

import '../../utiles/constants.dart';

class AppWebServices {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseURL,
      receiveDataWhenStatusError: true,
      connectTimeout: 1000 * 20,
      receiveTimeout: 1000 * 20,
    ),
  );

 static Future<Map<String,dynamic>> getProducts() async {
    try {
      Response response = await dio.get(Constants.productsEndPoint);
      return response.data;
    } catch (e) {
      print(e.toString());
      return {};
    }
  }


}
