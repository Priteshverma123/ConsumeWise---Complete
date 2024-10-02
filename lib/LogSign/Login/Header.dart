import 'package:flutter/material.dart';
class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage('assets/images/prodcut2.png'),
              height: size.height * 0.3,fit: BoxFit.cover,),
          ],
        ),
        Text("Welcome Back,",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30), ),
      ],
    );
  }
}