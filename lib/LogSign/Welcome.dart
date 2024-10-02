import 'package:flutter/material.dart';
import 'package:fluttercuredoc/LogSign/Login/Login.dart';
import 'package:fluttercuredoc/LogSign/SignUp/Signup.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: Color(0xFFD9C19D),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(image: const AssetImage("assets/images/logo2.png"), height: height * 0.6,fit: BoxFit.cover,),
            Column(
              children: [
                Text("Login & SignUp", style:TextStyle(color: Color(0xFF442B2D),fontSize: 40,fontWeight: FontWeight.w600)),
                SizedBox(height: 20,),
                Text(" Make Society healthy ",
                  style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w500),),
                //textAlign: TextAlign.center),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {

                      Get.to(LoginScreen());
                    },
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.only(top: 15,bottom: 15,left: 10,right: 10),
                        side: BorderSide(color: Colors.black87)
                    ),
                    child: Text("Login".toUpperCase(),style: TextStyle(fontSize: 17,color: Color(0xFF442B2D)),),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFD9C19D), Color(0xFF442B2D)], // Your gradient colors
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
                        backgroundColor: Colors.transparent, // Make button transparent
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () {
                        Get.to(SignUpScreen());
                      },
                      child: Text(
                        "Signup".toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}