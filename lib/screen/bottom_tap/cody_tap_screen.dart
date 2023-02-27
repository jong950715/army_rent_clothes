import 'package:army_rent_clothes/const/bottom_tap_item.dart';
import 'package:army_rent_clothes/layout/item_browser_layout.dart';
import 'package:army_rent_clothes/layout/tap_screen_layout_builder.dart';
import 'package:flutter/material.dart';

class CodyTapScreen extends StatelessWidget {
  final BottomTapItem currentBottomTap;
  const CodyTapScreen({Key? key, required this.currentBottomTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ItemBrowserLayout(
      currentBottomTap: currentBottomTap,
      thisBottomTap: BottomTapItem.cody,
    );
  }
}
