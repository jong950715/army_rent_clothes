import 'package:army_rent_clothes/model/product_detail_model.dart';
import 'package:army_rent_clothes/model/product_option_model.dart';
import 'package:flutter/material.dart';

class CartModel {
  List<CartItemModel> cartItems;

  CartModel({required this.cartItems});

  add(CartItemModel newItem) {
    var where =
        cartItems.where((cartItem) => cartItem.product == newItem.product);
    if (where.isNotEmpty) {
      newItem.selectedOptions.forEach((sOp, qty) {
        where.first.selectedOptions[sOp] =
            (where.first.selectedOptions[sOp] ?? 0) + qty;
      });
    } else {
      cartItems.add(newItem);
    }
  }
}

class CartItemModel {
  final ProductDetailModel product;
  final Map<SelectedOption, int> selectedOptions;

  CartItemModel({required this.product, required this.selectedOptions});

  @override
  bool operator ==(o) => o is CartItemModel && o.product == product;

  @override
  String toString() {
    String ret = "";
    ret += "CartItemModel\nproduct: ${product.title}\n";
    selectedOptions.forEach((sOp, qty) {ret += "$sOp: $qty\n";});
    return ret;
  }
}
