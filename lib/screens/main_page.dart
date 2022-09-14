import 'package:flutter/material.dart';
import 'package:task/api_helper/cartlist_model.dart';
import 'package:task/api_helper/controller/productlist_controller.dart';
import 'package:task/api_helper/productlist_model.dart';
import 'package:task/screens/my_cart.dart';
import 'package:task/utils/colors_const.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ProductListController _productListController = Get.put(
      ProductListController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productListController.productListContr(page: "1", perPage: "5");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shopping Mall",
          style: TextStyle(color: whiteColor, fontSize: 16),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const MyCart()));
              },
              icon: Icon(
                Icons.shopping_cart_rounded,
                color: whiteColor,
              ))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() {
            /// showing loader while data is fetching
            if (_productListController.loading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              /// checking if product list is empty
              if (_productListController.productList.value.data!.isEmpty) {
                return const Center(
                  child: Text("No Data Available"),
                );
              } else {
                return gridView(_productListController.productList.value);
              }
            }
          })
      ),
    );
  }

  Widget gridView(ProductListModel productListModel) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            childAspectRatio: 0.9,
            crossAxisSpacing: 4),
        // itemCount: _controller.quizListing.length,
        itemCount: productListModel.data!.length,
        itemBuilder: (BuildContext ctx, int index) {
          return Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                    color: greyColor.withOpacity(0.8),
                    blurRadius: 2,
                    spreadRadius: 1,
                    offset: const Offset(-4, 4))
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                            color: greyColor,
                            spreadRadius: 0.0,
                            blurRadius: 5,
                            offset: const Offset(-3, 3))
                      ],
                      image: DecorationImage(image: NetworkImage(
                          productListModel.data![index].featuredImage
                              .toString()),
                          fit: BoxFit.cover)
                  ),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.15,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(

                        /// if name of product way more then limit
                        productListModel.data![index].title!.length > 25
                            ? "${productListModel.data![index].title!.substring(
                            0, 23)}.."
                            : productListModel.data![index].title.toString(),
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: greyColor,

                        ),

                      ),
                    ),
                    GetBuilder<ProductListController>(builder: (_) {
                      print(_.isLoading);
                      bool isAdded = _.isAlreadyInCart(_productListController.productList.value.data![index].id);
                      print(isAdded.toString()+"added Bool");

                      if (isAdded) {
                        return IconButton(
                          icon: Icon(Icons.remove_shopping_cart_sharp,color: greyColor,),
                          onPressed: () async {
                            try {
                              _.removeFromCart(_productListController.productList.value.data![index].id!);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(
                                  "Item removed from cart successfully")));
                            } catch (e) {
                              print(e);
                            }
                          },
                        );
                      }
                      return IconButton(
                          onPressed:
                            _.isLoading.value==true ? (){
                              print("exception");

                            } : () async {
                            print("added");
                              try {
                                var result = await _productListController.addToCart(CartData(
                                  id: _productListController.productList.value.data![index].id,
                                  featuredImage: _productListController.productList.value.data![index].featuredImage,
                                  price: double.parse(_productListController.productList.value.data![index].price.toString()),
                                  quantity: "1",
                                  title: _productListController.productList.value.data![index].title.toString()
                                ));
                                _productListController.getCardList();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text(
                                    "Item added in cart successfully")));
                              } catch (e) {
                                print(e);
                              }
                            },

                          icon: Icon(
                            Icons.shopping_cart_sharp,
                            color: greyColor,
                          ));
                    }),


                  ],
                )
              ],
            )
            ,
          );
        });
  }
}
