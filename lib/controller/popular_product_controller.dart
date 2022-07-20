import 'package:e_commerce_app/controller/cart_controller.dart';
import 'package:e_commerce_app/models/products_model.dart';
import 'package:e_commerce_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/popular_product_repo.dart';
import '../models/cart_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo productRepo;

  PopularProductController({required this.productRepo});

  List<Products> _popularProductList = [];
  // acsecc the get function any where
  List<Products> get popularProductList => _popularProductList;
  late CartController _cart;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProduct() async {
    Response response = await productRepo.getPopularProductList();

    if (response.statusCode == 200) {
      _popularProductList = [];
      // Data In Model Server response json
      _popularProductList.addAll(ProductModel.fromJson(response.body).products);
      _isLoading = true;
      update();
    } else {}
  }

//______________________________________________________________________________

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

//______________________________________________________________________________
  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        'Item Count',
        "You can't reduce more!",
        backgroundColor: AppColors.kPrimaryColor,
        colorText: Colors.white,
      );
      return 0;
    } else if ((_inCartItems + quantity) > 10) {
      Get.snackbar(
        'Item Count',
        "You can't add more!",
        backgroundColor: AppColors.kPrimaryColor,
        colorText: Colors.white,
      );
      return 10;
    } else {
      return quantity;
    }
  }

  void initProdcut(Products product, CartController cartController) {
    _quantity = 0;
    _inCartItems = 0;
    _quantity = 0;
    _cart = cartController;
    var exist = false;
    exist = _cart.existInCart(product);
    print(' Is Exist ' + exist.toString());
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
      print('The Quantity In The Cart Is  ' + _inCartItems.toString());
    }
  }

  void addItem(Products product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    // Get the getQuantity back
    _inCartItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print('the id is ' +
          value.id.toString() +
          'the quantity is ' +
          value.quantity.toString());
    });
    update();
  }
//______________________________________________________________________________

  int get totalItems {
    return _cart.totalItems;
  }

//______________________________________________________________________________
  List<CartModel> get getItems {
    return _cart.getItems;
  }
//______________________________________________________________________________
}
