import 'package:army_rent_clothes/component/qty_adder.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text("장바구니"),
          ),
          SliverToBoxAdapter(
            child: _CartItemCard(),
          )
        ],
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  const _CartItemCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "히코튼",
              textAlign: TextAlign.start,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.check_box_outlined),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
                Image.asset(
                  "asset/img/item1.jpeg",
                  height: 50,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text("[Set] 믹스 스트라이프 니트 + 레이스ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ", overflow: TextOverflow.ellipsis,)),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.cancel_outlined),
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                          )
                        ],
                      ),
                      Text("옵션 : 믹스 스트라이프 니트 NT371"),
                      QtyAdder(adder: (i) {}, qty: 5)
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
