import 'package:flutter/material.dart';
import 'package:fluttercuredoc/LogSign/SignUp/Form.dart';
import 'package:fluttercuredoc/Profile/update_name_controller.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Use your real name',
            style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
            SizedBox(height: 16,),
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.fullName,
                    validator: (value)=>Validator.validateEmptyText('Full Name', value),
                    expands: false,
                    decoration: InputDecoration(labelText:'Name',prefixIcon: Icon(Iconsax.user)),
                  ),
                  SizedBox(height: 24,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: ()=>controller.updateUserName(),
                      child: (
                      Text('Save',)
                      ),
                    ),
                  )
                ],
            ),)
          ],
        ),
      ),
    );
  }
}
