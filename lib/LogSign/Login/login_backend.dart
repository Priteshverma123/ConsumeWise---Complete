
import 'package:flutter/cupertino.dart';
import 'package:fluttercuredoc/AuthenticationRepository.dart';
import 'package:fluttercuredoc/Compo/NetwokManager.dart';
import 'package:fluttercuredoc/Compo/full_screen_loader.dart';
import 'package:fluttercuredoc/Compo/user_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class LoginController extends GetxController {

  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final userController = Get.put(UserController());
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();



  @override
  void onInit() {
    final rememberEmail = localStorage.read('REMEMBER_ME_EMAIL');
    final rememberPassword = localStorage.read('REMEMBER_ME_PASSWORD');

    if (rememberEmail != null) {
      email.text = rememberEmail;
    }
    if (rememberPassword != null) {
      password.text = rememberPassword;
    }
  }


  Future<void> emailAndPasswordSignIn() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'we are Processing', 'assets/images/Animation - 1704652756931.json');

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      FullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FullScreenLoader.stopLoading();
      NetworkManager.errorSnackBar(title: 'Login Snap', message: e.toString());
    }
  }

  Future<void> googleSignIn() async {
    try {
        FullScreenLoader.openLoadingDialog('Logging you in...', 'assets/images/Animation - 1704652756931.json');

        final isConnected = await NetworkManager.instance.isConnected();
        if(!isConnected){
          FullScreenLoader.stopLoading();
          return;
        }

        final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

        await userController.saveUserRecord(userCredentials);

        FullScreenLoader.stopLoading();

        AuthenticationRepository.instance.screenRedirect();
    }catch(e){
      FullScreenLoader.stopLoading();
  NetworkManager.errorSnackBar(title: 'Google Snap',message: e.toString());
  }
}

}