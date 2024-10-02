import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserModel{
  final String id;
  String fullName;
  final String username;
  final String email;
  String phoneNo;
  String profilePicture;


UserModel({
  required this.id,
  required this.fullName,
  required this.username,
  required this.email,
  required this.phoneNo,
  required this.profilePicture,
});

static UserModel empty()=> UserModel(id: '', fullName: '', username: '', email: '', phoneNo: '', profilePicture: '');

//static List<String> nameParts(fullName) =>fullName.split(" ");
static String generateUsername(fullName){
   String camelCaseUsername = "$fullName";
   String usernameWithPrefix = 'pat_$camelCaseUsername';
   return usernameWithPrefix;
}

Map<String,dynamic> toJson(){
  return{
    'FullName':fullName,
    'UserName':username,
    'Email':email,
    'PhoneNo':phoneNo,
    'ProfilePicture':profilePicture,
  };
}

factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>>document){
  if(document.data() !=null){
    final data = document.data()!;
    return UserModel(id: document.id, fullName: data['FullName'] ??'', username: data['UserName']??'', email: data['Email'] ??'', phoneNo: data['PhoneNo']??'', profilePicture: data['ProfilePicture']??'',);
  }else{
    return UserModel.empty();
  }
}

}