import 'package:flutter/material.dart';
import 'package:fluttercuredoc/LogSign/Login/login_backend.dart';
import 'package:fluttercuredoc/LogSign/SignUp/Signup.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        const SizedBox(height: 30 - 20),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Image(image: AssetImage('assets/images/google.png'), width: 20.0),
            onPressed: () =>controller.googleSignIn(),
            label: const Text('Google',style: TextStyle(color: Colors.black),),
          ),
        ),
        const SizedBox(height: 30 - 20),
        TextButton(
          onPressed: () {
            Get.to(() => SignUpScreen());
          },
          child: Text.rich(
            TextSpan(
                text: "Don't have an Account?",
                style: TextStyle(color: Colors.black),
                children: const [
                  TextSpan(text: "Signup", style: TextStyle(color: Colors.blue))
                ]),
          ),
        ),
      ],
    );
  }
}