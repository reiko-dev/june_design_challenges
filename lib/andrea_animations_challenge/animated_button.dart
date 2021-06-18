import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    Key? key,
    required this.iconData,
    required this.borderWidth,
    this.primaryColor = Colors.white,
    this.secondaryColor = Colors.black,
    this.borderColor = Colors.black,
  }) : super(key: key);

  final IconData iconData;
  final Color primaryColor;
  final Color secondaryColor;
  final double borderWidth;
  final Color borderColor;

  @override
  createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2500),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isSelected = true;
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          isSelected = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.stop();
    _controller.dispose();
  }

  void onTap() {
    toggleAnimation();
  }

  toggleAnimation() {
    print('run');
    if (_controller.isAnimating || _controller.isCompleted)
      _controller.reverse();
    else {
      if (_controller.isDismissed) {
        _controller.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          print(constraints);
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => CustomPaint(
              foregroundPainter: CustomCircleBorder(
                borderColor: widget.borderColor,
                borderWidth: widget.borderWidth,
                primaryColor: widget.primaryColor,
                secondaryColor: widget.secondaryColor,
                controller: _controller,
              ),
              child: child,
            ),
            child: Icon(
              widget.iconData,
              size: constraints.biggest.shortestSide,
              color: !isSelected ? widget.primaryColor : widget.secondaryColor,
            ),
          );
        },
      ),
    );
  }
}

//TODO: Make this a SingleChildRenderObject
class CustomCircleBorder extends CustomPainter {
  CustomCircleBorder({
    required this.borderColor,
    required this.borderWidth,
    required AnimationController controller,
    required this.primaryColor,
    required this.secondaryColor,
  })  : circleAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.5,
              // curve: Curves.easeInCirc,
            ),
          ),
        ),
        okAnimation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.5, 0.85),
          ),
        ),
        disposeAnimations = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.85,
              1.0,
              // curve: Curves.bounceOut,
            ),
          ),
        );

  final Color borderColor;
  final Color primaryColor;
  final Color secondaryColor;
  final double borderWidth;
  final Animation<double> circleAnimation;
  final Animation<double> okAnimation;
  final Animation<double> disposeAnimations;

  @override
  void paint(Canvas canvas, Size size) {
    if (borderWidth == 0.0) return;

    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    final rectMinusBorder = Rect.fromLTWH(
      borderWidth,
      borderWidth,
      size.width - 2 * borderWidth,
      size.height - 2 * borderWidth,
    );

    //Idle border
    canvas.drawArc(
      rectMinusBorder,
      1.5 * pi + circleAnimation.value,
      2 * pi - circleAnimation.value,
      false,
      paint,
    );
    canvas.drawArc(
      rectMinusBorder,
      1.5 * pi,
      circleAnimation.value,
      false,
      paint..color = Colors.white,
    );

    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      1.5 * pi,
      2 * pi,
      false,
      paint
        ..style = PaintingStyle.fill
        ..color = primaryColor.withOpacity(okAnimation.value),
    );

    //TODO: make a dispose transition between the "nike" element and the Icon
    //Hide nike element on the reverse animation
    canvas.drawPath(
        getNikePath(size),
        paint
          ..color = secondaryColor
              .withOpacity(okAnimation.value - disposeAnimations.value));
  }

  Path getNikePath(Size size) {
    Path path = Path()
      ..moveTo(size.width * 0.473, size.height * 0.664)
      ..lineTo(size.width * 0.737, size.height * 0.4)
      ..cubicTo(
        size.width * 0.755,
        size.height * 0.382,
        size.width * 0.755,
        size.height * 0.354,
        size.width * 0.737,
        size.height * 0.336,
      )
      ..cubicTo(
        size.width * 0.719,
        size.height * 0.318,
        size.width * 0.691,
        size.height * 0.318,
        size.width * 0.673,
        size.height * 0.336,
      )
      ..lineTo(size.width * 0.441, size.height * 0.568)
      ..lineTo(size.width * 0.327, size.height * 0.454)
      ..cubicTo(
        size.width * 0.309,
        size.height * 0.436,
        size.width * 0.281,
        size.height * 0.436,
        size.width * 0.263,
        size.height * 0.454,
      )
      ..cubicTo(
        size.width * 0.245,
        size.height * 0.472,
        size.width * 0.245,
        size.height * 0.500,
        size.width * 0.263,
        size.height * 0.518,
      )
      ..lineTo(size.width * 0.409, size.height * 0.664)
      ..cubicTo(
        size.width * 0.418,
        size.height * 0.673,
        size.width * 0.429,
        size.height * 0.677,
        size.width * 0.441,
        size.height * 0.677,
      )
      ..cubicTo(
        size.width * 0.453,
        size.height * 0.677,
        size.width * 0.464,
        size.height * 0.672,
        size.width * 0.473,
        size.height * 0.664,
      )
      ..close();
    return path;
  }

  @override
  bool shouldRepaint(CustomCircleBorder old) {
    return this != old;
  }

  @override
  operator ==(Object other) {
    if (other is CustomCircleBorder) {
      return other.runtimeType == this.runtimeType &&
          other.borderWidth == borderWidth &&
          other.circleAnimation == circleAnimation &&
          other.borderColor == borderColor &&
          other.okAnimation == okAnimation;
    }
    return false;
  }

  @override
  int get hashCode =>
      borderWidth.hashCode ^
      borderColor.hashCode ^
      circleAnimation.hashCode ^
      okAnimation.hashCode;
}
