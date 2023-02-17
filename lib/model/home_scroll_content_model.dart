import 'package:flutter/material.dart';
import 'package:army_rent_clothes/model/item_card_model.dart';

class HomeScrollContentModel {
  final Image? banner;
  final String title;
  final List<ItemCardPairModel> itemCardPairModels;

  HomeScrollContentModel({
    required this.title,
    required this.itemCardPairModels,
    this.banner,
  });
}
