import 'package:flutter/material.dart';
import 'package:june_design_challenges/drag_and_drop/drag_and_drop_page.dart';
import 'package:june_design_challenges/drag_and_drop/models/player.dart';
import 'package:june_design_challenges/drag_and_drop/models/team.dart';

class TeamListItem extends StatefulWidget {
  const TeamListItem({
    Key? key,
    required this.team,
  }) : super(key: key);

  final Team team;

  @override
  _TeamListItemState createState() => _TeamListItemState();
}

class _TeamListItemState extends State<TeamListItem> {
  Color bgColor = Colors.grey.shade200;

  void onAccept(Object player) {
    widget.team.players.add(player as Player);
    bgColor = Colors.grey.shade200;
  }

  void onLeave(Object? player) {
    bgColor = Colors.grey.shade200;
    setState(() {});
  }

  bool onWillAccept(Object? player) {
    bool result = false;
    if (player != null && player is Player) {
      if (player.name != 'Neymar') {
        bgColor = Colors.blue;
        result = true;
      } else {
        bgColor = Colors.red;
      }
    }

    return result;
  }

  //Called after the onAccept
  void onAcceptWithDetails(DragTargetDetails<Object> d) {}

  String getCosts() {
    double amount = 0;
    widget.team.players.forEach((player) {
      amount += player.price;
    });

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
          margin: EdgeInsets.all(10),
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
                        image: NetworkImage(widget.team.image),
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
                      child: Text('Aquisition(s) cost: ${getCosts()}'),
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
