import 'package:file_manager_internet_applications_project/Auth/LogIn/LogIn_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Obx(() => TextFormField(
                controller: controller.passwordController,
                obscureText: !controller.isPasswordVisible.value,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Password',
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
              )),
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
                    child: Text("SignUp", style: TextStyle(color: Colors.black,)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.login,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black45,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0)))),
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text(
                      "Log In",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );  }
}
