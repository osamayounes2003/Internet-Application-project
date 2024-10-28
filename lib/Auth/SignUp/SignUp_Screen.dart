import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CustomComponent/CustomButton.dart';
import '../../CustomComponent/CustomInput.dart';
import 'SignUp_controller.dart';

class SignUp_Screen extends StatelessWidget {
  final SignUp_Controller controller = Get.put(SignUp_Controller());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWeb = screenWidth > 600;

    return Scaffold(
      body: Container(
        decoration: isWeb
            ? BoxDecoration(
          gradient: LinearGradient(
            colors: [ Colors.grey.shade800,Colors.black,],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        )
            : BoxDecoration(color: Colors.white),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: isWeb ? 400 : double.infinity,
              padding: EdgeInsets.all(20),
              decoration: isWeb
                  ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(4, 4),
                  ),
                ],
              )
                  : null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/SignUp.png", height: 150, width: 150),
                  SizedBox(height: 50),
                  CustomTextFormField(
                    controller: controller.fullNameController,
                    labelText: 'Full Name',
                    suffixIcon: const Icon(Icons.person, color: Colors.black),
                  ),
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
                            "Already have an account",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed("login");
                          },
                          child: Text(
                            "LOGIN",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomElevatedButton(
                          title: "Sign up",
                          onPressed: controller.validateAndSignUp,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
