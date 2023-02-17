import 'package:flutter/material.dart';

class ItemCardModel {
  final Image image;
  final String brand;
  final String content;
  final int originalPrice;
  final int sellingPrice;
  final int discount;

  ItemCardModel({
    required this.image,
    required this.brand,
    required this.content,
    required this.originalPrice,
    required this.sellingPrice,
    discount,
  })  : assert(originalPrice >= sellingPrice),
        discount =
            discount ?? sellingPrice == originalPrice ? 0 :((1 - sellingPrice / originalPrice) * 100).round();
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
                : dummyItemCardModel); //TODO null 이면 dummy 채워야해

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

final ItemCardModel dummyItemCardModel = ItemCardModel(
  image: Image.asset("asset/img/dummySquare.png"),
  brand: "",
  content: "",
  originalPrice: 0,
  sellingPrice: 0,
);
