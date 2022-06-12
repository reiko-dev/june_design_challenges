import 'package:flutter/material.dart';
import 'package:june_design_challenges/pages/drag_and_drop/data/player.dart';
import 'package:june_design_challenges/pages/drag_and_drop/data/team.dart';
import 'package:june_design_challenges/pages/drag_and_drop/utils.dart';

class TeamListItem extends StatefulWidget {
  const TeamListItem({
    Key? key,
    required this.team,
  }) : super(key: key);

  final Team team;

  @override
  TeamListItemState createState() => TeamListItemState();
}

class TeamListItemState extends State<TeamListItem> {
  Color bgColor = Colors.grey.shade200;

  void onAccept(Object player) {
    widget.team.players.add(player as Player);
    bgColor = Colors.grey.shade200;
  }

  void onLeave(Object? player) {
    setState(() {
      bgColor = Colors.grey.shade200;
    });
  }

  bool onWillAccept(Object? player) {
    assert(player is Player, 'player must be typed as a Player data object.');
    bool result = false;
    player = player as Player;
    if (player.price == null || widget.team.players.contains(player)) {
      bgColor = Colors.red;
    } else {
      bgColor = Colors.blue;
      result = true;
    }

    return result;
  }

  //Called after the onAccept
  void onAcceptWithDetails(DragTargetDetails<Object> d) {}

  String getCosts() {
    double amount = 0;
    for (var player in widget.team.players) {
      amount += player.price ?? 0;
    }

    return priceToString(amount);
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      onAccept: onAccept,
      onWillAccept: onWillAccept,
      onLeave: onLeave,
      onAcceptWithDetails: onAcceptWithDetails,
      builder: (context, candidateData, rejectedData) {
        return Card(
          margin: const EdgeInsets.all(10),
          color: bgColor,
          elevation: 10,
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage(widget.team.image),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: Text(widget.team.name),
                  ),
                ),
              ),
              if (widget.team.players.isNotEmpty)
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      child: Text('Acquisition(s) cost: ${getCosts()}'),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
