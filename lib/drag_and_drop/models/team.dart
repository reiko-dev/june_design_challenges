import 'package:june_design_challenges/drag_and_drop/models/player.dart';

class Team {
  final String name;
  final String coach;
  final String image;
  final List<Player> players = [];
  Team({required this.name, required this.coach, required this.image});
}
