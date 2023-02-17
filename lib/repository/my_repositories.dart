import 'package:army_rent_clothes/model/home_scroll_content_model.dart';
import 'package:flutter/material.dart';
import 'package:army_rent_clothes/model/item_card_model.dart';
import 'package:army_rent_clothes/const/_mocks.dart';
import 'dart:math';

class ItemRepository {
  /*
  #parameter
    int pageSize
    int pageNum
    enum category
    ??? filter

  #return
    Image image;
    String brand;
    String content;
    int originalPrice;
    int sellingPrice;
    int discount;
   */

  static const int pageSize = 6;
  static Future<List<ItemCardModel>> fetch(int pageNum) async {
    //pagenagtion
    /*
    per page
    page num
    category
    filter
     */
    await Future.delayed(const Duration(seconds: 5));

    // return Random().nextBool() ? [mockItemCardModel] : [mockItemCardModel2];
    return List.generate(
            pageSize,
            (index) =>
                Random().nextBool() ? mockItemCardModel : mockItemCardModel2)
        .toList();
  }
}

class HomeCarouselRepository {
  /*
  #parameter
    없음
  #reponse
    List of ImagePath
   */
  static Future<List<Image>> fetch() async {
    await Future.delayed(const Duration(seconds: 5));
    return [1, 2, 3, 4, 5, 6]
        .map((i) => Image.asset("asset/img/carousel$i.jpg"))
        .toList();
  }
}

class HomeScrollContentRepository {
  /*
  #parameter
    int pageSize
    int pageNum

  #response
    Image? banner;
    String title;
    List<ItemCardPairModel> itemCardPairModels;
   */
  static const int pageSize = 1;
  static Future<List<HomeScrollContentModel>> fetch(int pageNum) async {
    await Future.delayed(const Duration(seconds: 5));
    return List.generate(
        pageSize,
        (index) => Random().nextBool()
            ? mockHomeScrollContentModel1
            : mockHomeScrollContentModel2)
        .toList();
  }
}
