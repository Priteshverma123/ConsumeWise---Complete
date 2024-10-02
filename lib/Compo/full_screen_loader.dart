import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

 class FullScreenLoader{
  static void openLoadingDialog(String text, String animation){
  showDialog(context: Get.overlayContext!,
  barrierDismissible: false,
  builder:(_)=>PopScope(
  canPop: false,
  child: Container(
  color: Colors.grey,
  width: double.infinity,
  height: double.infinity,
  child: Column(
  children: [
  const SizedBox(height: 250,),
  AnimationLoaderWidget(text:text,animation:animation),
  ],
  ),
  ),
  ),
  );
  }
  static stopLoading(){
  Navigator.of(Get.overlayContext!).pop();
  }
  }

class AnimationLoaderWidget extends StatelessWidget{
  const AnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });
  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation,
            width: 200,
          ),
          SizedBox(height: 16,),
          Text(
            text,
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 24,),
          showAction ?
          SizedBox(
            width: 250,
            child: OutlinedButton(
              onPressed: onActionPressed,
              style: OutlinedButton.styleFrom(backgroundColor: Colors.brown),
              child: Text(
                actionText!,
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
              :const SizedBox(),
        ],
      ),
    );
  }
}

