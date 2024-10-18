import 'package:file_manager_internet_applications_project/Auth/ResetPassword/ResetPassword_Controller.dart';
import 'package:file_manager_internet_applications_project/CustomComponent/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../CustomComponent/CustomInput.dart';


class ResetPasswordScreen extends StatelessWidget {
  final ResetPassword_Controller controller = Get.put(ResetPassword_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric( vertical:100,horizontal: 20),
          child: Column(
              children: [
              Image.asset(
                "assets/Resetpassword.png",
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Text(
                  "Reset Password",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Enter the email associated with your account and we will send an email with verification code to reset your password',
                  style: TextStyle(fontSize: 18,color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
                CustomTextFormField(
                  controller: controller.emailController,
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: const Icon(Icons.email, color: Colors.black),
                ),
                Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomElevatedButton(title:  "Send Verification Code", onPressed: () {
                      controller.sendVerificationCode();
                    },),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
