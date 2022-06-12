import 'package:flutter/material.dart';
import 'package:june_design_challenges/pages/drag_and_drop/data/dummy_data.dart';
import 'package:june_design_challenges/pages/drag_and_drop/data/player.dart';
import 'package:june_design_challenges/pages/drag_and_drop/player_list_item.dart';
import 'package:june_design_challenges/pages/drag_and_drop/team_list_item.dart';

class DragAndDropPage extends StatefulWidget {
  static const routeName = '/drag-n-drop';
  const DragAndDropPage({Key? key}) : super(key: key);

  @override
  DragAndDropPageState createState() => DragAndDropPageState();
}

class DragAndDropPageState extends State<DragAndDropPage> {
  final teamsKey = GlobalKey();
  double? height;

  void updateSize(double fullHeight) {
    if (teamsKey.currentContext == null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          height = teamsKey.currentContext!.size!.height;
          height = fullHeight - height!;
        });
      });
    } else {
      final box = teamsKey.currentContext!.findRenderObject() as RenderBox;
      height = box.size.height;
      height = fullHeight - height!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Drag n Drop Page'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: PlayersCarousel(players: players),
            ),
          ),
          DecoratedBox(
            key: teamsKey,
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: size.width,
                height: 230,
                child: Center(
                  child: Column(
                    children: const [
                      FittedBox(
                        child: Text('Teams'),
                      ),
                      Expanded(
                        child: TeamsCarousel(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TeamsCarousel extends StatelessWidget {
  const TeamsCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: teams.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Center(
            child: AspectRatio(
              aspectRatio: 1,
              child: TeamListItem(team: teams[index]),
            ),
          );
        },
      ),
    );
  }
}

class PlayersCarousel extends StatelessWidget {
  const PlayersCarousel({
    Key? key,
    required this.players,
  }) : super(key: key);

  final List<Player> players;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        const FittedBox(
          child: Text(
            'Players',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            children: List.generate(
              players.length,
              (index) {
                return SizedBox.square(
                  dimension: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: size.height * .3,
                          width: size.width * .2,
                          child: PlayerListItem(
                            player: players[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
