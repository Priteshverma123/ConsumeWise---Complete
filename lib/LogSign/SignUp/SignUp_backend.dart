import 'package:flutter/material.dart';
import 'package:fluttercuredoc/AuthenticationRepository.dart';
import 'package:fluttercuredoc/Compo/NetwokManager.dart';
import 'package:fluttercuredoc/Compo/full_screen_loader.dart';
import 'package:fluttercuredoc/Compo/user_repo.dart';
import 'package:fluttercuredoc/LogSign/SignUp/VerifyEmail.dart';
import 'package:get/get.dart';

import '../../Compo/userModel.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final fullName = TextEditingController();
  final userName = TextEditingController();
  final email = TextEditingController();
  final phoneNo = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signup() async {
    try {
      // Internet check
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
       // FullScreenLoader.stopLoading();
        return;
      }

      // Form Validator
      if (!signupFormKey.currentState!.validate()){
       // FullScreenLoader.stopLoading();
        return;
      }

      // Loading
      FullScreenLoader.openLoadingDialog('we are Processing', 'assets/images/Animation - 1704652756931.json');

      // Proceed with signup logic
      // ...
      final userCredential=await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

     final newUser =UserModel(id: userCredential.user!.uid, fullName: fullName.text.trim(), username: userName.text.trim(), email: email.text.trim(), phoneNo: phoneNo.text.trim(), profilePicture: '');

     final userRepository = Get.put(UserRepository());
     await userRepository.saveUserRecord(newUser);

    //  FullScreenLoader.stopLoading();

      NetworkManager.successSnackBar(title: 'CONGOOO',message: 'veridied email');

      Get.to(()=>VerifyEmail(email:email.text.trim()));
    } catch (e) {
      print('Signup error: $e'); // Log the error for debugging
      if (e == 'Email is already in use by another account') {
        NetworkManager.errorSnackBar(title: 'Oh SSSSnap', message: 'Email is already in use by another account');
      } else {
        NetworkManager.errorSnackBar(title: 'Oh SSSSnap', message: 'Signup failed: $e');
      }
    }
    // finally {
    //   // Stop loading dialog regardless of success or failure
    //   FullScreenLoader.stopLoading();
    // }
  }


}
