import 'package:army_rent_clothes/const/globals.dart';
import 'package:army_rent_clothes/screen/cart_screen.dart';
import 'package:flutter/material.dart';

class SliverHomeAppBar extends StatelessWidget {
  const SliverHomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return SliverAppBar(
      backgroundColor: Colors.white,
      titleTextStyle: _theme.textTheme.titleLarge,
      floating: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text("가즈아")),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: _theme.iconTheme.color,
                    )),
                IconButton(
                    onPressed: () {
                      mainNavigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => CartScreen(),));
                    },
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: _theme.iconTheme.color,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
