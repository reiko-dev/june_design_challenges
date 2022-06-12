import 'package:flutter/material.dart';
import 'package:june_design_challenges/pages/parallax_scrolling/dummy_data.dart';

const bgColor = Color.fromARGB(255, 13, 20, 31);
final myAppBar = AppBar(
  backgroundColor: bgColor,
  title: const Text('Parallax Scrolling'),
  centerTitle: true,
);

class ParallaxScrollingPage extends StatelessWidget {
  static const routeName = '/parallax-simple';
  const ParallaxScrollingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: bgColor,
        ),
        child: ListView(
          children: List.generate(
            imgsList.length,
            (index) {
              return ImageTile(imgsList[index]);
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
  ImageTileState createState() => ImageTileState();
}

class ImageTileState extends State<ImageTile> {
  Size size(context) {
    var size = MediaQuery.of(context).size;
    size = Size(
        size.width, size.height - (Scaffold.of(context).appBarMaxHeight ?? 0));

    return size;
  }

  @override
  Widget build(BuildContext context) {
    final maxSize = size(context);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: maxSize.height,
          maxWidth: maxSize.width,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 16,
          ),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: LayoutBuilder(
              builder: (context, constraints) => Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      BackgroundImage(widget.image),
                      Positioned(
                        left: constraints.maxWidth * 0.05,
                        bottom: constraints.maxHeight * 0.02,
                        width: constraints.maxWidth * 0.35,
                        height: constraints.maxHeight * 0.2,
                        child: TitleWithSubTitle(image: widget.image),
                      ),
                    ],
                  ),
                ),
              ),
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
    return LayoutBuilder(
      builder: (context, bc) {
        return Flow(
          delegate: ParallaxFlowDelegate(
            backgroundImageKey: _backgroundImageKey,
            listItemContext: context,
            scrollable: Scrollable.of(context)!,
          ),
          children: [
            Image.asset(
              image.url,
              key: _backgroundImageKey,
              fit: BoxFit.cover,
              frameBuilder: (_, child, int? frame, bool wasSynchronoulyLoaded) {
                if (wasSynchronoulyLoaded) {
                  return child;
                }
                return SizedBox.fromSize(
                  size: bc.biggest,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      AnimatedOpacity(
                        opacity: frame == null ? 0 : 1,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeOut,
                        child: child,
                      ),
                      if (frame != null) const MyGradient(),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
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

  static const decoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.transparent,
        Color(0xD8000000),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.6, 0.95],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(decoration: decoration);
  }
}
