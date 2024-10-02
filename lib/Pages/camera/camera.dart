import 'package:flutter/material.dart';
import 'package:fluttercuredoc/Navbar/nav_menu.dart';
import 'package:fluttercuredoc/Pages/chatbot/chat.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import 'newBg.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  void pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      // Instead of navigating to ChatScreen directly, change the index
      final controller = Get.find<NavigationController>();
      controller.currentIndex.value = 2; // Assuming ChatScreen is at index 2
    }
  }

  @override
  void initState() {
    super.initState();
    requestCameraPermission(); // Request permissions when the widget initializes
  }

  Future<void> requestCameraPermission() async {
    if (await Permission.camera.request().isGranted) {
      // Camera permission granted
    } else {
      // Handle the case when permission is denied
      print("Camera permission denied.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Backgrounds(), // Add the Backgrounds widget here

          Center(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Use Gallery Button
                    GestureDetector(
                      onTap: () async {
                        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          setState(() {
                            _image = File(pickedFile.path);
                          });
                          // Navigate to ChatScreen with the selected image
                          final controller = Get.find<NavigationController>();
                          controller.setSelectedImage(_image); // Set selected image in controller
                          controller.currentIndex.value = 2;
                        }
                      },
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3), // Shadow color
                              offset: Offset(0, 4), // Shadow offset
                              blurRadius: 10, // Shadow blur radius
                              spreadRadius: 2, // Shadow spread radius
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.photo, size: 40, color: Colors.white),
                            SizedBox(height: 10),
                            Text("Use Gallery", style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    // Use Camera Button
                    GestureDetector(
                      onTap: () async {
                        try {
                          final pickedFile = await _picker.pickImage(source: ImageSource.camera);
                          if (pickedFile != null) {
                            setState(() {
                              _image = File(pickedFile.path);
                            });
                            // Instead of navigating to ChatScreen directly, change the index
                            final controller = Get.find<NavigationController>();
                            controller.setSelectedImage(_image); // Set selected image in controller
                            controller.currentIndex.value = 2;
                          } else {
                            print("No image selected.");
                          }
                        } catch (e) {
                          print("Error accessing camera: $e");
                        }
                      },
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3), // Shadow color
                              offset: Offset(0, 4), // Shadow offset
                              blurRadius: 10, // Shadow blur radius
                              spreadRadius: 2, // Shadow spread radius
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt, size: 40, color: Colors.white),
                            SizedBox(height: 10),
                            Text("Use Camera", style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
