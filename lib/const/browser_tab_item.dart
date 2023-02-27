import 'package:army_rent_clothes/const/bottom_tap_item.dart';

enum BrowserTabItem {

  //category
  all("전체"),
  outer("아우터"),
  top("상의"),
  shirt("셔츠"),
  pants("바지"),
  shoes("신발"),
  hat("모자"),
  bag("가방"),
  etc("잡화"),

  //cody
  minimal("미니멀"),
  amekaji("아메카지"),
  cityboy("시티보이"),
  casual("캐주얼"),
  businessCasual("비즈니스캐주얼"),
  street("스트릿"),
  highteen("하이틴"),
  romantic("로맨틱"),
  girlish("걸리시"),
  sporty("스포티");

  const BrowserTabItem(this.korean);
  final String korean;

  static List<BrowserTabItem> tabs(BottomTapItem bottomTap){
    switch(bottomTap){
      case BottomTapItem.cody:
        return cody();
      case BottomTapItem.category:
        return category();
      case BottomTapItem.home:
      case BottomTapItem.my:
        throw Exception("와썹?");
    }
  }
  static List<BrowserTabItem> category() {
    return [
      BrowserTabItem.all,
      BrowserTabItem.outer,
      BrowserTabItem.top,
      BrowserTabItem.shirt,
      BrowserTabItem.pants,
      BrowserTabItem.shoes,
      BrowserTabItem.hat,
      BrowserTabItem.bag,
      BrowserTabItem.etc,
    ];
  }

  static List<BrowserTabItem> cody() {
    return [
      BrowserTabItem.all,
      BrowserTabItem.minimal,
      BrowserTabItem.amekaji,
      BrowserTabItem.cityboy,
      BrowserTabItem.casual,
      BrowserTabItem.businessCasual,
      BrowserTabItem.street,
      BrowserTabItem.highteen,
      BrowserTabItem.romantic,
      BrowserTabItem.girlish,
      BrowserTabItem.sporty,
    ];
  }
}

/*
TODO subcategory
 */
