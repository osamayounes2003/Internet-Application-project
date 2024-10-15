import 'package:file_manager_internet_applications_project/Auth/ResetPassword/ResetPassword_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ResetPasswordScreen extends StatelessWidget {
  final ResetPassword_Controller controller = Get.put(ResetPassword_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric( vertical:100,horizontal: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.email, color: Colors.black),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Email',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.sendVerificationCode();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black45,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                      child: const Text(
                        "Send Verification Code",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
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
