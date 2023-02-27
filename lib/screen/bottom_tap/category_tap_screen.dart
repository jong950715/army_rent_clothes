import 'package:army_rent_clothes/component/item_card_pair.dart';
import 'package:army_rent_clothes/component/sliver_category_app_bar.dart';
import 'package:army_rent_clothes/component/sliver_category_app_bar_category.dart';
import 'package:army_rent_clothes/const/bottom_tap_item.dart';
import 'package:army_rent_clothes/const/category_item.dart';
import 'package:army_rent_clothes/layout/item_browser_layout.dart';
import 'package:army_rent_clothes/layout/tap_screen_layout_builder.dart';
import 'package:army_rent_clothes/model/item_card_model.dart';
import 'package:army_rent_clothes/repository/my_repositories.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CategoryTapScreen extends StatelessWidget {
  final BottomTapItem currentBottomTap;
  const CategoryTapScreen({Key? key, required this.currentBottomTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ItemBrowserLayout(
      currentBottomTap: currentBottomTap,
      thisBottomTap: BottomTapItem.category,
    );
  }
}
