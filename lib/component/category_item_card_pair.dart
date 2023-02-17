import 'package:army_rent_clothes/component/item_card_pair.dart';
import 'package:army_rent_clothes/const/_mocks.dart';
import 'package:army_rent_clothes/const/category_item.dart';
import 'package:flutter/material.dart';

class CategoryItemCardPair extends StatelessWidget {
  final CategoryItem selectedCategory;
  final int index;
  const CategoryItemCardPair({
    Key? key,
    required this.selectedCategory,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(selectedCategory.index%3){
      case 0:
        return ItemCardPair(
            model1: mockItemCardModel, model2: mockItemCardModel);
      case 1:
        return ItemCardPair(
            model1: mockItemCardModel2, model2: mockItemCardModel2);
      default:
        return ItemCardPair(
            model1: mockItemCardModel, model2: mockItemCardModel2);
    }
  }
}
