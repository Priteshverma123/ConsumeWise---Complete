import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class NetworkManager extends GetxController {
  static successSnackBar({required title,message=''}) {
    Get.snackbar(title, message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.black,
      backgroundColor: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(20),
      icon: Icon(Icons.warning_amber,color: Colors.black,),
    );
  }
  static warningSnackBar({required title,message=''}) {
    Get.snackbar(title, message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white38,
      backgroundColor: Colors.orange,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(20),
      icon: Icon(Icons.warning_amber,color: Colors.white38,),
    );
  }
  static errorSnackBar({required title,message=''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white38,
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(20),
      icon: Icon(Icons.warning_amber,color: Colors.white38,),
    );
  }
  static NetworkManager get instance =>Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit(){
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result)async{
    _connectionStatus.value =result;
    if(_connectionStatus.value == ConnectivityResult.none){
        warningSnackBar(title:"no internet connection");
    }
  }

  Future<bool> isConnected() async{
    try{
      final result = await _connectivity.checkConnectivity();
      if(result == ConnectivityResult.none){
        return false;
      }else{
        return true;
      }
    }on PlatformException catch (_){
      return false;
    }
  }

  @override
  void onClose(){
    super.onClose();
    _connectivitySubscription.cancel();
  }
}


