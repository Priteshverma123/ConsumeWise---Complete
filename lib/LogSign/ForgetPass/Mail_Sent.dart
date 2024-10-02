import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercuredoc/LogSign/ForgetPass/forget_password_backend.dart';
import 'package:fluttercuredoc/LogSign/Login/Login.dart';
import 'package:get/get.dart';

class MailSent extends StatelessWidget {
  const MailSent({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(), icon: Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: 56 * 2, left: 26 * 2, right: 26 * 2, bottom: 26 * 2),
          child: Column(
            children: [
              Image(image: AssetImage('assets/images/MDoc.png')),
              SizedBox(
                height: 32,
              ),
              Text(
                'Reset Email Sent',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                email,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                height: 70,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => LoginScreen()),
                  child: Text(
                    'Done',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () =>ForgetPasswordController.instance.resendPasswordResetEmail(email),
                  child: Text('Resend email'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
