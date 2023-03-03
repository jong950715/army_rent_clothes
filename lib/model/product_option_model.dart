import 'dart:async';
import 'dart:math';

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

//--------------------------//
typedef SetStateType = void Function(VoidCallback fn);
class OptionSelector {
  final Map<SelectedOption, int> selectedOptions = {};
  Completer completer = Completer();

  OptionSelector();

  // @override
  // bool operator ==(o) => o is Sop && o.toString() == o.toString();
  // @override
  // int get hashCode => toString().hashCode;
  bool get isEmpty => selectedOptions.isEmpty;
  Iterable<MapEntry<SelectedOption, int>> get entries => selectedOptions.entries;

  void qtyAdder(SelectedOption sop, int qty) {
    selectedOptions[sop] = (selectedOptions[sop] ?? 0) + qty;
    selectedOptions[sop] = max<int>(selectedOptions[sop]!, 1);
    completer.complete();
  }

  @override
  String toString() {
    String ret = "";
    selectedOptions.forEach((key, value) {
      ret += "옵션 : ${key}, 개수 : ${value}";
    });
    return ret;
  }

  //Statefull widget 대신에 streambuilder를 쓰면 재rendering 범위를 최소화 할 수 있음.
  Stream<OptionSelector> getStream() async* {
    while(true){
      await completer.future;
      completer = Completer();
      yield this;
    }
  }
}

class ProductOptionModel {
  final List<String> optionOrders; // list of OptionTitle
  final Map<String, List<String>> availableOptions; // optionTitle: options
  final int basePrice;
  final List<Map<String, String>> optionInfos;
  ProductOptionModel(
      {required this.availableOptions,
      required this.optionInfos,
      required this.basePrice})
      : optionOrders = availableOptions.keys.toList();

  SelectedOption getNewSop() {
    return SelectedOption(optionOrders);
  }

  Map<String, String> getoptionInfo(SelectedOption sop) {
    return optionInfos[getInfoIndex(sop)];
  }

  int getInfoIndex(SelectedOption sop) {
    sop.selectedOption.values.forEach((e) {
      if (e == null) {
        throw Exception("다 채워서 보내라잉");
      }
    }); //unreachable
    int ret = 0;
    int magnitude = 1;
    for (final optionTitle in optionOrders.reversed) {
      int? index = availableOptions[optionTitle]
          ?.indexOf(sop.selectedOption[optionTitle]!);
      ret += index! * magnitude;
      magnitude *= availableOptions[optionTitle]!.length;
      // sop.selectedOption[optionTitle]
    }
    return ret;
  }
}

class SelectedOption {
  //TODO Map<int, int?>로 변경해야 할 수도 (서버의 성능문제)
  Map<String, String?> selectedOption; //optionTitle(color) : optionItem(red)
  final List<String> optionOrder;

  SelectedOption(List<String> optionTitles)
      : selectedOption = {
          for (var optionTitle in optionTitles) optionTitle: null
        },
        optionOrder = optionTitles;

  Map<String, String?> get setOption => selectedOption;

  bool isSelected(String option) {
    return selectedOption[option] != null;
  }

  bool isFinished() {
    bool ret = true;
    selectedOption.forEach((key, value) {
      ret = value == null ? false : ret;
    });
    return ret;
  }

  @override
  String toString() {
    String ret = "";
    optionOrder.asMap().forEach((index, e) {
      ret += index + 1 == optionOrder.length
          ? "${selectedOption[e]}"
          : "${selectedOption[e]} / ";
    });
    return ret;
  }

  String? getByIndex(int index) {
    return selectedOption[optionOrder[index]];
  }

  SelectedOption deepCopy() {
    SelectedOption ret = SelectedOption(optionOrder);
    ret.selectedOption = Map.from(selectedOption);
    return ret;
  }

  SelectedOption copyWith(String optionTitle, String optionItem) {
    SelectedOption sop = deepCopy();
    sop.setOption[optionTitle] = optionItem;
    return sop;
  }

  //make same data output same hash
  @override
  bool operator ==(o) => o is SelectedOption && o.toString() == toString();
  @override
  int get hashCode => toString().hashCode;
}

ProductOptionModel mockProductOptionModel = ProductOptionModel(
  availableOptions: {
    "color": ["Yellow", "Red"],
    "size": ["XL", "M"],
    "etc": ["a", "b"]
  },
  basePrice: 10000,
  optionInfos: [
    {
      "qty": "1",
      "price": "1000",
    },
    {
      "qty": "2",
      "price": "1000",
    },
    {
      "qty": "3",
      "price": "1000",
    },
    {
      "qty": "4",
      "price": "1000",
    },
    {
      "qty": "5",
      "price": "1000",
    },
    {
      "qty": "0",
      "price": "1000",
    },
    {
      "qty": "7",
      "price": "1000",
    },
    {
      "qty": "8",
      "price": "1000",
    },
  ],
);
