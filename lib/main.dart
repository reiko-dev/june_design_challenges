import 'package:flutter/material.dart';
import 'package:june_design_challenges/ecotourism_website/ecotourism_main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EcotourismMainPage(),
    );
  }
}
