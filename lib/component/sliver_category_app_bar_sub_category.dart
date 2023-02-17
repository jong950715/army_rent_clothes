import 'package:army_rent_clothes/component/sub_category_card.dart';
import 'package:army_rent_clothes/const/category_item.dart';
import 'package:flutter/material.dart';

class SliverCategoryAppBarSubCategory extends StatelessWidget {
  final CategoryItem selectedCategory;
  // late final ThemeData _theme;
  const SliverCategoryAppBarSubCategory(
      {Key? key, required this.selectedCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("SliverCategoryAppBar");
    var _theme = Theme.of(context);
    return SliverAppBar(
      toolbarHeight: kToolbarHeight - 15,
      backgroundColor: Colors.white,
      titleTextStyle: _theme.textTheme.bodyMedium,
      floating: true,
      snap: true,
      titleSpacing: 0,
      title: _title(context),
      elevation: 0,
    );
  }

  Widget _title(BuildContext context) {
    var _theme = Theme.of(context);
    return SizedBox(
      height: kToolbarHeight - 15,
      child: Center(
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            ...CategoryItem.values
                .map((category) => Center(
                      child: SubCategoryCard(
                          category: category,
                          isSelected: category == selectedCategory),
                    ))
                .toList(),
            // _categoryButton(title: "전체", isSelected:sel=="전체"),
            // _categoryButton(title: "아우터", isSelected:sel=="아우터"),
          ],
        ),
      ),
    );
  }

  Widget _categoryButton({
    required CategoryItem category,
    required bool isSelected,
  }) {
    return Container(
      padding: const EdgeInsets.all(2),
      width: 100,
      decoration: isSelected
          ? BoxDecoration(
              border: BorderDirectional(bottom: BorderSide(width: 2)),
            )
          : null,
      child: TextButton(
        onPressed: () {},
        child: Text(
          category.korean,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.only(bottom: 8),
        ),
      ),
    );
  }
}
