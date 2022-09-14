import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task/api_helper/api_provider/api_provider.dart';
import 'package:task/api_helper/cartlist_model.dart';
import 'package:task/api_helper/productlist_model.dart';
import 'package:task/db_helper/cart_services.dart';

class ProductListController extends GetxController with GetSingleTickerProviderStateMixin{
  var loading = true.obs;
  /// oberservable model class variable
  Rx<ProductListModel> productList=ProductListModel().obs;
  CartServices cartServices = CartServices();

  List<CartData> cartItems = [];
  RxBool isLoading = false.obs;

  @override
  void onInit() async {

    super.onInit();
    loadDB();
  }

  loadDB() async {
    await cartServices.openDB();
    getCardList();
  }

  /// controller function where we assign api response in observable model class and write all bussiness logics
  Future<void> productListContr({required String page,required String perPage}) async {
    loading(true);

    try {
      var response = await ApiProvider().getProductList(page: page, perPage: perPage);
      if (response != null) {
        productList.value=response ;
        update();
        return;
      }
    }catch(e) {
      print(e);

    } finally {
      loading(false);
    }
  }
  /// checking if it is already present in cartlist
  bool isAlreadyInCart(id) {
    return cartItems.indexWhere((element) => element.id == id) > -1;
  }
  getCardList() async{
    isLoading(true);

    try {
      List list = await cartServices.getCartList();
      print(list);
      cartItems.clear();
      list.forEach((element) {
        cartItems.add(CartData.fromJson(element));
        print(cartItems.length.toString()+"cartitems length");
      });
      isLoading(false);

      update();

    } catch (e) {
      print(e);
    }finally{
      isLoading(false);

    }
  }

  Future addToCart(CartData item) async {
    isLoading(true);
    update();
    var result = await cartServices.addToCart(item);
    isAlreadyInCart(item.id);
    isLoading(false);
    getCardList();

    update();
    return result;
  }

  removeFromCart(int shopId) async {
    cartServices.removeFromCart(shopId);
    int index = cartItems.indexWhere((element) => element.id == shopId);
    cartItems.removeAt(index);
    update();
  }


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
