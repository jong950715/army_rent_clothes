import 'package:flutter/material.dart';

typedef Adder = void Function(int i);

class QtyAdder extends StatelessWidget {
  final Adder adder;
  final int qty;
  const QtyAdder({Key? key, required this.adder, required this.qty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            adder(1);
          },
          icon: Icon(Icons.add),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
        Text("${qty}"),
        IconButton(
          onPressed: () {
            adder(-1);
          },
          icon: Icon(Icons.remove),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
      ],
    );
  }
}
