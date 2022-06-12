import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:june_design_challenges/pages/ecotourism_website/center_panel.dart';
import 'package:june_design_challenges/pages/ecotourism_website/data/dummy_data.dart';
import 'package:june_design_challenges/pages/ecotourism_website/data/feature.dart';
import 'package:june_design_challenges/pages/ecotourism_website/destinations.dart';
import 'package:june_design_challenges/pages/ecotourism_website/footer.dart';

//Clean the code.
class EcotourismPage extends StatelessWidget {
  static const routeName = '/eco-page';
  const EcotourismPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topPanelTopPadding = MediaQuery.of(context).padding.top;
    const topPanelHeight = 35.0;
    bool isMobile = size.width < 500;

    Widget buildMobile() {
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
                    Image.asset(bgImage, fit: BoxFit.cover),
                    Padding(
                      padding: const EdgeInsets.only(top: topPanelHeight + 15),
                      child: Center(
                        child: SizedBox(
                          height: size.height * 0.46 - (topPanelHeight + 15),
                          width: size.width * 0.7,
                          child: const FittedBox(
                            fit: BoxFit.contain,
                            child: AutoSizeText(
                              'Your adventure starts here',
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

              const SizedBox(height: 175),
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
                              child: const FittedBox(
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
              const Footer(),
            ],
          ),
          Positioned(
            top: size.height * .5 - 25,
            child: const CenterPanel(isMobile: true),
          ),
        ],
      );
    }

    Widget buildWeb(Size size) {
      return Column(
        children: [
          //Page1
          SizedBox(
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
                                Image.asset(bgImage, fit: BoxFit.cover),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: topPanelHeight + 15),
                                  child: Center(
                                    child: SizedBox(
                                      height: size.height * 0.46 -
                                          (topPanelHeight + 15),
                                      width: size.width * 0.7,
                                      child: const FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'Your adventure starts here',
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
                                  const Expanded(
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
                  child: const CenterPanel(isMobile: false),
                ),
              ],
            ),
          ),
          Destinations(isMobile),
          const Footer(),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ecotourism Page'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: isMobile
            ? buildMobile()
            : buildWeb(Size(size.width, size.height < 600 ? 600 : size.height)),
      ),
    );
  }
}

class FeaturedList extends StatelessWidget {
  const FeaturedList({
    required this.size,
    required this.isMobile,
  }) : super(key: const ValueKey('FeaturedList-Key'));

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

        return SingleChildScrollView(
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
                      image: AssetImage(feature.image),
                      fit: BoxFit.cover,
                      alignment: const Alignment(0, -.5)),
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
                    style: const TextStyle(
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
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                  const Text(
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
                  const Text(
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
                      children: const [
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
                        const Icon(
                          Icons.search_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
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
