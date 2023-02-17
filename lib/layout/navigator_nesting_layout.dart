import 'package:flutter/material.dart';

class NavigatorNestingLayout extends StatelessWidget {
  final bool offstage;
  final GlobalKey<NavigatorState> navigatorKey;
  final WidgetBuilder builder;

  const NavigatorNestingLayout({
    Key? key,
    required this.offstage,
    required this.navigatorKey,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: offstage,
      child: Navigator(
        key: navigatorKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: builder,
        ),
      ),
    );
  }
}
