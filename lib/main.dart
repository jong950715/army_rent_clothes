import 'package:army_rent_clothes/const/globals.dart';
import 'package:army_rent_clothes/repository/my_repositories.dart';
import 'package:army_rent_clothes/screen/home_screen.dart';
import 'package:army_rent_clothes/screen/overlay_screen_example.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  globalCart = await CartRepository.fetch();

  runApp(MaterialApp(
    theme: _themeData,
    navigatorKey: mainNavigatorKey,
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
2. subCategory 넣기
3. fetch에 정보 더 넘기기 (category, filter 등)
4. 코디 모델, view 새로 고민하기 (가격 없애고)


minor
1. bottomTap 눌렀을 때 스크롤 맨 위로
2. 적절한 아이콘 찾아 넣기
3. 폰트 정리하기


flutter build apk --release --target-platform=android-arm64
/build/app/outputs/apk/release/app-release.apk
 */
