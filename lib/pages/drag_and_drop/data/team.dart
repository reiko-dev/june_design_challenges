import 'package:june_design_challenges/pages/drag_and_drop/data/player.dart';

class Team {
  final String name;
  final String coach;
  final String image;
  final Set<Player> players = {};
  Team({required this.name, required this.coach, required this.image});
}
