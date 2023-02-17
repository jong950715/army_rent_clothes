import 'package:army_rent_clothes/component/custom_bottom_navigator_bar.dart';
import 'package:army_rent_clothes/const/bottom_tap_item.dart';
import 'package:army_rent_clothes/const/category_item.dart';
import 'package:army_rent_clothes/layout/tap_screen_layout_builder.dart';
import 'package:army_rent_clothes/screen/bottom_tap/category_tap_screen.dart';
import 'package:army_rent_clothes/screen/bottom_tap/cody_tap_screen.dart';
import 'package:army_rent_clothes/screen/bottom_tap/home_tap_screen.dart';
import 'package:army_rent_clothes/screen/bottom_tap/my_tap_screen.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BottomTapItem currentBottomTap = BottomTapItem.values.first;

  @override
  Widget build(BuildContext context) {
    print("=====sandBox=========");
    // print(CategoryItem.runtimeType);
    print(CategoryItem.all.runtimeType);
    return WillPopScope(
      onWillPop: () async {
        //Future<bool> Function()
        bool isFirstRoute = !(await navigatorKeys[currentBottomTap]!
            .currentState!
            .maybePop());
        if (isFirstRoute && currentBottomTap != BottomTapItem.home) {
          setCurrentBottomTap(BottomTapItem.home);
          return false;
        }
        return isFirstRoute;
      },
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Scaffold(
          body: Stack(
            children: [
              HomeTapScreen(currentBottomTap: currentBottomTap),
              CodyTapScreen(currentBottomTap: currentBottomTap),
              CategoryTapScreen(currentBottomTap: currentBottomTap),
              MyTapScreen(currentBottomTap: currentBottomTap),
            ],
          ),
          bottomNavigationBar: CustomBottomNavigatorBar(
              currentBottomTap: currentBottomTap,
              setCurrentBottomTap: setCurrentBottomTap,
              onBottomTap: onBottomTap),
        ),
      ),
    );
  }

  onBottomTap(int index) {
    BottomTapItem newItem =
        BottomTapItem.values.where((e) => e.index == index).first;
    if (currentBottomTap == newItem) {
      navigatorKeys[currentBottomTap]!
          .currentState!
          .popUntil((route) => route.isFirst);
    }
    setCurrentBottomTap(newItem);
  }

  setCurrentBottomTap(BottomTapItem newItem) {
    setState(() {
      currentBottomTap = newItem;
    });
  }
}
