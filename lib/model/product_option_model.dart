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
class OptionManager {
  final Map<Sop, int> selectedOptions = {};
  Completer completer = Completer();

  OptionManager();

  // @override
  // bool operator ==(o) => o is Sop && o.toString() == o.toString();
  // @override
  // int get hashCode => toString().hashCode;
  bool get isEmpty => selectedOptions.isEmpty;
  Iterable<MapEntry<Sop, int>> get entries => selectedOptions.entries;

  void qtyAdder(Sop sop, int qty) {
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

  Stream<OptionManager> getStream() async* {
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

  Sop getNewSop() {
    return Sop(optionOrders);
  }

  Map<String, String> getoptionInfo(Sop sop) {
    return optionInfos[getInfoIndex(sop)];
  }

  int getInfoIndex(Sop sop) {
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

class Sop {
  Map<String, String?> selectedOption;
  final List<String> optionOrder;

  Sop(List<String> optionTitles)
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

  Sop deepCopy() {
    Sop ret = Sop(optionOrder);
    ret.selectedOption = Map.from(selectedOption);
    return ret;
  }

  Sop copyWith(String optionTitle, String optionItem) {
    Sop sop = deepCopy();
    sop.setOption[optionTitle] = optionItem;
    return sop;
  }

  //make same data output same hash
  @override
  bool operator ==(o) => o is Sop && o.toString() == o.toString();
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
