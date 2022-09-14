

class CartData {
  int? id;
  String? title;
  double? price;
  String? featuredImage;
  String? quantity;

  CartData(
      {this.id,
      this.title,
      this.quantity,
      this.price,
      this.featuredImage,
    });

  CartData.fromJson(Map<String, dynamic> json) {
    id = json['shop_id'];
    title = json['title'];
    quantity = json['quantity'];
    price = double.parse(json['price'].toString());
    featuredImage = json['featured_image'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shop_id'] = this.id;
    data['title'] = this.title;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['featured_image'] = this.featuredImage;

    return data;
  }
}
