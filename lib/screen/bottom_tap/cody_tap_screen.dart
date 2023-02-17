import 'package:army_rent_clothes/const/bottom_tap_item.dart';
import 'package:army_rent_clothes/layout/tap_screen_layout_builder.dart';
import 'package:flutter/material.dart';

class CodyTapScreen extends StatelessWidget {
  final BottomTapItem currentBottomTap;
  const CodyTapScreen({Key? key, required this.currentBottomTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TapScreenLayoutBuilder(
      currentBottomTap: currentBottomTap,
      bottomTapItemOfScreen: BottomTapItem.cody,
      builder: (BuildContext context) => Column(
        children: [
          Center(child: RollDeep(depth: 1,),),
          Image.asset("asset/img/carousel1.jpg", width: 100, height: 100),
        ],
      ),
    );
  }
}

class RollDeep extends StatelessWidget {
  final int depth;
  const RollDeep({Key? key, required this.depth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Here is ${depth}"),
        ElevatedButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => RollDeep(depth: depth+1),));}, child: Text("Go to ${depth+1}")),
        ElevatedButton(onPressed: (){Navigator.of(context).pop();}, child: Text("Back to ${depth-1}")),
      ],
    );
  }
}

