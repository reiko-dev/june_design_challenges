import 'dart:math';

import 'package:flutter/material.dart';

class LightRayPage extends StatefulWidget {
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
      duration: Duration(seconds: 1),
    );
    // controller.repeat();
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: SizedBox.fromSize(
          size: Size.square(900),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: controller,
                builder: (context, child) => Transform.rotate(
                  angle: 0,
                  child: CustomPaint(
                    painter: LightRayPainter(),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.red,
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
  LightRayPainter() {
    print('Constructor called');
  }
  @override
  void paint(Canvas canvas, Size size) {
    final fullRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(
      fullRect,
      Paint()..color = const Color(0xFFe4e027),
      // Paint()..color = const Color(0xFF000000),
    );

    canvas.saveLayer(
      fullRect,
      Paint()..blendMode = BlendMode.screen,
    );
    drawRays(canvas, size);
    drawCircle(canvas, size);

    canvas.restore();
  }

  //TODO: I. Criar a lista de raios uma única vez.
  //II.Usar os valores do controller e criar um loop
  //Aumentando e diminuindo o raio de luz com base no valor do controller.
  //III.
  void drawRays(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final lightRayList = <LightRay>[];
    double innerRaySize = 1;
    final rand = Random();

    double numberOfLightRays = 6;
    //In percentage of a full rotation (2*pi)
    double initialAngle = 0;

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
        ),
      );
    }

    final paint = Paint()
      ..color = Color(0xFF070707)
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
        ..shader = RadialGradient(
          colors: const [
            const Color(0xAAFFFFFF),
            const Color(0x00FFFFFF),
          ],
          stops: [0.1, 0.9],
        ).createShader(fullRect),
    );
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
        stops: [
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
  bool shouldRepaint(LightRayPainter old) {
    return true;
  }
}

class LightRay {
  LightRay({
    required this.radius,
    required this.startAngle,
    required this.endAngle,
    required this.innerRaySize,
    required this.center,
  });

  ///Valor do tamanho do raio de luz a partir de [center].
  final double radius;

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

  Path get outerPath {
    return _getRayPath(startAngle: startAngle, endAngle: endAngle);
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
