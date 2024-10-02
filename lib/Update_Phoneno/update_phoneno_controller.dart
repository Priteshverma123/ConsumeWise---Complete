
import 'package:flutter/cupertino.dart';
import 'package:fluttercuredoc/Compo/NetwokManager.dart';
import 'package:fluttercuredoc/Compo/full_screen_loader.dart';
import 'package:fluttercuredoc/Compo/user_controller.dart';
import 'package:fluttercuredoc/Compo/user_repo.dart';
import 'package:fluttercuredoc/Profile/Profile.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class UpdatePhonenoController extends GetxController{
  static UpdatePhonenoController get instance =>Get.find();

  final phoneNo = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserPhoneNoFormKey = GlobalKey<FormState>();

  //init user data when home appear
  @override
  void onInit() {
    initializePhoneNo();
    super.onInit();
  }

  //fetch user record
  Future<void> initializePhoneNo() async{
    phoneNo.text = userController.user.value.phoneNo;
  }

  Future<void> updateUserPhoneNo() async{
    try{
      FullScreenLoader.openLoadingDialog('updating....','assets/images/Animation - 1704652756931.json');
      //check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }
      //form validation
      if (!updateUserPhoneNoFormKey.currentState!.validate()){
        FullScreenLoader.stopLoading();
        return;
      }
      //update username in FB
      Map<String, dynamic> phone={'PhoneNo':phoneNo.text.trim()};
      await userRepository.updateSingleField(phone);

      //update
      //userController.user.value.fullName = fullName.text.trim();
      userController.user.update((val) {
        val?.phoneNo = phoneNo.text.trim();
      });

      FullScreenLoader.stopLoading();

      NetworkManager.successSnackBar(title: 'COngoooo',message: 'phoneNo updated');

      Get.off(()=> ProfilePage());
      //Get.back();
    } catch(e){
      FullScreenLoader.stopLoading();
      NetworkManager.errorSnackBar(title: 'Oh snap phoneNo change',message: e.toString());
    }
  }
}