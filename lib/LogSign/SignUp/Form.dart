import 'package:flutter/material.dart';
import 'package:fluttercuredoc/LogSign/SignUp/SignUp_backend.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Validator{
  static String? validateEmptyText(String? fieldName,String ?value){
    if(value== null || value.isEmpty){
      return '$fieldName is required';
    }
    return null;
  }

  static String? validatePassword(String ?value){
    if(value== null || value.isEmpty){
      return 'Password is required';
    }
    return null;
  }

  static String? validatePhoneNumber(String ?value){
    if(value== null || value.isEmpty){
      return 'Phone Number is required';
    }
    return null;
  }

  static String? validateEmail(String? value){
    if(value== null || value.isEmpty){
      return 'Email is required';
    }
    return null;
  }
}
class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30- 10),
      child: Form(
        key: controller.signupFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.fullName,
              validator: (value)=>Validator.validateEmptyText('FullName', value) ,
              decoration: const InputDecoration(
                  label: Text('FullName'),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
            ),
            const SizedBox(height: 30 - 20),
            TextFormField(
                controller: controller.userName,
              validator: (value)=>Validator.validateEmptyText('UserName', value) ,
              decoration: const InputDecoration(
                  label: Text('UserName'),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
            ),
            const SizedBox(height: 30 - 20),
            TextFormField(
                controller: controller.email,
              validator: (value)=>Validator.validateEmail(value) ,
              decoration: const InputDecoration(
                  label: Text('Email'), prefixIcon: Icon(Icons.email_outlined)),
            ),
            const SizedBox(height: 30 - 20),
            TextFormField(
                controller: controller.phoneNo,
              validator: (value)=>Validator.validatePhoneNumber( value) ,
              decoration: const InputDecoration(
                  label: Text('PhoneNo'), prefixIcon: Icon(Icons.numbers)),
            ),
            const SizedBox(height: 30 - 20),
            Obx(
              ()=>TextFormField(
                  controller: controller.password,
                validator: (value)=>Validator.validatePassword( value) ,
                obscureText: controller.hidePassword.value,
                decoration:InputDecoration(
                    label: Text('Password'),
                    prefixIcon: Icon(Icons.fingerprint),
                    suffixIcon: IconButton(
                      onPressed:() => controller.hidePassword.value = !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value ? Icons.remove_red_eye_outlined :Icons.remove_red_eye),),),
              ),
            ),
            const SizedBox(height: 30 - 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.signup(),
                child: Text('Signup'.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}