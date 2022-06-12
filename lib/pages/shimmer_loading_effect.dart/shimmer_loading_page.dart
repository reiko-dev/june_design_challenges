import 'package:flutter/material.dart';
import 'package:june_design_challenges/pages/shimmer_loading_effect.dart/utils.dart';

class ShimmerLoadingPage extends StatefulWidget {
  static const routeName = '/shimmer-loading';

  const ShimmerLoadingPage({Key? key}) : super(key: key);

  @override
  State<ShimmerLoadingPage> createState() => _ShimmerLoadingPageState();
}

class _ShimmerLoadingPageState extends State<ShimmerLoadingPage> {
  bool isLoading = true;
  final _scrollController = ScrollController();

  final bDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: Colors.grey.shade300,
  );

  void toggleIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer Loading'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 46, 46, 46),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleIsLoading,
        backgroundColor: const Color.fromARGB(255, 46, 46, 46),
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Text(
              isLoading ? 'Fetched' : 'Fetch',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ShimmerLoadingWidget(
          isLoading: isLoading,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 700,
              ),
              child: SizedBox(
                child: PrimaryScrollController(
                  controller: _scrollController,
                  child: ListView(
                    primary: true,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: LayoutBuilder(
                          builder: (context, bc) {
                            double minWidth = 50;
                            final remainingSpace =
                                bc.maxWidth - 6 * minWidth + 20;

                            if (remainingSpace > 0) {
                              minWidth += remainingSpace / 8;
                            }

                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                              primary: false,
                              itemCount: 6,
                              itemBuilder: (context, i) {
                                return Center(
                                  child: i == 5
                                      ? const Padding(
                                          padding: EdgeInsets.all(3.0),
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: CircleListItem(),
                                          ),
                                        )
                                      : SizedBox(
                                          width: minWidth,
                                          child: CircleAvatar(
                                              backgroundColor: color),
                                        ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const Rectangle(),
                      Line(text: randomText),
                      Line(
                        widthFactor: .3,
                        alignment: Alignment.centerRight,
                        text: randomText,
                      ),
                      const Rectangle(),
                      Line(widthFactor: .5, text: randomText),
                      const Rectangle(),
                      Line(text: randomText),
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

class Rectangle extends StatelessWidget {
  const Rectangle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          height: size.height * .2,
          width: size.width * .4,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: randomColor,
            ),
          ),
        ),
      ),
    );
  }
}

class Line extends StatelessWidget {
  const Line({
    Key? key,
    this.widthFactor = 1,
    this.alignment = Alignment.centerLeft,
    this.text,
  }) : super(key: key);

  final double widthFactor;
  final Alignment alignment;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 20,
        child: text == null
            ? null
            : Align(
                alignment: alignment,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      text!,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )),
      ),
    );
  }
}

class ShimmerLoadingWidget extends StatefulWidget {
  factory ShimmerLoadingWidget({
    Key? key,
    required Widget child,
    required bool isLoading,
    Gradient? shimmerGradient,
  }) {
    shimmerGradient ??= const LinearGradient(
      colors: [
        Color(0xFFEBEBF4),
        Color.fromARGB(255, 202, 200, 200),
        Color(0xFFEBEBF4),
      ],
      stops: [
        0.15,
        0.3,
        0.45,
      ],
      begin: Alignment(-1.0, -0.3),
      end: Alignment(1.0, 0.3),
      tileMode: TileMode.clamp,
    );
    return ShimmerLoadingWidget._(
      isLoading: isLoading,
      gradient: shimmerGradient,
      key: key,
      child: child,
    );
  }

  const ShimmerLoadingWidget._({
    super.key,
    required this.child,
    required this.isLoading,
    required this.gradient,
  });

  final Widget child;
  //TODO: Could change this to be a ValueNotifier, then if isLoading is false
  //we could make the shimmering animation go from opaque to transparent.
  final bool isLoading;
  final Gradient gradient;

  @override
  createState() => _ShimmerLoadingWidgetState();
}

class _ShimmerLoadingWidgetState extends State<ShimmerLoadingWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      lowerBound: 0.0,
      upperBound: 350.0,
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !widget.isLoading
        ? widget.child
        : AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => ShaderMask(
              blendMode: BlendMode.srcATop,
              shaderCallback: (bounds) {
                bounds = bounds.translate(
                  -100 + _controller.value,
                  -100 + _controller.value,
                );

                return widget.gradient.createShader(bounds);
              },
              child: child,
            ),
            child: widget.child,
          );
  }
}

class CircleListItem extends StatelessWidget {
  const CircleListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        width: 54,
        height: 54,
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/images/shimmer/profile.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
