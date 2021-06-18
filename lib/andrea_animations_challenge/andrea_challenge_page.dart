import 'package:flutter/material.dart';
import 'package:june_design_challenges/andrea_animations_challenge/animated_button.dart';

class AndreaChallengePage extends StatelessWidget {
  const AndreaChallengePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedButton(
                  borderWidth: 10,
                  iconData: Icons.audiotrack,
                  primaryColor: Colors.green,
                  secondaryColor: Colors.black87,
                  borderColor: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedButton(
                  borderWidth: 10,
                  iconData: Icons.audiotrack,
                  primaryColor: Colors.blue,
                  secondaryColor: Colors.amber,
                  borderColor: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
