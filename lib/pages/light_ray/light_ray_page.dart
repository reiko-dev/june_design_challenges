import 'dart:math';

import 'package:flutter/material.dart';

class LightRayPage extends StatefulWidget {
  static const routeName = '/lightray-animation';
  const LightRayPage({Key? key}) : super(key: key);

  @override
  State<LightRayPage> createState() => _LightRayPageState();
}

class _LightRayPageState extends State<LightRayPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text('Light Ray Animation'),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox.fromSize(
          size: Size.square(size.shortestSide * .9),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              Center(
                child: SizedBox.square(
                  dimension: size.shortestSide * .8,
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) => Transform.rotate(
                      angle: 0,
                      child: CustomPaint(
                        painter: LightRayPainter(),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox.square(
                  dimension: size.shortestSide * .2,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LightRayPainter extends CustomPainter {
  static List<LightRay> lightRayList = [];
  static Size? oldSize;

  @override
  void paint(Canvas canvas, Size size) {
    final fullRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(
      fullRect,
      Paint()..color = Colors.amber,
    );

    canvas.saveLayer(
      fullRect,
      Paint()..blendMode = BlendMode.screen,
    );
    drawRays(canvas, size);
    drawCircle(canvas, size);

    canvas.restore();
  }

  //TODO: I. Create the ray lights only once.
  //II.Use the controller's value and create a loop for the light rays animations
  //Increase/decrease the light radius based on the controller's value.
  void drawRays(Canvas canvas, Size size) {
    if (lightRayList.isEmpty || oldSize != size) {
      oldSize = size;
      lightRayList.clear();
      loadRayPaths(size);
    } else {
      updateRays(size);
    }

    final paint = Paint()
      ..color = const Color(0xFF070707)
      ..blendMode = BlendMode.screen;

    final outerPathList = Path();
    final innerRayPath = Path();
    for (var lightRay in lightRayList) {
      outerPathList.addPath(lightRay.outerPath, Offset.zero);
      innerRayPath.addPath(lightRay.innerRayPath, Offset.zero);
    }

    canvas.drawPath(outerPathList, paint);
    final fullRect = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawPath(
      innerRayPath,
      paint
        ..shader = const RadialGradient(
          colors: [
            Color(0xAAFFFFFF),
            Color(0x00FFFFFF),
          ],
          stops: [0.1, 0.9],
        ).createShader(fullRect),
    );
  }

  void updateRays(Size size) {
    for (int i = 0; i < lightRayList.length; i++) {
      lightRayList[i].increaseRadius(
        10,
        size.shortestSide * .55,
        size.shortestSide * .15,
      );
    }
  }

  void loadRayPaths(Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    double innerRaySize = 1;
    final rand = Random();

    double numberOfLightRays = 6;
    //In percentage of a full rotation (2*pi)
    double initialAngle = 0;

    for (int i = 0; i < numberOfLightRays; i++) {
      final radiusRandomness = rand.nextDouble();
      final randomRadius = (size.shortestSide * .15) +
          size.shortestSide * 0.3 * radiusRandomness;

      double angle =
          initialAngle + 100 / numberOfLightRays * (i) - innerRaySize;
      lightRayList.add(
        LightRay(
          center: center,
          startAngle: angle,
          endAngle: angle + innerRaySize * 2,
          radius: randomRadius,
          innerRaySize: innerRaySize,
          isGrowing: rand.nextBool(),
        ),
      );
    }
    numberOfLightRays = 9;
    initialAngle = 3;

    for (int i = 0; i < numberOfLightRays; i++) {
      final radiusRandomness = rand.nextDouble();
      final randomRadius = (size.shortestSide * .25) +
          size.shortestSide * 0.3 * radiusRandomness;

      double angle =
          initialAngle + 100 / numberOfLightRays * (i) - innerRaySize;
      lightRayList.add(
        LightRay(
          center: center,
          startAngle: angle,
          endAngle: angle + innerRaySize * 2,
          radius: randomRadius,
          innerRaySize: innerRaySize,
          isGrowing: rand.nextBool(),
        ),
      );
    }

    numberOfLightRays = 9;
    initialAngle = 10;

    for (int i = 0; i < numberOfLightRays; i++) {
      final radiusRandomness = rand.nextDouble();
      final randomRadius = (size.shortestSide * .25) +
          size.shortestSide * 0.3 * radiusRandomness;

      double angle =
          initialAngle + 100 / numberOfLightRays * (i) - innerRaySize;
      lightRayList.add(
        LightRay(
          center: center,
          startAngle: angle,
          endAngle: angle + innerRaySize * 2,
          radius: randomRadius,
          innerRaySize: innerRaySize,
          isGrowing: rand.nextBool(),
        ),
      );
    }
  }

  void drawCircle(Canvas canvas, Size size) {
    final paint = Paint()
      ..blendMode = BlendMode.screen
      ..shader = RadialGradient(
        colors: [
          Colors.white,
          Colors.black.withOpacity(0.4),
          Colors.black,
        ],
        stops: const [
          0.2,
          0.55,
          0.6,
        ],
        tileMode: TileMode.clamp,
      ).createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      (size.shortestSide / 2) * 0.9,
      paint,
    );
  }

  @override
  bool shouldRepaint(LightRayPainter oldDelegate) => true;
}

class LightRay {
  LightRay({
    required this.radius,
    required this.startAngle,
    required this.endAngle,
    required this.innerRaySize,
    required this.center,
    required this.isGrowing,
  });

  ///Valor do tamanho do raio de luz a partir de [center].
  double radius;

  ///Valor entre [0-100]. Uma porcentagem de 2*pi, em sentido horário.
  final double startAngle;

  ///Valor entre [0-100] >= [startAngle]. Uma porcentagem de 2*pi.
  final double endAngle;

  ///Valor entre [0-100], uma porcentagem de 2 * pi.
  ///
  ///O valor deve ser menor que [endAngle] - [startAngle].
  final double innerRaySize;

  ///Indica o ponto inicial do raio de luz, o ponto mais branco e fino do raio.
  final Offset center;

  //Controls weather the light ray must grow or shrink.
  bool isGrowing = true;

  Path get outerPath {
    return _getRayPath(startAngle: startAngle, endAngle: endAngle);
  }

  void increaseRadius(
      double value, double maxRadiusSize, double minRadiusSize) {
    if (isGrowing) {
      if (radius + value > maxRadiusSize) {
        isGrowing = false;
        radius -= value;
      } else {
        radius += value;
      }
    } else {
      if (radius - value < minRadiusSize) {
        isGrowing = true;
        radius += value;
      } else {
        radius -= value;
      }
    }
  }

  Path get innerRayPath {
    double innerRayStartAngle =
        startAngle + ((endAngle - startAngle) - innerRaySize) / 2;

    double innerRayEndAngle = innerRayStartAngle + innerRaySize;

    return _getRayPath(
        startAngle: innerRayStartAngle, endAngle: innerRayEndAngle);
  }

  Path _getRayPath({required double startAngle, required double endAngle}) {
    startAngle = startAngle * 2 * pi / 100;
    endAngle = endAngle * 2 * pi / 100;

    return Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo(
        center.dx + (radius * cos(startAngle)),
        center.dy + (radius * sin(startAngle)),
      )
      ..lineTo(
        center.dx + (radius * cos(endAngle)),
        center.dy + (radius * sin(endAngle)),
      )
      ..close();
  }
}
