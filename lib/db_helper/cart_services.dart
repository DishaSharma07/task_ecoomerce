import 'package:task/api_helper/cartlist_model.dart';
import 'package:task/db_helper/db_helper.dart';

class CartServices {
  DbHelper dbHelper = DbHelper();

  Future openDB() async {
    return await dbHelper.openDB();
  }

  Future addToCart(CartData data) async {
    return await dbHelper.addToCart(data);
  }

  Future getCartList() async {

    return await dbHelper.getCartList();
  }

  removeFromCart(int shopId) async {
    return await dbHelper.removeFromCart(shopId);
  }
}
