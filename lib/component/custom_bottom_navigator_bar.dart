import 'package:army_rent_clothes/const/bottom_tap_item.dart';
import 'package:army_rent_clothes/layout/tap_screen_layout_builder.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigatorBar extends StatelessWidget {
  final BottomTapItem currentBottomTap;
  final ValueChanged<int> onBottomTap;
  final Function setCurrentBottomTap;
  const CustomBottomNavigatorBar({Key? key, required this.currentBottomTap, required this.onBottomTap, required this.setCurrentBottomTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      iconSize: 30,
      selectedFontSize: 16,
      currentIndex: BottomTapItem.values
          .where((e) => e == currentBottomTap)
          .first
          .index,
      onTap: (int index){
        BottomTapItem newItem =
            BottomTapItem.values.where((e) => e.index == index).first;
        if(currentBottomTap == newItem){
          //현재 탭을 탭하면 첫페이지로
          navigatorKeys[currentBottomTap]!.currentState!.popUntil((route) => route.isFirst);
        }
        setCurrentBottomTap(newItem);
      },
      items: [
        _bottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
        _bottomNavigationBarItem(icon: Icon(Icons.filter_none), label: '코디'),
        _bottomNavigationBarItem(
            icon: Icon(Icons.menu_outlined), label: '카테고리'),
        _bottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: '내 정보'),
      ],
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      {required Icon icon, String label = ''}) {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
      backgroundColor: Colors.black,
    );
  }
}
