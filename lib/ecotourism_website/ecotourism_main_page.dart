import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:june_design_challenges/ecotourism_website/center_panel.dart';
import 'package:june_design_challenges/ecotourism_website/destinations.dart';
import 'package:june_design_challenges/ecotourism_website/data/feature.dart';

//Clean the code.
class EcotourismMainPage extends StatelessWidget {
  const EcotourismMainPage();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topPanelTopPadding = MediaQuery.of(context).padding.top;
    const topPanelHeight = 35.0;
    bool isMobile = size.width < 500;

    Widget _buildMobile() {
      final double featuredCarouselHeight = max(size.height * .5, 300);

      return Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              //BackGround
              SizedBox(
                width: size.width,
                height: size.height * .5,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      'https://www.origamid.com/projetos/nature/img/slide/slide-1.jpg',
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: topPanelHeight + 15),
                      child: Center(
                        child: SizedBox(
                          height: size.height * 0.46 - (topPanelHeight + 15),
                          width: size.width * 0.7,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            //TODO: fix this!
                            child: Text(
                              'Your adventure\n starts here',
                              maxLines: 2,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //TopPanel
                    Positioned(
                      top: topPanelTopPadding,
                      child: TopPanel(
                        height: topPanelHeight,
                        isMobile: isMobile,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 175),
              //Featured container
              SizedBox(
                height: featuredCarouselHeight,
                width: size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: featuredCarouselHeight * 0.35,
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 8.0,
                                right: size.width * 0.1,
                              ),
                              child: FittedBox(
                                child: Text('Featured'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 8.0,
                              right: size.width * 0.1,
                            ),
                            child: Text(
                              'Unique wildlife tours and ecotourism holidays offered by Zubox experts.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: featuredCarouselHeight * 0.65,
                      width: size.width,
                      child: Row(
                        children: [
                          Expanded(
                            child: FeaturedList(
                              isMobile: isMobile,
                              size: Size(featuredCarouselHeight, size.width),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Destinations(isMobile),
            ],
          ),
          Positioned(
            top: size.height * .5 - 25,
            child: CenterPanel(isMobile: true),
          ),
        ],
      );
    }

    Widget _buildWeb(Size size) {
      return Column(
        children: [
          //Page1
          Container(
            width: size.width,
            height: size.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          //BackGround
                          SizedBox(
                            width: size.width,
                            height: size.height * .5,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  'https://www.origamid.com/projetos/nature/img/slide/slide-1.jpg',
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: topPanelHeight + 15),
                                  child: Center(
                                    child: SizedBox(
                                      height: size.height * 0.46 -
                                          (topPanelHeight + 15),
                                      width: size.width * 0.7,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'Your adventure\n starts here',
                                          maxLines: 2,
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //TopPanel
                          Positioned(
                            top: topPanelTopPadding,
                            child: TopPanel(
                              height: topPanelHeight,
                              isMobile: false,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Featured container
                    SizedBox(
                      width: size.width,
                      height: size.height * .5,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: FittedBox(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Featured',
                                        style: TextStyle(),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'Unique wildlife tours and ecotourism holidays offered by Zubox experts.',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          //Featured Elements
                          Expanded(
                            flex: 6,
                            child: FeaturedList(
                              isMobile: isMobile,
                              size: size,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: size.height * .5 - 25,
                  child: CenterPanel(isMobile: false),
                ),
              ],
            ),
          ),
          Destinations(isMobile),
        ],
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: isMobile
            ? _buildMobile()
            : _buildWeb(
                Size(size.width, size.height < 600 ? 600 : size.height)),
      ),
    );
  }
}

class FeaturedList extends StatelessWidget {
  FeaturedList({
    required this.size,
    required this.isMobile,
  }) : super(key: ValueKey('FeaturedList-Key'));

  final Size size;
  final bool isMobile;
  final double webMinWidth = 350;

  double getWidth(Size size, BoxConstraints bc) {
    double width = 0;

    if (isMobile) {
      width = bc.maxWidth * 0.8;
    } else {
      width =
          bc.maxWidth * .32 < webMinWidth ? webMinWidth : bc.maxWidth * 0.32;
    }
    return width;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, bc) {
        double width = getWidth(size, bc);

        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
          }),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(
              featuresList.length,
              (index) => SizedBox(
                width: width,
                height: bc.maxHeight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FeaturedElement(
                    feature: featuresList[index],
                  ),
                ),
              ),
            )),
          ),
        );
      },
    );
  }
}

class FeaturedElement extends StatelessWidget {
  const FeaturedElement({
    Key? key,
    required this.feature,
  }) : super(key: key);

  final Feature feature;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.9,
              width: constraints.maxWidth,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(feature.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    feature.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class TopPanel extends StatelessWidget {
  TopPanel({required this.height, required this.isMobile})
      : super(key: UniqueKey());
  final double height;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * .05),
      child: SizedBox(
        width: size.width * .9,
        height: height,
        child: isMobile
            ? Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    child: IconButton(
                      icon: Icon(Icons.menu, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                  Text(
                    'ZUBOX',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Text(
                    'ZUBOX',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Discover', style: TextStyle(color: Colors.white)),
                        SizedBox(width: 10),
                        Text('About us', style: TextStyle(color: Colors.white)),
                        SizedBox(width: 10),
                        Text('Blog', style: TextStyle(color: Colors.white)),
                        SizedBox(width: 10),
                        Text('Contact us',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.search_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'English',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Icon(
                              Icons.arrow_drop_down_rounded,
                              color: Colors.white,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
