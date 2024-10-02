
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttercuredoc/Compo/NetwokManager.dart';
import 'package:fluttercuredoc/Compo/userModel.dart';
import 'package:fluttercuredoc/Compo/user_repo.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
class UserController extends GetxController{
  static UserController get instance=>Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }
  //fetcxh user record
  Future<void> fetchUserRecord()async{
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e){
      user(UserModel.empty());
    }finally{
      profileLoading.value = false;
    }
  }

  //save user record from register
  Future<void> saveUserRecord(UserCredential? userCredentials) async{
    try {
      await fetchUserRecord();
      if(user.value.id.isEmpty){
      if (userCredentials != null) {
        // final fullName = UserModel.nameParts(userCredentials.user!.displayName ?? '');
        final username = UserModel.generateUsername(
            userCredentials.user!.displayName ?? '');
        //map data
        final user = UserModel(id: userCredentials.user!.uid,
          fullName: userCredentials.user!.displayName ?? '',
          username: username,
          email: userCredentials.user!.email ?? '',
          phoneNo: userCredentials.user!.phoneNumber ?? '',
          profilePicture: userCredentials.user!.photoURL ?? '',);

        await userRepository.saveUserRecord(user);
      }
    }
    }catch(e){
      NetworkManager.errorSnackBar(title: 'no data saved',message: 'something went wrong while saving data');
    }
  }

  uploadUserProfilePicture() async{
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        final imagUrl =
            await userRepository.uploadImage('assets/images/', image);

        Map<String, dynamic> json = {'ProfilePicture': imagUrl};
        await userRepository.updateSingleField(json);

        user.update((val) {
          val?.profilePicture = imagUrl;
        });

        // user.value.profilePicture = imagUrl;
        NetworkManager.successSnackBar(
            title: 'Congo', message: 'picture update');
      }
    } catch(e){
      NetworkManager.errorSnackBar(title: 'Oh snap',message: 'picture wrong:$e');
    }
  }
}