import 'package:army_rent_clothes/model/home_scroll_content_model.dart';
import 'package:army_rent_clothes/model/item_card_model.dart';
import 'package:flutter/material.dart';

final ItemCardModel mockItemCardModel = ItemCardModel(
  image: Image.asset("asset/img/carousel1.jpg"),
  brand: "독보남",
  content: "[5000원 쿠폰할인][1+1] 오버핏 개쩌는 셔츠임",
  originalPrice: 34300,
  sellingPrice: 16800,
);

final ItemCardModel mockItemCardModel2 = ItemCardModel(
  image: Image.asset("asset/img/carousel2.jpg"),
  brand: "독보남2",
  content: "[5000원 쿠폰할인][1+1] 오버핏 개쩌는 셔츠임",
  originalPrice: 34300,
  sellingPrice: 16800,
);

final HomeScrollContentModel mockHomeScrollContentModel1 =
    HomeScrollContentModel(
  title: "지금 날씨에 빠질 수 없는 후드티",
  itemCardPairModels: [
    ItemCardPairModel(
      model1: ItemCardModel(
        image: Image.asset("asset/img/carousel1.jpg"),
        brand: "독보남1",
        content: "[5000원 쿠폰할인][1+1] 오버핏 개쩌는 셔츠임",
        originalPrice: 34300,
        sellingPrice: 16800,
      ),
      model2: ItemCardModel(
        image: Image.asset("asset/img/carousel1.jpg"),
        brand: "독보남2",
        content: "[5000원 쿠폰할인][1+1] 오버핏 개쩌는 셔츠임",
        originalPrice: 34300,
        sellingPrice: 16800,
      ),
    ),
    ItemCardPairModel(
      model1: ItemCardModel(
        image: Image.asset("asset/img/carousel1.jpg"),
        brand: "독보남3",
        content: "[5000원 쿠폰할인][1+1] 오버핏 개쩌는 셔츠임",
        originalPrice: 34300,
        sellingPrice: 16800,
      ),
      model2: ItemCardModel(
        image: Image.asset("asset/img/carousel1.jpg"),
        brand: "독보남4",
        content: "[5000원 쿠폰할인][1+1] 오버핏 개쩌는 셔츠임",
        originalPrice: 34300,
        sellingPrice: 16800,
      ),
    ),
    ItemCardPairModel(
      model1: ItemCardModel(
        image: Image.asset("asset/img/carousel1.jpg"),
        brand: "독보남5",
        content: "[5000원 쿠폰할인][1+1] 오버핏 개쩌는 셔츠임",
        originalPrice: 34300,
        sellingPrice: 16800,
      ),
      model2: ItemCardModel(
        image: Image.asset("asset/img/carousel1.jpg"),
        brand: "독보남6",
        content: "[5000원 쿠폰할인][1+1] 오버핏 개쩌는 셔츠임",
        originalPrice: 34300,
        sellingPrice: 16800,
      ),
    ),
  ],
);

final HomeScrollContentModel mockHomeScrollContentModel2 =
    HomeScrollContentModel(
  title: "아무튼 좋은 건데 많이 사줘",
  itemCardPairModels: [1, 2, 3, 4]
      .map((idx) => ItemCardPairModel(
          model1: ItemCardModel(
            image: Image.asset("asset/img/item$idx.jpeg"),
            brand: "브랜드$idx",
            content: "[바겐세일중 얼른 사가라]",
            originalPrice: 100000,
            sellingPrice: 10000,
          ),
          model2: ItemCardModel(
            image: Image.asset("asset/img/item$idx.jpeg"),
            brand: "브랜드$idx",
            content: "[바겐세일중 얼른 사가라]",
            originalPrice: 100000,
            sellingPrice: 10000,
          )))
      .toList(),
  banner: Image.asset("asset/img/banner1.jpg"),
);

final List<HomeScrollContentModel> mockHomeScrollContentModels = [
  mockHomeScrollContentModel1,
  mockHomeScrollContentModel2,
];
