import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttercuredoc/Compo/profile_menu.dart';
import 'package:fluttercuredoc/Compo/user_controller.dart';
import 'package:fluttercuredoc/LogSign/Welcome.dart';
import 'package:fluttercuredoc/Profile/ChangeName.dart';
import 'package:fluttercuredoc/Update_Phoneno/ChangePhoneno.dart';
import 'package:get/get.dart';


class EditProfile extends StatelessWidget {
  const EditProfile({
    Key? key,
    this.isNetworkImage = false,
  }) : super(key: key);

  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();
    return Scaffold(
      appBar: AppBar(
        // Add a tooltip for accessibility
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty
                          ? networkImage
                          : 'assets/images/profile.png';
                      return Container(
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100,),
                          child: Center(
                            child: networkImage.isNotEmpty
                                ? CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: image,
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )
                                : Image(
                              fit: BoxFit.cover,
                              image: isNetworkImage
                                  ? NetworkImage(image)
                                  : AssetImage(image) as ImageProvider,
                              height: 120,
                              width: 120,
                            ),
                          ),
                        ),
                      );
                    }),
                    TextButton(
                      onPressed: () => controller.uploadUserProfilePicture(),
                      child: Text("Change profile picture"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    "Profile information",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ProfileMenu(
                title: 'Name',
                value: controller.user.value.fullName,
                onPressed: () => Get.to(() => ChangeName()),
              ),
              ProfileMenu(
                title: 'Username',
                value: controller.user.value.username,
                onPressed: () {},
              ),

              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),

              Row(
                children: [
                  Text(
                    "Personal information",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              ProfileMenu(
                title: 'User ID',
                value: controller.user.value.id,
                icon: Icons.copy,
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'E-mail',
                value: controller.user.value.email,
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Phone Number',
                value: controller.user.value.phoneNo,
                onPressed: () => Get.to(() => ChangePhone()),
              ),
              ProfileMenu(
                title: 'Gender',
                value: 'COding_cod',
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Date of Birth',
                value: 'COding_cod',
                onPressed: () {},
              ),

              const Divider(),
              const SizedBox(height: 16),

              Center(
                child: TextButton(
                  onPressed: () {
                    Get.offAll(()=>const WelcomeScreen());
                  },
                  child:const  Text(
                    "Log out",
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
