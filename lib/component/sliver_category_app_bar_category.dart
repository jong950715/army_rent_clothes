import 'package:army_rent_clothes/const/browser_tab_item.dart';
import 'package:flutter/material.dart';

const double CATEGORY_BUTTON_SIZE = 100;

class SliverCategoryAppBarCategory extends StatelessWidget {
  final TabController tabController;
  final BrowserTabItem selectedCategory;
  final List<BrowserTabItem> tabs;

  SliverCategoryAppBarCategory({
    Key? key,
    required this.selectedCategory,
    required this.tabController,
    required this.tabs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      title: Column(
        children: [
          TabBar(
            indicatorColor: Colors.black,
            isScrollable: true,
            controller: tabController,
            // These are the widgets to put in each tab in the tab bar.
            tabs: tabs
                .map((BrowserTabItem category) => Tab(
                      child: _categoryButton(
                          category: category,
                          isSelected: category == selectedCategory),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _categoryButton({
    required BrowserTabItem category,
    required bool isSelected,
  }) {
    return Container(
      padding: const EdgeInsets.all(2),
      width: CATEGORY_BUTTON_SIZE,
      // decoration: isSelected
      //     ? BoxDecoration(
      //         border: BorderDirectional(bottom: BorderSide(width: 2)),
      //       )
      //     : null,
      child: Text(
        category.korean,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
