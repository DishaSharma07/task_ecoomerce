import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/api_helper/cartlist_model.dart';
import 'package:task/api_helper/controller/productlist_controller.dart';
import 'package:task/utils/colors_const.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  final controller = Get.find<ProductListController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: TextStyle(
              color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body:GetBuilder<ProductListController>(
        builder: (_) {
          if (controller.cartItems.length == 0) {
            return Center(
              child: Text("No item found"),
            );
          }
          return ListView(
            children: _.cartItems.map((e) => cartList(ctx: context,data: e)).toList(),
          );
        },
      ),
      bottomSheet: bottomSheet(),
    );
  }

  Widget cartList({required BuildContext ctx,required CartData data}) {
          return Container(
            margin: const EdgeInsets.all(8),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: whiteColor,
              boxShadow: [
                 BoxShadow(
                  offset: const Offset(3, 2),
                   color: greyColor,
                   blurRadius: 3
                )
              ]
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.18,
                    decoration:  BoxDecoration(
                        color: Colors.blue,
                        borderRadius:const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                    image: DecorationImage(image: NetworkImage((data.featuredImage!)))),

                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title!,
                          style: TextStyle(fontSize: 16, color: greyColor),
                        ),
                        const SizedBox(height: 8,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Price",
                              style: TextStyle(fontSize: 14, color: greyColor),
                            ),
                            Text(
                              "\$ 400",
                              style: TextStyle(fontSize: 14, color: greyColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Quantity",
                              style: TextStyle(fontSize: 14, color: greyColor),
                            ),
                            Text(
                              "4",
                              style: TextStyle(fontSize: 14, color: greyColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8,),

                      ],
                    ),
                  ),
                )
              ],
            ),
          );

  }
  Widget bottomSheet(){
    return Container(
      color: primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
          children: [
            Text("Total items:2",style: TextStyle(color: whiteColor),),
            Text("Grand Total:2",style: TextStyle(color: whiteColor),),
          ],
        ),
      ),
    );
  }
}
