import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttercuredoc/AuthenticationRepository.dart';
import 'package:fluttercuredoc/Compo/userModel.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

//save user data in FB
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      throw 'OOOOPSSSSSyyy';
    }
  }

//fetch USer data
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).get();
      if(documentSnapshot.exists){
        return UserModel.fromSnapshot(documentSnapshot);
      }else{
        return UserModel.empty();
      }
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      throw 'OOOOPSSSSSyyy fetching';
    }
  }

  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db.collection("Users").doc(updatedUser.id).update(updatedUser.toJson());
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      throw 'OOOOPSSSSSyyy update';
    }
  }

  Future<void> updateSingleField(Map<String, dynamic>json) async {
    try {
      await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).update(json);
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      throw 'OOOOPSSSSSyyy update';
    }
  }

  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      throw 'OOOOPSSSSSyyy delete';
    }
  }

  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      throw 'OOOOPSSSSSyyy image upload';
    }
  }
}
