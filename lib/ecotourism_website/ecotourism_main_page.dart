import 'package:flutter/material.dart';

class EcotourismMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topPanelHeight = size.height * 0.05;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
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
                          Positioned(
                            top: 15,
                            width: size.width * .9,
                            height: topPanelHeight,
                            left: size.width * 0.05,
                            child: const TopPanel(),
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const CenterBar(),
              ],
            ),
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
              child: Image.network(
                image,
                fit: BoxFit.cover,
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
  const TopPanel();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'ZUBOX',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        Spacer(flex: 1),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Discover', style: TextStyle(color: Colors.white)),
              Text('About us', style: TextStyle(color: Colors.white)),
              Text('Blog', style: TextStyle(color: Colors.white)),
              Text('Contact us', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        Spacer(flex: 2),
        Expanded(
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
                    style: TextStyle(color: Colors.white, fontSize: 12),
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
    );
  }
}

class CenterBar extends StatelessWidget {
  const CenterBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double height = size.height >= 500 ? 50 : size.height * .1;
    final dividerPadding = height * .3;
    final buttonSize = Size(size.width * .07, height * .7);
    return Container(
      width: size.width * .6,
      height: height,
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
          Row(children: [Icon(Icons.place_outlined), Text('Destination')]),
          VerticalDivider(
            color: Colors.grey.shade400,
            indent: dividerPadding,
            endIndent: dividerPadding,
            thickness: 1.2,
          ),
          Row(children: [Icon(Icons.date_range_outlined), Text('Dates')]),
          VerticalDivider(
            color: Colors.grey.shade400,
            indent: dividerPadding,
            endIndent: dividerPadding,
            thickness: 1.2,
          ),
          Row(children: [Icon(Icons.person), Text('People')]),
          VerticalDivider(
            color: Colors.grey.shade400,
            indent: dividerPadding,
            endIndent: dividerPadding,
            thickness: 1.2,
          ),
          Row(children: [Icon(Icons.light_mode), Text('Experience')]),
          VerticalDivider(
            color: Colors.grey.shade400,
            indent: dividerPadding,
            endIndent: dividerPadding,
            thickness: 1.2,
          ),
          SizedBox.fromSize(
            size: buttonSize,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Search'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color(0xFF001500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
