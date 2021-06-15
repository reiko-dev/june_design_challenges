import 'package:flutter/material.dart';

class Destinations extends StatefulWidget {
  const Destinations();

  @override
  _DestinationsState createState() => _DestinationsState();
}

class _DestinationsState extends State<Destinations>
    with SingleTickerProviderStateMixin {
  final tabs = [
    'North America',
    'South America',
    'Europe',
    'Asia',
    'Africa',
    'Australia'
  ];
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
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
            width: size.width * 0.9,
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    'https://shotkit.com/wp-content/uploads/2020/08/night-landscape-photography-featured.jpg',
                    fit: BoxFit.cover,
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
                              'Europe',
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
                if (size.width >= 700)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: size.width * 0.75,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TabBar(
                        controller: tabController,
                        indicatorColor: const Color(0xFF051221),
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: [
                          for (var tab in tabs)
                            Text(
                              tab,
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
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.05),
            child: Container(
              height: size.height * .1,
              width: size.width,
              color: const Color(0xFF051221),
            ),
          )
        ],
      ),
    );
  }
}
