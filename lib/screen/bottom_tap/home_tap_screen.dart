import 'package:army_rent_clothes/component/item_card.dart';
import 'package:army_rent_clothes/component/sliver_home_app_bar.dart';
import 'package:army_rent_clothes/component/sliver_home_scroll_content.dart';
import 'package:army_rent_clothes/const/_mocks.dart';
import 'package:army_rent_clothes/const/bottom_tap_item.dart';
import 'package:army_rent_clothes/layout/tap_screen_layout.dart';
import 'package:army_rent_clothes/layout/tap_screen_layout_builder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../component/sliver_home_carousel.dart';

class HomeTapScreen extends StatelessWidget {
  final BottomTapItem currentBottomTap;
  const HomeTapScreen({Key? key, required this.currentBottomTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return TapScreenLayoutBuilder(
      currentBottomTap: currentBottomTap,
      bottomTapItemOfScreen: BottomTapItem.home,
      builder: (BuildContext context) => CustomScrollView(
        slivers: [
          SliverHomeAppBar(),
          SliverHomeCarousel(),
          // SliverHomeScrollContent(model: mockHomeScrollContentModel1),
          SliverHomeScrollContent(),
          // ...mockHomeScrollContentModels.map((model) => SliverHomeScrollContent(model:model)).toList(),
        ],
      ),
    );
  }
}

class HomeTapScreen_ extends StatelessWidget {
  final BottomTapItem currentBottomTap;
  const HomeTapScreen_({Key? key, required this.currentBottomTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return TapScreenLayoutBuilder(
      currentBottomTap: currentBottomTap,
      bottomTapItemOfScreen: BottomTapItem.home,
      builder: (BuildContext context) => CustomScrollView(
        slivers: [
          SliverHomeAppBar(),
          SliverHomeCarousel(),
          // SliverHomeScrollContent(model: mockHomeScrollContentModel1),
          SliverHomeScrollContent(),
          // ...mockHomeScrollContentModels.map((model) => SliverHomeScrollContent(model:model)).toList(),
        ],
      ),
    );
  }
}
