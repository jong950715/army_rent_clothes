import 'package:flutter/material.dart';
import 'package:quiver/collection.dart';

// typedef ProductOptionModel = Map<String, OptionModel>;
// class ProductOptionModel extends DelegatingMap<String, OptionModel> {
//   Map<String, OptionModel> _data;
//
//   ProductOptionModel(Map<String, OptionModel> data) : _data = data;
//
//   @override
//   Map<String, OptionModel> get delegate => _data;
// }


//TODO stock 0이면 못고르게 (회색이나 취소선)

//옵션 관리
class ProductOptionModel {
  final List<OptionModel> availableOptions; // 고를 수 있는 옵션 종류
  Map<SelectedOptionModel, int> selectedOptionsAndQty;

  ProductOptionModel(this.availableOptions)
      : selectedOptionsAndQty = {};
}

//선택한 옵션 ex) color: red
class SelectedOptionModel {
  final List<OptionModel> productOptions; // 고를 수 있는 옵션 종류
  Map<OptionModel, OptionItemModel?> selectedOption;

  Map<OptionModel, OptionItemModel?> get setOption => selectedOption;

  SelectedOptionModel(this.productOptions)
      : selectedOption = {for (OptionModel e in productOptions) e: null};

  bool operator ==(o) => o is SelectedOptionModel && o.toString() == o.toString();
  int get hashCode => this.toString().hashCode;

  bool isFinished() {
    bool ret = true;
    selectedOption.forEach((key, value) {
      ret = value == null ? false : ret;
    });
    return ret;
  }

  bool isSelected(OptionModel option){
    return selectedOption[option] != null;
  }

  @override
  String toString() {
    String ret = "";
    // productOptions.forEach((e) {ret += e.optionTitle;});
    productOptions.asMap().forEach((index, e) {
      ret += index + 1 == productOptions.length
          ? "${selectedOption[e]?.optionName}"
          : "${selectedOption[e]?.optionName} / ";
    });
    return ret;
  }
}

//옵션모델 ex) color, [red, blue ...]
class OptionModel {
  final String optionTitle;
  final List<OptionItemModel> optionItems;

  OptionModel({required this.optionTitle, required this.optionItems});
}

//옵션아이템 ex) XL, red
class OptionItemModel {
  final String optionName;
  final int price;
  final int stock;

  OptionItemModel(
      {required this.optionName, required this.price, required this.stock});
}


// mocks //
OptionModel mockOptionModelSize = OptionModel(
  optionTitle: "사이즈",
  optionItems: [
    OptionItemModel(optionName: "S", price: 0, stock: 3),
    OptionItemModel(optionName: "M", price: 0, stock: 3),
    OptionItemModel(optionName: "L", price: 0, stock: 3),
    OptionItemModel(optionName: "XL", price: 0, stock: 3),
  ],
);

OptionModel mockOptionModelColor = OptionModel(
  optionTitle: "색상",
  optionItems: [
    OptionItemModel(optionName: "검정색", price: 0, stock: 3),
    OptionItemModel(optionName: "흰색", price: 0, stock: 3),
    OptionItemModel(optionName: "빨간색", price: 0, stock: 3),
    OptionItemModel(optionName: "노란색", price: 0, stock: 3),
  ],
);

List<OptionModel> mockOptionModels = [
  mockOptionModelSize,
  mockOptionModelColor
];
