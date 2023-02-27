import 'package:flutter/material.dart';

class ShoppingBag with ChangeNotifier {
  List<int> _productIndices = [];

  List<int> get productIndices => _productIndices;

  void addItem(int index){
    _productIndices.add(index);
    notifyListeners();
  }
}