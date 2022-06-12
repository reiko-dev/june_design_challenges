import 'package:flutter/material.dart';

class Work {
  final int key;
  final Color color;
  final IconData iconData;
  final String title;
  final String subTitle;
  final String description;
  final List<String> tags;
  final List<String> images;

  const Work({
    required this.key,
    required this.color,
    required this.iconData,
    required this.subTitle,
    required this.title,
    required this.description,
    required this.tags,
    required this.images,
  });

  @override
  String toString() {
    return 'Work(title: $title, subtitle: $subTitle';
  }
}

List<Work> works = [
  const Work(
      key: 0,
      color: Colors.white,
      iconData: Icons.text_snippet_rounded,
      title: 'Everpress',
      tags: ['React', 'Next.js', 'GraphQL', 'styled-components'],
      images: [
        'assets/images/derolez/p1.jpg',
        'assets/images/derolez/p2.jpg',
        'assets/images/derolez/p3.jpg',
      ],
      subTitle:
          'ermentum venenatis, ligula dui faucibus risus, vitae dictum nisl nunc nec nulla.',
      description:
          'Everpress is a global marketplace for independent creativity. By offering the tools to sell, manufacture and distribute your own creations; we’re changing the way things get made. No risk. No waste.\n\n'
          'At Everpress, I was responsible for quite a few marketing pages, maintained the website all-round for solid year and a half, and A/B-tested the guest checkout on the e-commerce side.'),
  const Work(
    key: 1,
    color: Colors.amber,
    iconData: Icons.mic_none_rounded,
    title: 'ICON',
    tags: ['React', 'GSAP'],
    images: [
      'assets/images/derolez/p6.jpg',
      'assets/images/derolez/p4.jpg',
      'assets/images/derolez/p5.jpg',
    ],
    subTitle:
        'Sed ornare odio sit amet risus imperdiet, at consequat mi hendrerit',
    description:
        'Custom merch gets a bad rap. For good reason: it’s often cheaply made, badly designed, and quickly headed for the bin.\n'
        'ICON\'s here to change all that.'
        ' \n\nComplete rebuild of ICON’s site featuring a custom quote tool,marketing pages, blog, and a full admin area for their customers.',
  ),
  const Work(
    key: 2,
    color: Colors.grey,
    iconData: Icons.audiotrack,
    title: 'Fnatic Gear',
    tags: ['React', 'Gatsby', 'CSS Modules', 'Shopify'],
    images: [
      'assets/images/derolez/p4.jpg',
      'assets/images/derolez/p6.jpg',
      'assets/images/derolez/p5.jpg',
    ],
    subTitle:
        'ermentum venenatis, ligula dui faucibus risus, vitae dictum nisl nunc nec nulla.',
    description:
        'FNATIC is a global esports performance brand headquartered in London, laser-focused on seeking out, levelling up and amplifying gamers and creators.\n\n'
        'At Fnatic, I was responsible for building out a complete marketing site for the launch of their new hardware line(GEAR) with some nice animations and interactions. On the software side, I built the best, most bug-free colour selector you will have ever seen. Let it be known I helped achieve your RGB dreams, you\'re welcome.',
  ),
  const Work(
    key: 3,
    color: Colors.pink,
    iconData: Icons.gamepad,
    title: 'Mariah or Messiah',
    tags: ['React', 'Tailwind CSS'],
    images: [
      'assets/images/derolez/p5.jpg',
      'assets/images/derolez/p4.jpg',
      'assets/images/derolez/p6.jpg',
    ],
    subTitle:
        'Sed ornare odio sit amet risus imperdiet, at consequat mi hendrerit',
    description:
        'Mariah or Messiah was built as part of a hackathon with the aim of creating a fun (and rather silly!) Christmas card. Whilst generating publicity for Neverbland, it also helped raise money for the Hackney Winter Night Shelter charity. The quiz makes heavy use of the Greensock library to facilitate all the animations.\n\n'
        'When you REALLY think about it, Christmas is about two people: Jesus Christ and Mariah Carey. One is the son of God, the other is an American singer with 8 Jack Russells and a 5 octave range. But which of these two seasonal superstars is responsible for the following quotes?\n\n'
        'Let’s play Mariah or Messiah!',
  ),
];
