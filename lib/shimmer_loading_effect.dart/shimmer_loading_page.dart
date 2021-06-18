import 'package:flutter/material.dart';

class ShimmerLoadingPage extends StatefulWidget {
  const ShimmerLoadingPage({Key? key}) : super(key: key);

  @override
  State<ShimmerLoadingPage> createState() => _ShimmerLoadingPageState();
}

class _ShimmerLoadingPageState extends State<ShimmerLoadingPage> {
  bool isLoading = true;

  final color = Colors.grey.shade300;
  final bDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: Colors.grey.shade300,
    // image: DecorationImage(
    //   fit: BoxFit.cover,
    //   image: NetworkImage(
    //     'https://flutter'
    //     '.dev/docs/cookbook/img-files/effects/split-check/Avatar1.jpg',
    //   ),
    // ),
  );

  void toggleIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: toggleIsLoading,
        child: Text('Run'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(
          children: [
            ShimmerLoadingWidget(
              isLoading: isLoading,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(backgroundColor: color),
                      CircleAvatar(backgroundColor: color),
                      CircleAvatar(backgroundColor: color),
                      CircleAvatar(backgroundColor: color),
                      CircleAvatar(backgroundColor: color),
                      CircleListItem(),
                    ],
                  ),
                  AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Container(
                      decoration: bDecoration,
                    ),
                  ),
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: color,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 100.0),
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: color,
                      ),
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Container(
                      decoration: bDecoration,
                    ),
                  ),
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerLoadingWidget extends StatefulWidget {
  const ShimmerLoadingWidget({
    Key? key,
    required this.child,
    required this.isLoading,
  }) : super(key: key);
  final Widget child;
  final bool isLoading;
  @override
  createState() => _ShimmerLoadingWidgetState();
}

class _ShimmerLoadingWidgetState extends State<ShimmerLoadingWidget>
    with SingleTickerProviderStateMixin {
  final _shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFFF0000),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      lowerBound: 0.0,
      upperBound: 350.0,
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _controller.repeat();
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
                // print(bounds);
                bounds = bounds.translate(
                  -100 + _controller.value,
                  -100 + _controller.value,
                );
                // bounds = bounds.translate(250, 250);
                return _shimmerGradient.createShader(bounds);
              },
              child: child,
            ),
            child: widget.child,
          );
  }
}

class CircleListItem extends StatelessWidget {
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
          child: Image.network(
            'https://flutter'
            '.dev/docs/cookbook/img-files/effects/split-check/Avatar1.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
