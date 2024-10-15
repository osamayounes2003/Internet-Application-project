// sign_up_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'SignUp_controller.dart';

class SignUp_Screen extends StatelessWidget {

  final SignUp_Controller controller = Get.put(SignUp_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/SignUp.png", height: 150, width: 150,),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: controller.fullNameController,
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.person, color: Colors.black),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Full name',
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
                    child: Text("already have an account" ,style: TextStyle(
                      color: Colors.grey
                    ),),
                  ),
                  InkWell(
                    onTap: (){
                      Get.toNamed("login");
                    },
                    child: Text(
                      "LOGIN"
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: controller.validateAndSignUp,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black45,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)))),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(color: Colors.white),
                    ),
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
