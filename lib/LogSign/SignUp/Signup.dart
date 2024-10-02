import 'package:flutter/material.dart';
import 'package:fluttercuredoc/LogSign/SignUp/Footer.dart';
import 'package:fluttercuredoc/LogSign/SignUp/Form.dart';
import 'package:fluttercuredoc/LogSign/SignUp/Header.dart';
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFD9C19D),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: const Column(
              children: [
                FormHeaderWidget(
                  image: 'assets/images/00eddc0e000879b0225c6fa1747cb8b4-removebg-preview.png',
                  title: "Get On Board!",
                  imageHeight: 0.19,
                ),
                SignUpFormWidget(),
                SignUpFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}