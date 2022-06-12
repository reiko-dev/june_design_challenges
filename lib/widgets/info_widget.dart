import 'package:flutter/material.dart';

class InfoWdiget extends StatefulWidget {
  const InfoWdiget(
      {super.key,
      this.duration = const Duration(milliseconds: 2500),
      required this.text});

  final Duration duration;
  final String text;

  @override
  State<InfoWdiget> createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWdiget>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Visibility(
            visible: controller.value > 0,
            child: Opacity(
              opacity: 1 - controller.value,
              child: child,
            ),
          );
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.15),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.text, style: const TextStyle(fontSize: 30)),
          ),
        ),
      ),
    );
  }
}
