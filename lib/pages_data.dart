import 'package:flutter/material.dart';
import 'package:june_design_challenges/pages/derolez_portifolio/derolez_page.dart';
import 'package:june_design_challenges/pages/drag_and_drop/drag_and_drop_page.dart';
import 'package:june_design_challenges/pages/ecotourism_website/ecotourism_page.dart';
import 'package:june_design_challenges/pages/home_page.dart';
import 'package:june_design_challenges/pages/light_ray/light_ray_page.dart';
import 'package:june_design_challenges/pages/parallax_scrolling/parallax_scrolling_page.dart';
import 'package:june_design_challenges/pages/shimmer_loading_effect.dart/shimmer_loading_page.dart';
import 'package:june_design_challenges/pages/typing_indicator/typing_indicator_page.dart';

final List<PageData> pages = [
  const PageData(
    title: 'Derolez Page',
    url: 'https://derolez.dev/',
    description: 'Clone of derolez Website',
    difficulty: Difficulty.intermediate,
    icon: Icons.web_rounded, //language_rounded
    pageWidget: DerolezPage(),
  ),
  const PageData(
    title: 'Drag and Drop',
    description:
        'A page with a simple drag and drop system simulating a player acquisition cost for a football team.',
    difficulty: Difficulty.easy,
    icon: Icons.move_up,
    pageWidget: DragAndDropPage(),
  ),
  const PageData(
    title: 'Design of an Ecotourism website',
    description:
        'A design of a website page for a travel agency (inspiration is below).',
    difficulty: Difficulty.intermediate,
    url:
        'https://blog.codemagic.io/flutter-web-getting-started-with-responsive-design/',
    //grass
    icon: Icons.eco_rounded,
    pageWidget: EcotourismPage(),
  ),
  const PageData(
    title: 'Light Ray Animation',
    description: 'Demonstration of a light ray animation',
    difficulty: Difficulty.easy,
    icon: Icons.flash_on_rounded,
    pageWidget: LightRayPage(),
  ),
  const PageData(
    title: 'Parallax Animation',
    description: 'A parallax Scrolling animation',
    difficulty: Difficulty.intermediate,
    icon: Icons.view_carousel_rounded,
    pageWidget: ParallaxScrollingPage(),
  ),
  const PageData(
    title: 'Shimmer Loading Effect',
    description: 'A shimmer loading effect animation',
    difficulty: Difficulty.easy,
    icon: Icons.view_carousel_rounded,
    pageWidget: ShimmerLoadingPage(),
  ),
  const PageData(
    title: 'Typing indicator Page',
    description:
        'Just a design demonstrating an indicator of typing on a chat.',
    difficulty: Difficulty.easy,
    icon: Icons.view_compact_rounded,
    pageWidget: TypingIndicatorPage(),
  ),
];
