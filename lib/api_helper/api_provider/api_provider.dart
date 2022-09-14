import 'package:get/get.dart';
import 'package:task/api_helper/api_provider/api_basehelper.dart';
import 'package:task/api_helper/productlist_model.dart';

class ApiProvider extends GetConnect {
  static final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  /// Here we are fetching data or posting to api
  Future<ProductListModel?> getProductList(
      {required String page, required String perPage}) async {
    Map requestBody = {"page": page, "perPage": perPage};
    final response = await _apiBaseHelper.post('categoryTypeList', requestBody);
    try {
      return ProductListModel.fromJson(response);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
