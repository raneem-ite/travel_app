import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/misc/colors.dart';
import 'package:flutter_cubit/model/data_model.dart';
import 'package:flutter_cubit/widgets/app_large_text.dart';
import 'package:flutter_cubit/widgets/app_text.dart';

class HomePage extends StatefulWidget {
  final List<DataModel> places;
  const HomePage(List list, {Key? key, required this.places}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Map<String, String> images = {
    "balloning.png": "Balloning",
    "hiking.png": "Hiking",
    "kayaking.png": "Kayaking",
    "snorkling.png": "Snorkling"
  };

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //top bar (app menu)
                Container(
                  // padding: const EdgeInsets.only(top: 70, left: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.menu,
                        size: 30,
                        color: Colors.black,
                      ),
                      const Spacer(),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.5)),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: const AppLargeText(text: "Discover")),
                const SizedBox(height: 30),
                //tab bar
                //tabbar title
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: TabBar(
                    isScrollable: true,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 15),
                    controller: _tabController,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: const CircleTabIndicator(
                        color: AppColors.mainColor, raduis: 2),
                    tabs: const [
                      Tab(text: "Places"),
                      Tab(text: "Inspiration"),
                      Tab(text: "Emotions"),
                    ],
                  ),
                ),
                //tab page view
                Container(
                  margin: const EdgeInsets.only(left: 8, top: 10),
                  height: 300,
                  width: double.maxFinite,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, int index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 250,
                              height: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: const DecorationImage(
                                      image: AssetImage("img/mountain.jpeg"),
                                      fit: BoxFit.cover)),
                            );
                          }),
                      // first tab view

                      const Text("there"), const Text("buy")
                    ],
                  ),
                )

                //titles
                ,
                const SizedBox(
                  height: 40,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: const [
                      AppLargeText(
                        text: "Explore more",
                        size: 18,
                      ),
                      Spacer(),
                      AppText(
                        text: "See all",
                        color: AppColors.textColor1,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 150,
                  // margin: const EdgeInsets.only(left: 20),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            //image
                            Container(
                              margin: const EdgeInsets.only(left: 40),
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: AssetImage('img/' +
                                          images.keys.elementAt(index)),
                                      fit: BoxFit.cover)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // text
                            Container(
                              margin: const EdgeInsets.only(left: 40),
                              child: AppText(
                                text: images.values.elementAt(index),
                                color: AppColors.textColor2,
                                size: 15,
                              ),
                            )
                          ],
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  final double raduis;

  const CircleTabIndicator({required this.color, required this.raduis});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, raduis: raduis);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  final double raduis;

  const _CirclePainter({required this.color, required this.raduis});
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset _offset = Offset(configuration.size!.width / 2 - raduis / 2,
        configuration.size!.height - raduis * 4);
    canvas.drawCircle(offset + _offset, raduis, _paint);
  }
}
