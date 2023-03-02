import 'package:army_rent_clothes/component/ordering_bottom_sheet.dart';
import 'package:army_rent_clothes/component/page_view_dot.dart';
import 'package:army_rent_clothes/const/_mocks.dart';
import 'package:army_rent_clothes/const/globals.dart';
import 'package:army_rent_clothes/model/item_card_model.dart';
import 'package:army_rent_clothes/model/product_detail_model.dart';
import 'package:army_rent_clothes/model/product_option_model.dart';
import 'package:army_rent_clothes/repository/my_repositories.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

//TODO ItemCardModel로 부터 있는건 로딩간에 렌더링 해놓기
class ProductDetail extends StatefulWidget {
  final int productIndex;
  const ProductDetail({Key? key, required this.productIndex}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with TickerProviderStateMixin {
  final ProductOptionModel productOptions = mockProductOptionModel;
  final OptionManager selectedOptions = OptionManager();
  bool isSelectedOptions = false;
  late final TabController _tabController;
  late final List<ItemDetailTab> tabs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabs = ItemDetailTab.values.toList();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    if (isSelectedOptions == false) { //TODO make pretty
      isSelectedOptions = true;
    }
    final overLapHandle1 = SliverOverlapAbsorberHandle();
    return Scaffold(
      body: FutureBuilder<ProductDetailModel>(
          future: ProductDetailRepository.fetch(widget.productIndex),
          builder: (context, snapshot) {
            ProductDetailModel? model = snapshot.data;
            return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    _SliverAppBar(),
                    _SliverThumbnail(model: model),
                    SliverItemDetailOverview(model: model),
                    _SliverPersistentTabBar(tabController: _tabController),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    ProductTab(model: model),
                    ReviewTab(),
                    QnaTab(),
                    InfoTab(),
                  ],
                )
                // SliverOverlapInjector(handle: overLapHandle1),
                );
          }),
      bottomNavigationBar: _Bottom(
          productOptions: productOptions, selectedOptions: selectedOptions),
    );
  }
}

class _SliverAppBar extends StatelessWidget {
  const _SliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back_ios),
        padding: EdgeInsets.zero,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            padding: EdgeInsets.zero,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart_outlined),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}

class _SliverThumbnail extends StatelessWidget {
  final ProductDetailModel? model;
  const _SliverThumbnail({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      // thumnail
      child: Column(
        children: [
          PageViewDot(
            children: model?.itemImages ??
                [const Center(child: CircularProgressIndicator())],
          ),
        ],
      ),
    );
  }
}

class _SliverPersistentTabBar extends StatelessWidget {
  final TabController tabController;
  const _SliverPersistentTabBar({Key? key, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: TabBarDelegate(tabController: tabController),
      pinned: true,
    );
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabController;

  TabBarDelegate({required this.tabController});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      height: kToolbarHeight,
      child: TabBar(
        indicatorColor: Colors.black,
        // isScrollable: true,
        controller: tabController,
        // These are the widgets to put in each tab in the tab bar.
        // tabs: tabs
        //     .map((BrowserTabItem category) => Tab(
        //   child: _categoryButton(
        //       category: category,
        //       isSelected: category == selectedCategory),
        // )).toList(),
        tabs: ItemDetailTab.values
            .map((ItemDetailTab tab) => Tab(
                child: _categoryButton(isSelected: false, title: tab.korean)))
            .toList(),
      ),
    );
  }

  @override
  double get maxExtent => kToolbarHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  Widget _categoryButton({
    required String title,
    required bool isSelected,
  }) {
    return Container(
      padding: const EdgeInsets.all(2),
      width: 80,
      // decoration: isSelected
      //     ? BoxDecoration(
      //         border: BorderDirectional(bottom: BorderSide(width: 2)),
      //       )
      //     : null,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class SliverItemDetailOverview extends StatelessWidget {
  final ProductDetailModel? model;
  const SliverItemDetailOverview({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formatter = NumberFormat.decimalPattern('en_us');

    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: model?.brand.thumbNail.image ??
                          Image.asset("asset/img/dummySquare.png").image,
                      // Image.asset("asset/img/carousel1.jpg").image,
                    ),
                    SizedBox(width: 6),
                    Text(
                      model?.brand.name ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                    // Text("마인드핏")
                  ],
                ),
                Text(
                  model?.title ?? "",
                  // overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                ),
                // Text("[데일리룩] 오버핏 데일리 투웨이 바시티 니트 하이넥 집업 자켓"),
                Row(
                  children: [
                    if (model?.discount != 0)
                      Text(
                        "${model?.discount ?? 0}% ",
                        style: TextStyle(
                          color: Colors.orangeAccent[400],
                          fontWeight: FontWeight.w900,
                          fontSize: 16.0,
                        ),
                      ),
                    if (model?.sellingPrice != 0)
                      Text(
                        "${_formatter.format(model?.sellingPrice ?? 0)} ",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16.0,
                        ),
                      ),
                    if (model?.originalPrice != 0)
                      Text(
                        "${_formatter.format(model?.originalPrice ?? 0)}",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.symmetric(
                    horizontal:
                        BorderSide(width: 0.3, color: Colors.grey[500]!))),
          )
        ],
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  final ProductOptionModel productOptions;
  final OptionManager selectedOptions;
  const _Bottom(
      {Key? key, required this.productOptions, required this.selectedOptions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]!, width: 1.5)),
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]!, width: 1.5)),
              width: 42,
              child: Center(
                child: IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  onPressed: () {},
                  color: Colors.grey[400]!,
                  icon: Icon(Icons.favorite_border_outlined),
                ),
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return OrderingBottomSheet(
                      productOptions: productOptions,
                      selectedOptions: selectedOptions);
                },
              ),
              child: Container(
                color: Colors.grey[900],
                child: Center(
                  child: Text(
                    "예약하기",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class ProductTab extends StatelessWidget {
  final ProductDetailModel? model;
  const ProductTab({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        key: PageStorageKey<ItemDetailTab>(ItemDetailTab.product),
        slivers: [
          SliverToBoxAdapter(child: Html(data: model?.detailHtml ?? ""))
        ]);
  }
}

class ReviewTab extends StatelessWidget {
  const ReviewTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: PageStorageKey<ItemDetailTab>(ItemDetailTab.review),
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            child: Center(child: Text("리뷰")),
            color: Colors.yellowAccent,
            height: 800,
          ),
        )
      ],
    );
  }
}

class QnaTab extends StatelessWidget {
  const QnaTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: PageStorageKey<ItemDetailTab>(ItemDetailTab.qna),
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            child: Center(child: Text("Q&A")),
            color: Colors.yellowAccent,
            height: 800,
          ),
        )
      ],
    );
  }
}

class InfoTab extends StatelessWidget {
  const InfoTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: PageStorageKey<ItemDetailTab>(ItemDetailTab.info),
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            child: Center(child: Text("주문정보")),
            color: Colors.yellowAccent,
            height: 800,
          ),
        )
      ],
    );
  }
}

enum ItemDetailTab {
  //category
  product("상품정보"),
  review("리뷰"),
  qna("Q&A"),
  info("주문정보");

  const ItemDetailTab(this.korean);
  final String korean;
}
