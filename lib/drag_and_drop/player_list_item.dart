import 'package:flutter/material.dart';
import 'package:june_design_challenges/drag_and_drop/drag_and_drop_page.dart';
import 'package:june_design_challenges/drag_and_drop/models/player.dart';

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
      feedback: SizedBox(
        width: 100,
        height: 100,
        child: AspectRatio(
          aspectRatio: 8 / 4,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  player.img,
                ),
              ),
            ),
          ),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            flex: 4,
            child: AspectRatio(
              aspectRatio: 8 / 4,
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
                    image: NetworkImage(
                      player.img,
                    ),
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
          SizedBox(height: 10),
          Expanded(
            child: FittedBox(
              child: Text(priceToString(player.price)),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
