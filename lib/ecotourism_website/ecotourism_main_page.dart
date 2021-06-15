import 'package:flutter/material.dart';

class EcotourismMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double topPanelHeight = 30.0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
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
                              SizedBox(
                                width: size.width,
                                height: size.height / 2,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image.network(
                                        'https://www.origamid.com/projetos/nature/img/slide/slide-1.jpg',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: topPanelHeight + 15),
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
                              Positioned(
                                top: 15,
                                child: TopPanel(topPanelHeight),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width,
                          height: size.height / 2,
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: FractionallySizedBox(
                                          widthFactor: 0.7,
                                          child: FittedBox(
                                            child: Text(
                                              'Featured',
                                              style: TextStyle(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            'Unique wildlife tours and ecotourism\n holidays offered by Zubox experts.',
                                            style: TextStyle(
                                                color: Colors.grey.shade600),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: FeaturedElement(
                                            title: 'Animals',
                                            image:
                                                'https://painel.portalamazonia.com/uploads/RTEmagicC_animal-poder-onca.jpg.jpg',
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.02),
                                        Expanded(
                                          child: FeaturedElement(
                                            image:
                                                'https://t2.ea.ltmcdn.com/pt/images/2/3/3/o_guaxinim_como_animal_de_estimacao_2332_orig.jpg',
                                            title: 'Photography',
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.02),
                                        Expanded(
                                          child: FeaturedElement(
                                            image:
                                                'https://blog.penatrilha.com.br/wp-content/uploads/2016/09/Trekking.jpg',
                                            title: 'Trekking',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const CenterPanel(),
                  ],
                ),
              ),
              DestinationsElement(),
            ],
          ),
        ),
      ),
    );
  }
}

class FeaturedElement extends StatelessWidget {
  const FeaturedElement({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  final String image;
  final String title;
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
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.1,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
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
  TopPanel(this.height) : super(key: UniqueKey());
  final double height;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    bool isMobile = size.width < 500;

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
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
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

class CenterPanel extends StatefulWidget {
  const CenterPanel({
    Key? key,
  }) : super(key: key);

  @override
  _CenterPanelState createState() => _CenterPanelState();
}

class _CenterPanelState extends State<CenterPanel> {
  bool showIcons = true;
  late Size containerSize;
  late double dividerPadding;
  bool isHorizontalLayout = false;
  var divider = VerticalDivider(
    color: Colors.grey.shade400,
    indent: 10,
    endIndent: 10,
    thickness: 1.2,
  );
  void updateContainerSize(Size size) {
    showIcons = true;
    isHorizontalLayout = false;
    double height = size.height >= 500 ? 50 : size.height * .1;
    double width = size.width * .6;

    if (size.width <= 600) {
      isHorizontalLayout = true;
      height = 200;
      width = 250;
    }

    if (size.width > 600 && size.width < 800) showIcons = false;

    dividerPadding = height * .2;

    containerSize = Size(width, height);
  }

  @override
  Widget build(BuildContext context) {
    updateContainerSize(MediaQuery.of(context).size);

    return isHorizontalLayout
        ? SizedBox(
            width: containerSize.width,
            height: containerSize.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CenterPanelTile(
                    icon: Icon(Icons.place_outlined),
                    title: 'Destination',
                    showIcons: showIcons),
                CenterPanelTile(
                  icon: Icon(Icons.date_range_outlined),
                  showIcons: showIcons,
                  title: 'Dates',
                ),
                CenterPanelTile(
                  icon: Icon(Icons.person),
                  title: 'People',
                  showIcons: showIcons,
                ),
                CenterPanelTile(
                    icon: Icon(Icons.light_mode),
                    title: 'Experience',
                    showIcons: showIcons),
              ],
            ),
          )
        : Container(
            width: containerSize.width,
            height: containerSize.height,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(children: [
                  if (showIcons) Icon(Icons.place_outlined),
                  Text('Destination'),
                ]),
                divider,
                Row(children: [
                  if (showIcons) Icon(Icons.date_range_outlined),
                  Text('Dates'),
                ]),
                divider,
                Row(children: [
                  if (showIcons) Icon(Icons.person),
                  Text('People'),
                ]),
                divider,
                Row(children: [
                  if (showIcons) Icon(Icons.light_mode),
                  Text('Experience'),
                ]),
                divider,
                SizedBox(
                  width: containerSize.width * .15,
                  height: containerSize.height * .8,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: showIcons ? Text('Search') : Icon(Icons.search),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFF001500),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

class CenterPanelTile extends StatelessWidget {
  CenterPanelTile({
    required this.icon,
    required this.title,
    required this.showIcons,
  }) : super(key: ValueKey(title));

  final Icon icon;
  final String title;
  final bool showIcons;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 38.0),
          child: Row(children: [
            if (showIcons) icon,
            Text(title),
          ]),
        ),
      ),
    );
  }
}

class DestinationsElement extends StatefulWidget {
  @override
  _DestinationsElementState createState() => _DestinationsElementState();
}

class _DestinationsElementState extends State<DestinationsElement>
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
