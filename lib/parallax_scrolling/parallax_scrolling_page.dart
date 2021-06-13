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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 16,
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ImageTile(_imgsList[index]),
                  ),
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
    return LayoutBuilder(
      builder: (context, constraints) => Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                BackgroundImage(image),
                MyGradient(),
                Positioned(
                  left: constraints.maxWidth * 0.05,
                  bottom: constraints.maxHeight * 0.02,
                  width: constraints.maxWidth * 0.35,
                  height: constraints.maxHeight * 0.2,
                  child: TitleWithSubTitle(image: image),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TitleWithSubTitle extends StatelessWidget {
  TitleWithSubTitle({
    required this.image,
  }) : super(key: ValueKey(image.url));

  final ImageData image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              image.title,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              image.subTitle,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

class BackgroundImage extends StatelessWidget {
  BackgroundImage(this.image) : super(key: UniqueKey());
  final GlobalKey _backgroundImageKey = GlobalKey();
  final ImageData image;

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        backgroundImageKey: _backgroundImageKey,
        listItemContext: context,
        scrollable: Scrollable.of(context)!,
      ),
      children: [
        Image.network(
          image.url,
          key: _backgroundImageKey,
          fit: BoxFit.cover,
          loadingBuilder: (
            BuildContext context,
            Widget child,
            ImageChunkEvent? loadingProgress,
          ) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          frameBuilder: (
            BuildContext context,
            Widget child,
            int? frame,
            bool wasSynchronouslyLoaded,
          ) {
            if (wasSynchronouslyLoaded) {
              return child;
            }
            return AnimatedOpacity(
              child: child,
              opacity: frame == null ? 0 : 1,
              duration: const Duration(seconds: 1),
              curve: Curves.easeOut,
            );
          },
        ),
      ],
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculates the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
      listItemBox.size.centerLeft(Offset.zero),
      ancestor: scrollableBox,
    );

    // Determines the percent position of this list item within the
    // scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculates the vertical alignment of the background
    // based on the scroll percentage.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
      0,
      transform: Transform.translate(
        offset: Offset(0.0, childRect.top),
      ).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}

class MyGradient extends StatelessWidget {
  const MyGradient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.6, 0.95]),
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
    'https://www.extremetech.com/wp-content/uploads/2016/12/ngc6357.jpg',
    'X II X!',
    'Space',
  ),
  ImageData(
    'https://user-images.githubusercontent.com/9553743/121814852-91756180-cc49-11eb-9619-d824811b52a6.jpg',
    'The Void Walker',
    'Kassadin',
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
    'https://user-images.githubusercontent.com/9553743/121814750-1449ec80-cc49-11eb-9ece-62e2eeb79ef7.jpg',
    'Les châteaux de votres rêves',
    'French',
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
