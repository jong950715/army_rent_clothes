import 'package:flutter/material.dart';
import 'package:army_rent_clothes/model/brand_model.dart';

class ItemCardModel {
  final int index;
  final Image thumbNail;
  final BrandModel brand;
  final String title;
  final int originalPrice;
  final int sellingPrice;
  final int discount;

  ItemCardModel({
    required this.index,
    required this.thumbNail,
    required this.brand,
    required this.title,
    required this.originalPrice,
    required this.sellingPrice,
    discount,
  })  : assert(originalPrice >= sellingPrice),
        discount = discount ?? sellingPrice == originalPrice
            ? 0
            : ((1 - sellingPrice / originalPrice) * 100).round();
}

class ItemCardPairModel {
  final ItemCardModel model1;
  final ItemCardModel model2;

  ItemCardPairModel({
    ItemCardModel? model1,
    ItemCardModel? model2,
    List<ItemCardModel>? twoModels,
  })  : assert(twoModels != null || ((model1 != null))),
        model1 = model1 ?? twoModels![0],
        model2 = model2 ??
            (twoModels!.length > 1
                ? twoModels[1]
                : blankItemCardModel);

  static List<ItemCardPairModel> pairItemsFromItems(
      List<ItemCardModel> models) {
    List<List<ItemCardModel>> me = [];
    models.asMap().forEach((index, model) {
      if (index % 2 == 0) {
        me.add([model]);
      } else {
        me.last.add(model);
      }
    });
    return me
        .map((List<ItemCardModel> e) => ItemCardPairModel(twoModels: e))
        .toList();
    // return <ItemCardPairModel>[];
  }
}

final ItemCardModel blankItemCardModel = ItemCardModel(
  index: 0,
  thumbNail: Image.asset("asset/img/dummySquare.png"),
  brand: BrandModel("", Image.asset("asset/img/dummySquare.png")),
  title: "",
  originalPrice: 0,
  sellingPrice: 0,
);
