import 'package:flutter/material.dart';

class ParallaxScrollingPage extends StatelessWidget {
  const ParallaxScrollingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF111A27),
        child: ListView(
          children: List.generate(
            _imgsList.length,
            (index) {
              return Center(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ImageTile(_imgsList[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ImageTile extends StatefulWidget {
  ImageTile(this.image) : super(key: UniqueKey());

  final ImageData image;
  @override
  _ImageTileState createState() => _ImageTileState(image);
}

class _ImageTileState extends State<ImageTile> {
  _ImageTileState(this.image);
  ImageData image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            width: double.infinity,
            height: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                image.url,
                fit: BoxFit.cover,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      child,
                      Positioned(
                        left: 15,
                        bottom: 30,
                        child: Column(
                          children: [
                            Text(
                              image.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            Text(
                              image.subTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Container(
                    color: Colors.blueGrey.withAlpha(10),
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }
}

class ImageData {
  const ImageData(this.url, this.title, this.subTitle);
  final String url;
  final String title;
  final String subTitle;
}

final _imgsList = const <ImageData>[
  ImageData(
    'https://hdwallsource.com/img/2014/8/wonderful-41060-42031-hd-wallpapers.jpg',
    'Bridge',
    'Switzerland',
  ),
  ImageData(
    'https://www.extremetech.com/wp-content/uploads/2016/12/ngc6357.jpg',
    'X II X!',
    'Space',
  ),
  ImageData(
    'https://www.extremetech.com/wp-content/uploads/2016/12/heic1007a.jpg',
    'Centaur Galaxy',
    'Far far away',
  ),
  ImageData(
    'https://cdn.eso.org/images/screen/eso1625a.jpg',
    'Unkown',
    'OMG',
  ),
  ImageData(
    'https://www.extremetech.com/wp-content/uploads/2016/12/potw1036a_scaled.jpg',
    'Observatory',
    'Cowntry X',
  ),
  ImageData(
    'https://photowalls.space/web/wallpapers/wonderful-space-and-planets/1366x768.jpg',
    'Moon and Sun',
    'Earth',
  ),
  ImageData(
    'https://i.redd.it/j57ysoe3c3471.jpg',
    'Dragon x Fighter',
    'Dragon\'s Cave',
  ),
  ImageData(
    'https://i.imgur.com/gMWCNBr.jpg',
    'Black Hole',
    'Interstellar 2014',
  ),
  ImageData(
    'https://i.redd.it/0ac253vmug471.png',
    'Incredible Spaceship',
    'Space',
  ),
  ImageData(
    'https://images2.fanpop.com/image/photos/9400000/Winter-in-Paris-natures-seasons-9455739-1500-1123.jpg',
    'Beautiful Snow',
    'Winter',
  ),
  ImageData(
    'https://images4.fanpop.com/image/photos/22100000/Trees-in-winter-natures-seasons-22173937-1920-1200.jpg',
    'Trees in winter',
    'Polony',
  ),
  ImageData(
    'https://images4.fanpop.com/image/photos/16700000/Magical-Autumn-Sylvie-s-season-natures-seasons-16782605-900-675.jpg',
    'Spring trees',
    'Hobbit\'s land',
  ),
];
