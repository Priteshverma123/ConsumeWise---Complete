import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttercuredoc/Compo/setting_menu.dart';
import 'package:fluttercuredoc/Compo/user_controller.dart';
import 'package:fluttercuredoc/LogSign/Welcome.dart';
import 'package:fluttercuredoc/Profile/EditProfile.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key,
    this.isNetworkImage = false,}) : super(key: key);
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final controller =UserController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 230,
                child: Column(
                  children: [
                    AppBar(title: Text('Account',style: TextStyle(fontSize: 20),),),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Obx(() {
                            final networkImage = controller.user.value.profilePicture;
                            final image = networkImage.isNotEmpty
                                ? networkImage
                                : 'assets/images/profile.png';
                            return Container(
                              width: 80,
                              height: 80,
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Center(
                                  child: networkImage.isNotEmpty
                                      ? CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: image,
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  )
                                      : Image(
                                    fit: BoxFit.cover,
                                    image: isNetworkImage ? NetworkImage(image) : AssetImage(image) as ImageProvider,
                                    height: 120,
                                    width: 120,
                                  ),
                                ),
                              ),
                            );
                          }),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => Text(
                                controller.user.value.fullName,
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                              )),
                              Obx(() => Text(
                                controller.user.value.email,
                                style: TextStyle(fontWeight: FontWeight.w400),
                              )),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditProfile()),
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16,)
                  ],
                )
            ),

            Container(
              decoration: BoxDecoration(
                  color: Color(0xFF7A9BA4FF),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
              ),
              child: Padding(padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text("Account Settings",
                          style: TextStyle(fontSize: 19,fontWeight: FontWeight.w800),),
                      ],
                    ),
                    SizedBox(height: 16,),

                    SettingMenu(icon: Icons.home,title: "My Address",subTitle:"mediccine at home",onTap: (){},),
                    SettingMenu(icon: Icons.home,title: "My Address",subTitle:"mediccine at home",onTap: (){},),
                    SettingMenu(icon: Icons.home,title: "My Address",subTitle:"mediccine at home",onTap: (){},),
                    SettingMenu(icon: Icons.home,title: "My Address",subTitle:"mediccine at home",onTap: (){},),
                    SettingMenu(icon: Icons.home,title: "My Address",subTitle:"mediccine at home",onTap: (){},),
                    SettingMenu(icon: Icons.home,title: "My Address",subTitle:"mediccine at home",onTap: (){},),
                    SettingMenu(icon: Icons.home,title: "My Address",subTitle:"mediccine at home",onTap: (){},),

                    SizedBox(height: 16,),
                    Row(
                      children: [
                        const Text("App Settings",
                          style: TextStyle(fontSize: 19,fontWeight: FontWeight.w800),),
                      ],
                    ),
                    SizedBox(height: 16,),

                    SettingMenu(icon: Icons.home,title: "My Address",subTitle:"mediccine at home",trailing: Switch(value: true,onChanged: (value){},),),
                    SettingMenu(icon: Icons.home,title: "My Address",subTitle:"mediccine at home",trailing: Switch(value: false,onChanged: (value){},),),
                    SettingMenu(icon: Icons.home,title: "My Address",subTitle:"mediccine at home",trailing: Switch(value: false,onChanged: (value){},),),

                    SizedBox(height: 16,),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          // Use Get.to instead of Navigator.push
                          Get.to(WelcomeScreen());
                        },child: Text('Logout'),
                      ),
                    ),
                    SizedBox(height: 16,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
