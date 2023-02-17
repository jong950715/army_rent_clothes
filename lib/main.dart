import 'package:army_rent_clothes/screen/home_screen.dart';
import 'package:army_rent_clothes/screen/overlay_screen_example.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: _themeData,
    home: const HomeScreen(),
  ));
}

final _themeData = ThemeData(
  primaryColor: Colors.white,
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w900,
    ),
// bodyText1: TextStyle(),
// bodyText2: TextStyle(),
  ),
);

/*
TODO
major
1. 아이템 상세페이지
2. 코디 넣기
2-1. 코디-카테고리 통합하기


minor
1. bottomTap 눌렀을 때 스크롤 맨 위로
2. 적절한 아이콘 찾아 넣기
3. 폰트 정리하기

 */