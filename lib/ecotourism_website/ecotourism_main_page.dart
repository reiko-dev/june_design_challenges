import 'package:flutter/material.dart';
import 'package:june_design_challenges/ecotourism_website/center_panel.dart';
import 'package:june_design_challenges/ecotourism_website/destinations.dart';

class EcotourismMainPage extends StatelessWidget {
  const EcotourismMainPage();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const topPanelHeight = 30.0;
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
                                child: const TopPanel(topPanelHeight),
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
              const Destinations(),
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
  const TopPanel(this.height);
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
