import 'package:army_rent_clothes/const/category_item.dart';
import 'package:flutter/material.dart';

class SubCategoryCard extends StatelessWidget {
  final CategoryItem category;
  final bool isSelected;
  const SubCategoryCard(
      {Key? key, required this.category, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: Colors.black),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
          child: Text(
            category.korean,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
