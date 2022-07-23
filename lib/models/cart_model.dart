import 'package:Food_Delivery_App/models/products_model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  String? time;
  bool? isExist;
  int? quantity;
  Products? product;

  CartModel({
    this.id,
    this.name,
    this.price,
    this.img,
    this.quantity,
    this.isExist,
    this.time,
    this.product,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    isExist = json['isExist'];
    quantity = json['quantity'];
    time = json['time'];
    product = Products.fromJson(json);
  }
}
