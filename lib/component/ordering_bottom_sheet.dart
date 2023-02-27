import 'package:army_rent_clothes/model/product_option_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

//
class OrderingBottomSheet extends StatefulWidget {
  const OrderingBottomSheet({Key? key}) : super(key: key);

  @override
  State<OrderingBottomSheet> createState() => _OrderingBottomSheetState();
}

class _OrderingBottomSheetState extends State<OrderingBottomSheet> {
  final ProductOptionModel productOptions =
      ProductOptionModel(mockOptionModels);

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
                SelectedOptionModel? selectedOption =
                    await showModalBottomSheet<SelectedOptionModel>(
                  context: context,
                  builder: (context) => OptionBottomSheet(
                    availableOptions: productOptions.availableOptions,
                  ),
                );

                print(selectedOption.toString());
                if (selectedOption != null) {
                  productOptions.selectedOptionsAndQty[selectedOption] =
                      (productOptions.selectedOptionsAndQty[selectedOption] ??
                              0) +
                          1;
                }
                productOptions.selectedOptionsAndQty.forEach((key, value) {
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
            if (productOptions.selectedOptionsAndQty.isEmpty)
              Text("옵션을 골라주세요."),
            ...productOptions.selectedOptionsAndQty.entries
                .map((e) => _OptionCard(
                      selectedOptionModel: e.key,
                      qty: e.value,
                    ))
                .toList(),
            // _OptionCard(),
          ],
        ),
      ),
    );
  }
}

class OptionBottomSheet extends StatefulWidget {
  final List<OptionModel> availableOptions;
  const OptionBottomSheet({Key? key, required this.availableOptions})
      : super(key: key);

  @override
  State<OptionBottomSheet> createState() => _OptionBottomSheetState();
}

class _OptionBottomSheetState extends State<OptionBottomSheet> {
  late final SelectedOptionModel selectedOptionModel;

  @override
  void initState() {
    super.initState();
    selectedOptionModel = SelectedOptionModel(widget.availableOptions);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("옵션선택"),
          ...selectedOptionModel.productOptions
              .map(
                  (OptionModel optionModel) => DropdownButton2<OptionItemModel>(
                      buttonPadding: EdgeInsets.zero,
                      dropdownPadding: EdgeInsets.zero,
                      dropdownScrollPadding: EdgeInsets.zero,
                      itemPadding: EdgeInsets.zero,
                      dropdownElevation: 0,
                      isExpanded: true,
                      onChanged: (value) {
                        selectedOptionModel.setOption[optionModel] = value!;
                        setState(() {});
                      },
                      hint: Row(
                        children: [
                          Text(optionModel.optionTitle),
                          if (selectedOptionModel.isSelected(optionModel))
                            Icon(Icons.check_outlined),
                        ],
                      ),
                      items: optionModel.optionItems
                          .map((op) => DropdownMenuItem<OptionItemModel>(
                                value: op,
                                child: Text(op.optionName),
                              ))
                          .toList()))
              .toList(),
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
  final SelectedOptionModel selectedOptionModel;
  final int qty;
  const _OptionCard({
    Key? key,
    required this.selectedOptionModel,
    required this.qty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //단가 구하기
    int perPrice = 0;
    selectedOptionModel.selectedOption.forEach((optionModel, optionItemModel) { });

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
                        onPressed: () {},
                        icon: Icon(Icons.add),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                      Text("${qty}"),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.remove),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  Text("${1}원"),
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
