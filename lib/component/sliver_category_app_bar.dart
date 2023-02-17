import 'package:army_rent_clothes/const/category_item.dart';
import 'package:flutter/material.dart';

class SliverCategoryAppBar extends StatelessWidget {
  final CategoryItem selectedCategory;
  // late final ThemeData _theme;
  const SliverCategoryAppBar({Key? key, required this.selectedCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    return SliverAppBar(
      toolbarHeight: kToolbarHeight-10,
      backgroundColor: Colors.white,
      titleTextStyle: _theme.textTheme.titleLarge,
      floating: true,
      snap: true,
      titleSpacing: 0,
      title: _title(context),
      elevation: 0,
    );
  }

  Widget _title(BuildContext context) {
    var _theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: SizedBox()),
        Expanded(
            child: Text(
          selectedCategory.korean,
          textAlign: TextAlign.center,
        )),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: _theme.iconTheme.color,
                  ),
                padding: EdgeInsets.zero,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: _theme.iconTheme.color,
                ),
                padding: EdgeInsets.zero,

              ),
            ],
          ),
        )
      ],
    );
  }
}
