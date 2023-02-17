import 'package:army_rent_clothes/component/item_card.dart';
import 'package:army_rent_clothes/model/item_card_model.dart';
import 'package:flutter/material.dart';

//TODO 홀수 입력 가능하게 empty mock card 만들고 채우기
//TODO 범용성 고려해서 ItemCardModel 재구성하기
class ItemCardPair extends StatelessWidget {
  final ItemCardModel model1;
  final ItemCardModel model2;

  /// model1, model2를 넣어줘도 되고
  /// length가 2인 list를 넣어줘도 되고
  /// ItemCardPairModel을 넣어줘도 되고
  ItemCardPair({
    Key? key,
    ItemCardModel? model1,
    ItemCardModel? model2,
    List<ItemCardModel>? twoModels,
    ItemCardPairModel? pairModel,
  })  : assert(twoModels != null || ((model1 != null) && (model2 != null)) || pairModel!=null),
        model1 = model1 ?? (pairModel != null ? pairModel.model1 : twoModels![0]),
        model2 = model2 ?? (pairModel != null ? pairModel.model2 : twoModels![1]),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Expanded(
              child: ItemCard(
            cardModel: model1,
          )),
          const SizedBox(width: 8.0),
          Expanded(
              child: ItemCard(
            cardModel: model2,
          )),
        ],
      ),
    );
  }
}
