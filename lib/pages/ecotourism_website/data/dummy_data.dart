import 'package:june_design_challenges/pages/ecotourism_website/data/destination.dart';
import 'package:june_design_challenges/pages/ecotourism_website/data/feature.dart';

const bgImage = _w3;

const _w3 = 'assets/images/eco/w3.jpg';

final featuresList = [
  Feature(
    title: 'Trekking',
    image: 'assets/images/eco/features/p1.jpg',
  ),
  Feature(
    title: 'Animals',
    image: 'assets/images/eco/features/p2.jpg',
  ),
  Feature(
    title: 'Places',
    image: 'assets/images/eco/features/p5.jpg',
  ),
  Feature(
    title: 'Photography',
    image: 'assets/images/eco/features/p3.jpg',
  ),
  Feature(
    title: 'Space',
    image: 'assets/images/eco/features/p4.jpg',
  ),
]..shuffle();

final destinationsList = [
  Destination(
    image: 'assets/images/eco/destinations/p6.jpg',
    name: 'Africa',
  ),
  Destination(
    image: 'assets/images/eco/destinations/p5.jpg',
    name: 'Asia',
  ),
  Destination(
    image: 'assets/images/eco/destinations/p4.jpg',
    name: 'Australia',
  ),
  Destination(
    image: 'assets/images/eco/destinations/p1.jpg',
    name: 'Europe',
  ),
  Destination(
    image: 'assets/images/eco/destinations/p2.jpeg',
    name: 'North America',
  ),
  Destination(
    image: 'assets/images/eco/destinations/p3.jpg',
    name: 'S. America',
  ),
]..shuffle();
