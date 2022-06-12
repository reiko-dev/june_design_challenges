import 'package:flutter/material.dart';
import 'package:june_design_challenges/pages/home_page.dart';
import 'package:june_design_challenges/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //Allow scrolling on horizontal using Mouse.
      scrollBehavior: const MyCustomScrollBehavior(),
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}
