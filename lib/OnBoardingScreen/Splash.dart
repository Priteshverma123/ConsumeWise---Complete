import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttercuredoc/OnBoardingScreen/OnBoardingScreen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 3), // Adjust the duration as needed
          ()  {
            Get.off(OnboardingScreen()); // Navigate using GetX
          }
    );

    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/images/Animation - 1704652756931.json',
          width: 400,
          height: 400,
          alignment: Alignment.center,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
