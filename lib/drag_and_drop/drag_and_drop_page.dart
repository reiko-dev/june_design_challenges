import 'package:flutter/material.dart';
import 'package:june_design_challenges/drag_and_drop/models/player.dart';
import 'package:june_design_challenges/drag_and_drop/models/team.dart';
import 'package:june_design_challenges/drag_and_drop/player_list_item.dart';
import 'package:june_design_challenges/drag_and_drop/team_list_item.dart';

class DragAndDropPage extends StatefulWidget {
  const DragAndDropPage({Key? key}) : super(key: key);

  @override
  _DragAndDropPageState createState() => _DragAndDropPageState();
}

class _DragAndDropPageState extends State<DragAndDropPage> {
  final players = [
    Player(
      name: 'Neymar',
      price: 200000000,
      img:
          'https://mediastorage.cnnbrasil.com.br/IMAGES/00/00/02/21995_47022457A67E1FF5.jpg',
    ),
    Player(
      name: 'Ronaldo Fenômeno',
      price: 300000000,
      img:
          'https://staticr1.blastingcdn.com/p/4/2017/10/19/v_640x360/84376dbd-f826-44c4-af0c-fd918602a42d.jpg',
    ),
    Player(
      name: 'Ronaldinho',
      price: 310000000,
      img:
          'http://discoveryfootball.com/wp-content/uploads/2020/03/RONNIE2.jpg',
    ),
    Player(
      name: 'Pelé',
      price: 1000000000,
      img:
          'https://d2zrcpifq2l28q.cloudfront.net/wp-content/uploads/2021/02/25114352/11.png',
    ),
  ]..sort((a, b) => b.price.compareTo(a.price));

  final teams = [
    Team(
      name: 'Chelsea',
      coach: 'Mourinho',
      image:
          'https://logodownload.org/wp-content/uploads/2017/02/chelsea-fc-logo-escudo.png',
    ),
    Team(
      name: 'Real Madrid',
      coach: 'Zidane',
      image:
          'https://i2.wp.com/www.pngitem.com/pimgs/m/87-879780_real-madrid-cf-hd-logo-png-logo-do.png',
    ),
    Team(
      name: 'Barcelona',
      coach: 'Ronald Koeman',
      image:
          'https://logodownload.org/wp-content/uploads/2015/05/Barcelona-logo-escudo.png',
    )
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: size.width * .9,
                height: size.height * 0.08,
                child: FittedBox(
                  child: Text('Players'),
                ),
              ),
              SizedBox(
                width: size.width * .9,
                height: size.height * 0.65,
                child: PlayersCarousel(players: players),
              ),
              SizedBox(
                width: size.width * .9,
                height: size.height * 0.08,
                child: FittedBox(
                  child: Text('Teams'),
                ),
              ),
              SizedBox(
                width: size.width * .9,
                height: size.height * 0.35,
                child: TeamCarousel(teams: teams),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TeamCarousel extends StatelessWidget {
  const TeamCarousel({
    Key? key,
    required this.teams,
  }) : super(key: key);

  final List<Team> teams;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ListView.builder(
      itemCount: teams.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Center(
          child: SizedBox(
            width: 350,
            height: size.height * .35,
            child: TeamListItem(team: teams[index]),
          ),
        );
      },
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

    return Card(
      margin: EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                height: size.height * .3,
                width: size.width,
                child: PlayerListItem(
                  player: players[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

String priceToString(double price) {
  String result = (price / 1000000).toStringAsFixed(1);
  return '\$ $result M';
}
