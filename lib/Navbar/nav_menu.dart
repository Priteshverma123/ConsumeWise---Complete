import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttercuredoc/Pages/Home.dart';
import 'package:fluttercuredoc/Pages/camera/camera.dart';
import 'package:fluttercuredoc/Pages/chatbot/chat.dart';
import 'package:fluttercuredoc/Pages/map/mappage.dart';
import 'package:fluttercuredoc/Profile/Profile.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context){
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Obx(
          ()=>SalomonBottomBar(
            currentIndex: controller.currentIndex.value,
            onTap:(index) => controller.currentIndex.value = index,
          items: [
            /// Home
            SalomonBottomBarItem(
              unselectedColor:  Colors.grey,
              icon:const Icon(Icons.home,size: 27,),
              title:const Text("Home"),
              selectedColor: const Color(0xffFFC83A),
            ),

            /// Likes
            SalomonBottomBarItem(
              unselectedColor:  Colors.grey,
              icon:const Icon(Icons.camera_alt,size: 25,),
              title:const Text("Camera"),
              selectedColor: const Color(0xffFFC83A),
            ),

            /// Search
            SalomonBottomBarItem(
              unselectedColor:  Colors.grey,
              icon:const Icon(Icons.chat_rounded,size: 25,),
              title:const Text("Chat"),
              selectedColor: const Color(0xffFFC83A),
            ),

            /// Profile
            SalomonBottomBarItem(
              unselectedColor:  Colors.grey,
              icon:const Icon(Icons.map_rounded,size: 25,),
              title:const Text("Map"),
              selectedColor: const Color(0xffFFC83A),
            ),
          ],
        ),
        ),
      ),
      body: Obx(()=> controller.screens[controller.currentIndex.value]),
    );
  }

}

class NavigationController extends GetxController{
  final Rx<int> currentIndex= 1.obs;
  File? selectedImage; // Store the selected image

  final screens = [HomePage(),CameraPage(),ChatScreen(),MapPage()];
  void setSelectedImage(File? image) {
    selectedImage = image; // Set the selected image
  }

  void clearSelectedImage() {
    selectedImage = null; // Clear the selected image
  }
}