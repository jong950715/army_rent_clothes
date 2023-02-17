import 'package:army_rent_clothes/component/item_card_pair.dart';
import 'package:army_rent_clothes/model/home_scroll_content_model.dart';
import 'package:army_rent_clothes/repository/my_repositories.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';


class SliverHomeScrollContent extends StatefulWidget {
  const SliverHomeScrollContent({Key? key}) : super(key: key);

  @override
  State<SliverHomeScrollContent> createState() => _SliverHomeScrollContentState();
}

class _SliverHomeScrollContentState extends State<SliverHomeScrollContent> {
  final PagingController<int, HomeScrollContentModel> _pagingController = PagingController(firstPageKey: 0);
  @override
  void initState() {
    // TODO: implement initState
    //page
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, _pagingController);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey, PagingController _pagingController) async {
    //////////////////////TODO
    try {
      List<HomeScrollContentModel> newHomeScrollContentModels = await HomeScrollContentRepository.fetch(pageKey);
      // List<ItemCardPairModel> pairItems = [ItemCardPairModel(model1: mockItemCardModel, model2: dummyItemCardModel)];

      final isLastPage = newHomeScrollContentModels.length <
          HomeScrollContentRepository.pageSize; // TODO lastPage test 필요
      if (isLastPage) {
        _pagingController.appendLastPage(newHomeScrollContentModels);
      } else {
        _pagingController.appendPage(newHomeScrollContentModels, pageKey + 1);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }


  @override
  Widget build(BuildContext context) {
    return PagedSliverList(
        pagingController:_pagingController,
        builderDelegate: PagedChildBuilderDelegate<HomeScrollContentModel>(
          itemBuilder: (context, item, index) {
            return _SliverHomeScrollContent(model: item,);
          },
        ),
    );
  }
}

class _SliverHomeScrollContent extends StatelessWidget {
  final HomeScrollContentModel model;
  // final String title; // "이제 입기 좋은 니트"
  // final List<ItemCardModel> itemCardModels;

  _SliverHomeScrollContent({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Column(
      children: [
        SizedBox(
          height: 44,
        ),
        if (model.banner != null) model.banner!,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 28),
              Text(model.title,
                  style: _theme.textTheme.titleLarge,
                  textAlign: TextAlign.left),
              ...model.itemCardPairModels
                  .map((pairModel) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: ItemCardPair(pairModel: pairModel),
                      ))
                  .toList(),
            ],
          ),
        ),
      ],
    );
  }
}
