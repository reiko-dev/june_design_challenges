import 'package:flutter/material.dart';
import 'package:june_design_challenges/pages/drag_and_drop/data/player.dart';
import 'package:june_design_challenges/pages/drag_and_drop/utils.dart';

class PlayerListItem extends StatelessWidget {
  const PlayerListItem({Key? key, required this.player}) : super(key: key);

  final Player player;

  Offset dragAnchorStrategy(
      Draggable<Object> d, BuildContext context, Offset point) {
    return Offset(d.feedbackOffset.dx + 50, d.feedbackOffset.dy + 50);
  }

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<Player>(
      dragAnchorStrategy: dragAnchorStrategy,
      data: player,
      feedback: Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: Center(
            child: AspectRatio(
              aspectRatio: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(player.img),
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            flex: 4,
            child: AspectRatio(
              aspectRatio: 5 / 4,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      color: Colors.grey.withAlpha(150),
                      spreadRadius: 2,
                    ),
                  ],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(player.img),
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              child: Text(player.name),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FittedBox(
              child: player.price == null
                  ? const Text(
                      'Unavailable',
                      style: TextStyle(
                          color: Colors.red, fontStyle: FontStyle.italic),
                    )
                  : Text(priceToString(player.price!)),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
