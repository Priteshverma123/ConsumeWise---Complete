import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fluttercuredoc/LogSign/Login/Login.dart';
import 'package:fluttercuredoc/LogSign/SignUp/VerifyEmail.dart';
import 'package:fluttercuredoc/LogSign/Welcome.dart';
import 'package:fluttercuredoc/Navbar/nav_menu.dart';
import 'package:fluttercuredoc/OnBoardingScreen/OnBoardingScreen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  //Auth user data
  User? get authUser => _auth.currentUser;

  //call from main.dart on app Launch
  @override
  void onReady() {
    screenRedirect();
  }

  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmail(email: _auth.currentUser?.email));
      }
    } else {
      if (kDebugMode) {
        print('======get storage=====');
        print(deviceStorage.read('IsFirstTime'));
      }

      deviceStorage.writeIfNull('IsFirstTime', true);
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const WelcomeScreen())
          : Get.offAll(const OnboardingScreen());
    }
  }

  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      print('Authentication error: $e'); // Log the error for debugging
      if (e.toString().contains('email-already-in-use')) {
        throw 'Email is already in use by another account';
      } else {
        throw 'oOOOOPSSSSS'; // For other errors
      }
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      print('Authentication error: $e'); // Log the error for debugging
      if (e.toString().contains('email is not send')) {
        throw 'Email is not sending';
      } else {
        throw 'oOOOOPSSSSS Email'; // For other errors
      }
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      print('Authentication error: $e'); // Log the error for debugging
      if (e.toString().contains('reset password email is not send')) {
        throw 'Reset password Email is not sending';
      } else {
        throw 'oOOOOPSSSSS reset password Email'; // For other errors
      }
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      return await _auth.signInWithCredential(credentials);
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      print('Google error: $e'); // Log the error for debugging
      if (e.toString().contains('google is not send')) {
        throw 'Google error';
      } else {
        throw 'oOOOOPSSSSS Google'; // For other errors
      }
    }
  }

  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      print('Login error: $e'); // Log the error for debugging
      if (e.toString().contains('Login error :::sryy')) {
        throw 'LOGIN ERROR!!!!!';
      } else {
        throw 'oOOOOPSSSSS LOGIN'; // For other errors
      }
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      print('LOGOUT: $e'); // Log the error for debugging
      if (e.toString().contains('logout is not send')) {
        throw 'not logout';
      } else {
        throw 'oOOOOPSSSSS logout'; // For other errors
      }
    }
  }
}
