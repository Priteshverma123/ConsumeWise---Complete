import 'package:flutter/material.dart';
import 'package:fluttercuredoc/AuthenticationRepository.dart';
import 'package:get/get.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 56*2,left: 26*2,right: 26*2,bottom: 26*2),

          child: Column(
            children: [
              Image(image:AssetImage('assets/images/MDoc.png')),
              SizedBox(height: 32,),

              Text('Verified your Email',style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 35
              ),),
              SizedBox(height: 16,),
              Text('support@hmail.com',
                style: TextStyle(
                    fontWeight: FontWeight.w500
                ),),
              SizedBox(height: 16,),

              SizedBox(
                width: double.infinity,
                height: 70,
                child: ElevatedButton(
                  onPressed: ()=>AuthenticationRepository.instance.screenRedirect(),
                  child: Text('Continue',
                    style: TextStyle(
                        fontSize: 17
                    ),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
