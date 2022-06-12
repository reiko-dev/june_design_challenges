import 'dart:math';

import 'package:flutter/material.dart';

final color = Colors.grey.shade300;
final rand = Random();

const _colors = <Color>[
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.purple,
  Colors.amber
];

Color get randomColor => _colors[rand.nextInt(_colors.length)];

const _texts = [
  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  'Adipiscing.',
  'Sed do eiusmod tempor incididunt.',
  'Ut labore et dolore magna aliqua.',
  'Magna aliqua.',
  'Ut enim ad.',
];

String get randomText => _texts[rand.nextInt(_texts.length)];
