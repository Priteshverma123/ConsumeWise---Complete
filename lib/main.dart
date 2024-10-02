import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fluttercuredoc/AuthenticationRepository.dart';
import 'package:fluttercuredoc/Compo/NetwokManager.dart';
import 'package:fluttercuredoc/Compo/general_binding.dart';
import 'package:fluttercuredoc/LogSign/Welcome.dart';
import 'package:fluttercuredoc/OnBoardingScreen/OnBoardingScreen.dart';
import 'package:fluttercuredoc/provider/chat_provider.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';


Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool('onboarding')??false;
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).
  then((FirebaseApp value)=> Get.put(AuthenticationRepository()),);
  await GetStorage.init();
  Get.put(AuthenticationRepository());

  runApp(MyApp(onboarding: onboarding));
  Get.put(NetworkManager());
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  const MyApp({super.key,this.onboarding = false});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create:(context)=>ChatProvider(),
        child: Consumer<ChatProvider>(
          builder: (context,chatProvider,child){
            return GetMaterialApp(
              initialBinding: GeneralBindings(),
              title: 'My Flutter App',
              home: onboarding ? WelcomeScreen() : OnboardingScreen(),
            );
          },
        ),
    );
  }
}

//#76B2E4
//#FFC83A
