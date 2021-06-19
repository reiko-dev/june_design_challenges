import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:june_design_challenges/ecotourism_website/data/destination.dart';

class Destinations extends StatefulWidget {
  Destinations(this.isMobile) : super(key: ValueKey('Destinations-key'));
  final bool isMobile;

  @override
  _DestinationsState createState() => _DestinationsState();
}

class _DestinationsState extends State<Destinations>
    with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        children: [
          SizedBox(
            height: size.height * .25,
            width: size.width * 0.7,
            child: FittedBox(
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
                            child: Image.network(
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
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Discover 56 tours',
                                  style: TextStyle(color: Colors.white),
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
                      ),
                      child: TabBar(
                        controller: tabController,
                        onTap: (val) {
                          pageController.animateToPage(
                            val,
                            duration: Duration(milliseconds: 1000),
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
                              style: TextStyle(color: Colors.black),
                            ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const BottomHeader(),
        ],
      ),
    );
  }
}

class BottomHeader extends StatelessWidget {
  const BottomHeader();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isMobile = size.width < 500;

    final style =
        TextStyle(color: Colors.grey.shade200.withAlpha(200), fontSize: 13);
    final styleFaded = TextStyle(
      color: Colors.grey.shade400.withAlpha(150),
      fontSize: 13,
    );
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: isMobile
          ? Container(
              height: 240,
              width: size.width,
              decoration: BoxDecoration(
                color: const Color(0xFF051221),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ThreeColumnsInfo(
                              styleFaded: styleFaded, style: style),
                        )),
                    Divider(
                      indent: size.width * 0.15,
                      endIndent: size.width * 0.15,
                      color: Colors.white,
                    ),
                    Expanded(
                      flex: 2,
                      child:
                          ContatcWidget(styleFaded: styleFaded, style: style),
                    ),
                    Divider(
                      indent: size.width * 0.15,
                      endIndent: size.width * 0.15,
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Text(
                        'Copyright @ 2021 | ZUBOX',
                        style: TextStyle(
                          color: Colors.grey.shade400.withAlpha(150),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              height: 150,
              width: size.width,
              decoration: BoxDecoration(
                color: const Color(0xFF051221),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ThreeColumnsInfo(
                              styleFaded: styleFaded,
                              style: style,
                            ),
                          ),
                          SizedBox(
                            width: 1,
                            height: 100,
                            child: VerticalDivider(
                              endIndent: 8,
                              indent: 8,
                              thickness: 0.3,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ContatcWidget(
                                styleFaded: styleFaded,
                                style: style,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.8,
                    height: 10,
                    child: Divider(
                      thickness: 0.3,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Copyright @ 2021 | ZUBOX',
                      style: TextStyle(
                        color: Colors.grey.shade400.withAlpha(150),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class ContatcWidget extends StatelessWidget {
  const ContatcWidget({
    Key? key,
    required this.styleFaded,
    required this.style,
  }) : super(key: key);

  final TextStyle styleFaded;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Email: ',
                style: styleFaded,
              ),
              Text(
                'zubox@gmail.com',
                style: style,
              ),
            ],
          ),
        ),
        Expanded(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: styleFaded,
              text: 'Address: ',
              children: [
                TextSpan(
                  text: '128, Zoomland Road, Sorocaba-SP',
                  style: style,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ThreeColumnsInfo extends StatelessWidget {
  const ThreeColumnsInfo({
    Key? key,
    required this.styleFaded,
    required this.style,
  }) : super(key: key);

  final TextStyle styleFaded;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                'About',
                style: styleFaded.copyWith(fontSize: 15),
              ),
              Text('Contact Us', style: style),
              Text('About Us', style: style),
              Text('Careers', style: style),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Help',
                style: styleFaded.copyWith(fontSize: 15),
              ),
              Text('Payment', style: style),
              Text('FAQ', style: style),
              Text('Policy', style: style),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'Social',
                style: styleFaded.copyWith(fontSize: 15),
              ),
              Text('Twitter', style: style),
              Text('Facebook', style: style),
              Text('Youtube', style: style),
            ],
          ),
        ),
      ],
    );
  }
}
