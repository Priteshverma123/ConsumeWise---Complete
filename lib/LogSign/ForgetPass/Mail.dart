import 'package:flutter/material.dart';
import 'package:fluttercuredoc/LogSign/ForgetPass/forget_password_backend.dart';
import 'package:fluttercuredoc/LogSign/SignUp/Header.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPasswordMailScreen extends StatelessWidget {
  const ForgetPasswordMailScreen({Key? key}) : super(key: key);

  static String? validateEmail(String? value){
    if(value == null || value.isEmpty){
      return 'email is required..';
    }
    final emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if(!emailRegExp.hasMatch(value)){
      return'Invalid Email..';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    final controller =Get.put(ForgetPasswordController());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const SizedBox(height: 30 * 4),
                FormHeaderWidget(
                  image: 'assets/images/profile.png',
                  title: 'Forget Password'.toUpperCase(),
                  crossAxisAlignment: CrossAxisAlignment.center,
                  heightBetween: 30.0,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Form(
                  key: controller.forgetPasswordFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.email,
                        validator: validateEmail,
                        decoration: const InputDecoration(
                            label: Text('Email'),
                            hintText: 'Email',
                            prefixIcon: Icon(Iconsax.direct_right)),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () =>controller.sendPasswordResetEmail(),
                              child: const Text('Next'))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
