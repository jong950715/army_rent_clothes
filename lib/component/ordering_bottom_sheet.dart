import 'dart:math';

import 'package:army_rent_clothes/model/product_option_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

//TODO 옵션이 참 어렵네
/**
 * 고르는건 종류별로 골라야 하지만
 * 옵션가, 재고 관리는 합체된 옵션별로 관리가 되어야함...
 */
class OrderingBottomSheet extends StatefulWidget {
  const OrderingBottomSheet({Key? key}) : super(key: key);

  @override
  State<OrderingBottomSheet> createState() => _OrderingBottomSheetState();
}

class _OrderingBottomSheetState extends State<OrderingBottomSheet> {
  final Pop productOptions = mockProductOptionModel;
  final Map<Sop, int> selectedOptions = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 400,
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                Sop? selectedOption = await showModalBottomSheet<Sop>(
                  context: context,
                  builder: (context) =>
                      OptionBottomSheet(productOption: productOptions),
                );

                print(selectedOption.toString());
                if (selectedOption != null) {
                  selectedOptions[selectedOption] =
                      (selectedOptions[selectedOption] ?? 0) + 1;
                }
                selectedOptions.forEach((key, value) {
                  print("옵션 : ${key}, 개수 : ${value}");
                });
                setState(() {});
              },
              child: Row(
                children: [
                  Text(
                    "옵션",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Icon(Icons.keyboard_arrow_down_outlined)
                ],
              ),
            ),
            if (selectedOptions.isEmpty) Text("옵션을 골라주세요."),
            ...selectedOptions.entries
                .map((e) => _OptionCard(
                      selectedOptionModel: e.key,
                      qty: e.value,
                      qtyAdder: qtyAdder,
                      optionInfo: productOptions.getoptionInfo(e.key),
                      basePrice: productOptions.basePrice,
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }

  void qtyAdder(Sop sop, int qty) {
    selectedOptions[sop] = (selectedOptions[sop] ?? 0) + qty;
    selectedOptions[sop] = max<int>(selectedOptions[sop]!, 1);
    setState(() {});
  }
}

class OptionBottomSheet extends StatefulWidget {
  final Pop productOption;
  const OptionBottomSheet({Key? key, required this.productOption})
      : super(key: key);

  @override
  State<OptionBottomSheet> createState() => _OptionBottomSheetState();
}

class _OptionBottomSheetState extends State<OptionBottomSheet> {
  late final Sop selectedOptionModel;

  @override
  void initState() {
    super.initState();
    selectedOptionModel = widget.productOption.getNewSop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("옵션선택"),
          ...widget.productOption.optionOrders.asMap().entries.map((e) {
            int index = e.key;
            String optionTitle = e.value;
            List<String> optionItems =
                widget.productOption.availableOptions[optionTitle]!;
            //option Title에 따라 순차적으로 고르게 disable하는 로직
            bool able =
                index == 0 || selectedOptionModel.getByIndex(index - 1) != null;

            List<DropdownMenuItem<String>> items = able
                ? optionItems.map((optionItem) {
                    //각 optionItem의 재고와 가격 로직 (마지막 index가 마지막 optiontitle이라고 가정가능)
                    bool isLast =
                        index == widget.productOption.optionOrders.length - 1;
                    Map<String, String>? optionInfo = isLast
                        ? widget.productOption.getoptionInfo(selectedOptionModel
                            .copyWith(optionTitle, optionItem))
                        : null;
                    bool soldout =
                        isLast ? int.parse(optionInfo!["qty"]!) == 0 : false;
                    TextStyle textStyle = TextStyle(
                      color: soldout ? Colors.grey : null,
                    );
                    return DropdownMenuItem<String>(
                      enabled: !soldout,
                      value: optionItem,
                      child: isLast
                          ? Text(
                              "${optionItem} ${optionInfo!["price"]}원 ${soldout ? " (품절)" : ""}",
                              style: textStyle,
                            )
                          : Text(
                              "${optionItem} ${soldout ? " (품절)" : ""}",
                              style: textStyle,
                            ),
                    );
                  }).toList()
                : [];
            return DropdownButton2<String>(
                buttonPadding: EdgeInsets.zero,
                dropdownPadding: EdgeInsets.zero,
                dropdownScrollPadding: EdgeInsets.zero,
                itemPadding: EdgeInsets.zero,
                dropdownElevation: 0,
                isExpanded: true,
                onChanged: (value) {
                  selectedOptionModel.setOption[optionTitle] = value!;
                  setState(() {});
                },
                hint: Row(
                  children: [
                    Text(optionTitle),
                    if (selectedOptionModel.isSelected(optionTitle))
                      Icon(Icons.check_outlined),
                  ],
                ),
                items: items);
          }).toList(),
          Expanded(child: SizedBox()),
          OutlinedButton(
            onPressed: () {
              if (selectedOptionModel.isFinished()) {
                Navigator.of(context).pop(selectedOptionModel);
              }
            },
            child: Text(
              "완료",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final Sop selectedOptionModel;
  final int qty;
  final int basePrice;
  final Map<String, String> optionInfo;
  final Function qtyAdder;
  const _OptionCard({
    Key? key,
    required this.selectedOptionModel,
    required this.qty,
    required this.qtyAdder,
    required this.basePrice,
    required this.optionInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //단가 구하기
    int perPrice = 0;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${selectedOptionModel.toString()}",
                  textAlign: TextAlign.left),
              Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          qtyAdder(selectedOptionModel, 1);
                        },
                        icon: Icon(Icons.add),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                      Text("${qty}"),
                      IconButton(
                        onPressed: () {
                          qtyAdder(selectedOptionModel, -1);
                        },
                        icon: Icon(Icons.remove),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  Text("${(basePrice + int.parse(optionInfo['price']!))*qty }원"),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.cancel_outlined),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
