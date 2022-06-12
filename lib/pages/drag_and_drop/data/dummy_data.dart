import 'package:june_design_challenges/pages/drag_and_drop/data/player.dart';
import 'package:june_design_challenges/pages/drag_and_drop/data/team.dart';

final players = [
  const Player(
    name: 'Neymar',
    img: 'assets/images/dragdrop/players/neymar.jpg',
  ),
  const Player(
    name: 'Ronaldo Fenômeno',
    price: 300000000,
    img: 'assets/images/dragdrop/players/ronaldo.jpg',
  ),
  const Player(
    name: 'Ronaldinho',
    price: 310000000,
    img: 'assets/images/dragdrop/players/ronaldinho.jpg',
  ),
  const Player(
    name: 'Pelé',
    price: 1000000000,
    img: 'assets/images/dragdrop/players/pele.jpg',
  ),
];

final teams = [
  Team(
    name: 'Chelsea',
    coach: 'Mourinho',
    image: 'assets/images/dragdrop/teams/chelsea.png',
  ),
  Team(
    name: 'Real Madrid',
    coach: 'Zidane',
    image: 'assets/images/dragdrop/teams/realmadrid.png',
  ),
  Team(
    name: 'Barcelona',
    coach: 'Ronald Koeman',
    image: 'assets/images/dragdrop/teams/barca.png',
  ),
  Team(
    name: 'Liverpool',
    coach: 'Jürgen Klopp',
    image: 'assets/images/dragdrop/teams/liverpool.png',
  ),
];
