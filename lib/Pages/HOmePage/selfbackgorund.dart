import 'dart:math';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: const Stack(children: [
        CoffeBean(degrees: 190, right: 160, top: 90),
        CoffeBean(degrees: 90, left: -50, top: 5),
        CoffeBean(degrees: 10, left: -70, top: 140),
        CoffeBean(degrees: 75, right: -20, top: 150),
        CoffeBean(degrees: 100, right: -70, top: 300),
        CoffeBean(degrees: 155, right: 70, top: 350),
        CoffeBean(degrees: 10, right: -30, top: 10),
      ]),
    );
  }
}

class CoffeBean extends StatelessWidget {
  final double? top, left, right, bottom, degrees;
  const CoffeBean({
    super.key,
    this.top,
    this.left,
    this.right,
    this.bottom,
    this.degrees,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Transform.rotate(
        angle: degrees! * pi / 190,
        child: Opacity( // Wrap the Image.asset with Opacity
          opacity: 0.2, // Set the opacity level here
          child: Image.asset(
            'assets/images/Idea.png',  // Use your PNG image here
            width: 150,  // Adjust the size as needed
          ),
        ),
      ),
    );
  }
}
