import 'package:army_rent_clothes/component/item_card_pair.dart';
import 'package:army_rent_clothes/component/sliver_category_app_bar.dart';
import 'package:army_rent_clothes/component/sliver_category_app_bar_category.dart';
import 'package:army_rent_clothes/const/bottom_tap_item.dart';
import 'package:army_rent_clothes/const/category_item.dart';
import 'package:army_rent_clothes/layout/tap_screen_layout_builder.dart';
import 'package:army_rent_clothes/model/item_card_model.dart';
import 'package:army_rent_clothes/repository/my_repositories.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CategoryTapScreen extends StatefulWidget {
  final BottomTapItem currentBottomTap;

  const CategoryTapScreen({Key? key, required this.currentBottomTap})
      : super(key: key);

  @override
  State<CategoryTapScreen> createState() => _CategoryTapScreenState();
}

/*
mainCategoryItems<> 제너릭
subCategoryItems -> 맵
_fetch

 */
class _CategoryTapScreenState extends State<CategoryTapScreen>
    with TickerProviderStateMixin {
  //controllers
  late final ScrollController _scrollController;
  late final TabController _tabController;
  final Map<CategoryItem, PagingController<int, ItemCardPairModel>>
      _pagingControllers = {
    for (CategoryItem category in CategoryItem.values)
      category: PagingController(firstPageKey: 0)
  };

  //category tabs
  final List<CategoryItem> tabs = CategoryItem.values.toList();

  CategoryItem selectedCategory = CategoryItem.values.first;

  @override
  void initState() {
    super.initState();
    initPagingController();
    initTabController();
    initScrollController();
  }

  Future<void> _fetchPage(
      int pageKey, PagingController _pagingController) async {
    try {
      List<ItemCardModel> newCardModels = await ItemRepository.fetch(pageKey);
      List<ItemCardPairModel> pairItems =
          ItemCardPairModel.pairItemsFromItems(newCardModels);

      if (newCardModels.length < ItemRepository.pageSize) {
        _pagingController.appendLastPage(pairItems);
      } else {
        _pagingController.appendPage(pairItems, pageKey + 1);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    final overLapHandle1 = SliverOverlapAbsorberHandle();
    final overLapHandle2 = SliverOverlapAbsorberHandle();

    return TapScreenLayoutBuilder(
      //TODO BottomTap을 enum으로 만들고 위에서 싹 묶어서 정리 (enum.values), child만 따로 넣기 => builder 패턴이라서 조심해야 할듯 / 굳이 안해도됨
      currentBottomTap: widget.currentBottomTap,
      bottomTapItemOfScreen: BottomTapItem.category,
      builder: (BuildContext context) => NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: overLapHandle1,
              sliver: SliverCategoryAppBar(selectedCategory: selectedCategory),
            ),
            SliverOverlapAbsorber(
              handle: overLapHandle2,
              sliver: SliverCategoryAppBarCategory(
                  selectedCategory: selectedCategory,
                  tabController: _tabController),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          // These are the contents of the tab views, below the tabs.
          children: tabs.map((CategoryItem category) {
            return CustomScrollView(
              key: PageStorageKey<CategoryItem>(category),
              slivers: <Widget>[
                SliverOverlapInjector(handle: overLapHandle1),
                SliverOverlapInjector(handle: overLapHandle2),
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: PagedSliverList(
                    pagingController: _pagingControllers[category]!,
                    builderDelegate:
                        PagedChildBuilderDelegate<ItemCardPairModel>(
                      itemBuilder: (context, item, index) {
                        return ItemCardPair(
                            model1: item.model1, model2: item.model2);
                      },
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  initTabController() {
    // tab
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      print("current page index is ${_tabController.index}");
      setCategory(tabs[_tabController.index]);
    });
  }

  initPagingController() {
    _pagingControllers.values.forEach(_initPagingController);
  }

  _initPagingController(PagingController pagingController) {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, pagingController);
    });
  }

  initScrollController() {
    // scroll
    _scrollController = ScrollController();
    _scrollController.addListener(() {});
  }

  setCategory(CategoryItem newCategory) {
    setState(() {
      selectedCategory = newCategory;
    });
  }
}

//TODO
/*
TODO
글자 글꼴 등 Theme 배급되는 라인 쭉 점검
Appbar 높이, 간격 조절
* */
