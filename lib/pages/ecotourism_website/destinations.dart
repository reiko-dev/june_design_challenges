import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:june_design_challenges/pages/ecotourism_website/data/dummy_data.dart';

class Destinations extends StatefulWidget {
  const Destinations(this.isMobile)
      : super(key: const ValueKey('Destinations-key'));
  final bool isMobile;

  @override
  DestinationsState createState() => DestinationsState();
}

class DestinationsState extends State<Destinations>
    with SingleTickerProviderStateMixin {
  final random = Random();
  late final TabController tabController;
  late final PageController pageController;
  final destinations = destinationsList;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: destinations.length, vsync: this);
    pageController = PageController(initialPage: 0, viewportFraction: 0.9);
  }

  double getTabWidth(Size size) {
    double maxWidth = 600;
    double tabWidth = size.width * 0.75;
    if (tabWidth > maxWidth) tabWidth = maxWidth;

    return tabWidth;
  }

  int get rand => 10 + random.nextInt(45);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        children: [
          SizedBox(
            height: size.height * .25,
            width: size.width * 0.7,
            child: const FittedBox(
              child: Text(
                'Destinations diversity',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * .6,
            width: size.width,
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                PageView.builder(
                  scrollDirection: Axis.horizontal,
                  scrollBehavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.mouse,
                        PointerDeviceKind.touch,
                        PointerDeviceKind.unknown
                      }),
                  pageSnapping: true,
                  onPageChanged: (val) {
                    tabController.animateTo(val);
                  },
                  controller: pageController,
                  itemCount: destinations.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      fit: StackFit.expand,
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              destinations[index].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: size.width * 0.4,
                            height: size.height * 0.15,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      destinations[index].name,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Discover $rand tours',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                //TabBar
                if (!widget.isMobile && size.width > 750)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: getTabWidth(size),
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(0, 10),
                              blurRadius: 4,
                              blurStyle: BlurStyle.outer,
                            )
                          ]),
                      child: TabBar(
                        controller: tabController,
                        onTap: (val) {
                          pageController.animateToPage(
                            val,
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeInCirc,
                          );
                        },
                        indicatorColor: const Color(0xFF051221),
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: [
                          for (var tab in destinations)
                            Text(
                              tab.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black),
                            ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
