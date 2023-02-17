import 'package:army_rent_clothes/const/bottom_tap_item.dart';
import 'package:army_rent_clothes/screen/bottom_tap/home_tap_screen.dart';
import 'package:flutter/material.dart';

class TapScreenLayoutBuilder extends StatelessWidget {
  final BottomTapItem currentBottomTap;
  final BottomTapItem bottomTapItemOfScreen;
  final WidgetBuilder builder;
  const TapScreenLayoutBuilder({Key? key, required this.currentBottomTap, required this.bottomTapItemOfScreen, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: currentBottomTap != bottomTapItemOfScreen,
      child: Navigator(
        key: navigatorKeys[bottomTapItemOfScreen],
        onGenerateRoute: (settings) => MaterialPageRoute(builder: builder),
      ),
    );
  }
}

Map<BottomTapItem, GlobalKey<NavigatorState>> navigatorKeys = {
  for (BottomTapItem item in BottomTapItem.values) item: GlobalKey<NavigatorState>(),
};