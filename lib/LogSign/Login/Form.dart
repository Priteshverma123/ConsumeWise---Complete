import 'package:flutter/material.dart';
import 'package:fluttercuredoc/LogSign/ForgetPass/Mail.dart';
import 'package:fluttercuredoc/LogSign/Login/login_backend.dart';
import 'package:fluttercuredoc/LogSign/SignUp/Form.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30 - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.email,
              validator: (value) => Validator.validateEmail(value),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: 'Email',
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            const SizedBox(height: 30 - 20),
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) => Validator.validateEmptyText('Password',value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                    label: Text('Password'),
                    prefixIcon: Icon(Icons.fingerprint),
                    suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value =
                          !controller.hidePassword.value,
                      icon: Icon(controller.hidePassword.value
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            const SizedBox(height: 30 - 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) => controller.rememberMe.value =
                              !controller.rememberMe.value),
                    ),
                    Text('Remember me'),
                  ],
                ),
                TextButton(
                    onPressed: () =>
                      Get.to(ForgetPasswordMailScreen()),

                    child: const Text('Forget Password?')),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ()=>
                  controller.emailAndPasswordSignIn(),
                child: Text('Login'.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
