
import 'package:Food_Delivery_App/data/repository/cart_repo.dart';
import 'package:Food_Delivery_App/models/cart_model.dart';
import 'package:Food_Delivery_App/models/products_model.dart';
import 'package:Food_Delivery_App/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  void addItem(Products product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id)) {
      // update the model
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          img: value.img,
          name: value.name,
          price: value.price,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
        );
      });
      // remove the product from the _item if is <= 0
      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        // add item in the model
        _items.putIfAbsent(
          product.id!,
          () {
            print('add Item Id Is ' +
                product.id!.toString() +
                ' and Quantity is ' +
                quantity.toString());
            return CartModel(
              id: product.id,
              name: product.name,
              img: product.img,
              price: product.price,
              time: DateTime.now().toString(),
              quantity: quantity,
              isExist: true,
            );
          },
        );
      } else {
        Get.snackbar(
          'Item Count',
          "You should at least add an item in cart!",
          backgroundColor: AppColors.kPrimaryColor,
          colorText: Colors.white,
        );
      }
    }
  }

//______________________________________________________________________________
  bool existInCart(Products product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }
//______________________________________________________________________________

  int getQuantity(Products product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id!) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }
//______________________________________________________________________________

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }
//______________________________________________________________________________

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }
//______________________________________________________________________________  
}
