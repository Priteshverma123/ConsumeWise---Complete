import 'package:flutter/material.dart';
import 'package:fluttercuredoc/AuthenticationRepository.dart';
import 'package:fluttercuredoc/Compo/verify_email_cont.dart';
import 'package:get/get.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key, this.email});
  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: ()=>AuthenticationRepository.instance.logout(),
              icon: Icon(Icons.cancel_outlined,size: 40,),),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Image(image:AssetImage('assets/images/MDoc.png')),
              SizedBox(height: 32,),

              Text('Verify your Email',style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 35
              ),),
              SizedBox(height: 16,),
              Text(email ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.w500
                ),),
              SizedBox(height: 16,),
              Text('Congratulation for logging in with our app',
                style: TextStyle(
                  fontWeight: FontWeight.w300
                ),),
              SizedBox(height: 32,),

              SizedBox(
                width: double.infinity,
                height: 70,
                child: ElevatedButton(
                  onPressed: ()=> controller.checkEmailVerificationStatus(),
                  child: Text('Continue',
                  style: TextStyle(
                    fontSize: 17
                  ),),
                ),
              ),
              SizedBox(height: 16,),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: ()=>controller.sendEmailVerification(),
                  child: Text('resend Email'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
