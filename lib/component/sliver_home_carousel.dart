import 'package:army_rent_clothes/repository/my_repositories.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliverHomeCarousel extends StatefulWidget {

  SliverHomeCarousel({Key? key}) : super(key: key);

  @override
  State<SliverHomeCarousel> createState() => _SliverHomeCarouselState();
}

class _SliverHomeCarouselState extends State<SliverHomeCarousel> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: FutureBuilder<List<Image>>(
          future: HomeCarouselRepository.fetch(),
          builder: (BuildContext context, AsyncSnapshot<List<Image>> snapshot) {
            List<Widget>? items;
            if (snapshot.hasData) {
              // items = [const Center(child: CircularProgressIndicator())];
              items = snapshot.data!;
            }
            return Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.width,
                    aspectRatio: 1,
                    viewportFraction: 1,
                    autoPlay: snapshot.hasData,
                    onPageChanged:
                        (int index, CarouselPageChangedReason reason) {
                          setState(() {
                            pageIndex = index;
                          });
                        },
                  ),
                  items: items ?? [const Center(child: CircularProgressIndicator())],
                  // items: [1, 2, 3, 4, 5, 6]
                  //     .map((i) => Builder(builder: (context) {
                  //           return Image.asset("asset/img/carousel$i.jpg");
                  //         }))
                  //     .toList(),
                ),
                Positioned(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2.0),
                      child: Text(
                        "${pageIndex+1}/${(snapshot.data ?? []).length}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  right: 16,
                  bottom: 16,
                ),
              ],
            );
          }),
    );
  }
}
