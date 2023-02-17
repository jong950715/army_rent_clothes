import 'package:army_rent_clothes/model/item_card_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemCard extends StatelessWidget {
  final ItemCardModel cardModel;
  const ItemCard({Key? key, required this.cardModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formatter = NumberFormat.decimalPattern('en_us');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: cardModel.image,
        ),
        Text(
          cardModel.brand,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
          ),
        ),
        Text(
          cardModel.content,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
          ),
        ),
        Row(
          children: [
            if(cardModel.discount != 0) Text(
              "${cardModel.discount}% ",
              style: TextStyle(
                color: Colors.orangeAccent[400],
                fontWeight: FontWeight.w900,
                fontSize: 16.0,
              ),
            ),
            if(cardModel.sellingPrice != 0) Text(
              "${_formatter.format(cardModel.sellingPrice)} ",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16.0,
              ),
            ),
            if(cardModel.originalPrice != 0) Text(
              "${_formatter.format(cardModel.originalPrice)}",
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
            )
          ],
        )
      ],
    );
  }
}
