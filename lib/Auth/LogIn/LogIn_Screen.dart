import 'package:file_manager_internet_applications_project/Auth/LogIn/LogIn_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../CustomComponent/CustomButton.dart';
import '../../CustomComponent/CustomInput.dart';

class LogIn_Screen extends StatelessWidget {
  LogIn_Screen({super.key});

  final LogIn_Controller controller = Get.put(LogIn_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                "assets/LogIn.png",
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 50),
            CustomTextFormField(
              controller: controller.emailController,
              labelText: 'Email',
              keyboardType: TextInputType.emailAddress,
              suffixIcon: const Icon(Icons.email, color: Colors.black),
            ),
            Obx(
              () => CustomTextFormField(
                controller: controller.passwordController,
                labelText: 'Password',
                isObscure: !controller.isPasswordVisible.value,
                suffixIcon: Icon(
                  controller.isPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.black,
                ),
                onSuffixIconPressed: controller.togglePasswordVisibility,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "Don't have an account",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed("signup");
                    },
                    child: Text("SignUp",
                        style: TextStyle(
                          color: Colors.black,
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomElevatedButton(
                    title: "Log In",
                    onPressed: controller.isLoading.value ? null : () async {
                      await controller.login();
                    },
                    isLoading: controller.isLoading.value,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
