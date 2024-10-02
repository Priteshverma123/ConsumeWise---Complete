import 'dart:math';
import 'package:flutter/material.dart';

class Backgrounds extends StatelessWidget {
  const Backgrounds({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          // More Coffee Beans
          CoffeBean(degrees: 190, right: 160, top: 90),
          CoffeBean(degrees: 90, left: -50, top: 5),
          CoffeBean(degrees: 10, left: -70, top: 690),
          CoffeBean(degrees: 75, right: -20, top: 150),
          CoffeBean(degrees: 100, right: -70, top: 300),
          CoffeBean(degrees: 155, right: 70, top: 550),
          CoffeBean(degrees: 155, right: 70, top: 550),
          CoffeBean(degrees: 10, right: -30, top: 10),
          CoffeBean(degrees: 45, left: 10, top: 400),
          CoffeBean(degrees: 30, left: 50, top: 250),
          CoffeBean(degrees: 120, right: 100, top: 780),
          CoffeBean(degrees: 60, right: 50, top: 400),
          CoffeBean(degrees: 120, right: 100, top: 80),
          CoffeBean(degrees: 60, right: 50, top: 700),
          CoffeBean(degrees: 135, right: 40, top: 450),
          CoffeBean(degrees: 60, left: 70, top: 500),
          // More New Icon
        ],
      ),
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
        child: Opacity(
          opacity: 0.2, // Set the opacity level here
          child: Image.asset(
            'assets/images/Idea.png', // Use your PNG image here
            width: 150, // Adjust the size as needed
          ),
        ),
      ),
    );
  }
}

class RotatingIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const RotatingIcon({
    super.key,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Random rotation degrees for the icon
    double degrees = Random().nextDouble() * 360;

    return Transform.rotate(
      angle: degrees * pi / 180,
      child: Opacity(
        opacity: 0.5, // Adjust opacity for the icons
        child: Icon(
          icon,
          size: 50, // Adjust size as needed
          color: color,
        ),
      ),
    );
  }
}
