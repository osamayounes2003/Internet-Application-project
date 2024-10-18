import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CustomComponent/CustomButton.dart';
import '../../CustomComponent/CustomInput.dart';
import 'SignUp_controller.dart';

class SignUp_Screen extends StatelessWidget {

  final SignUp_Controller controller = Get.put(SignUp_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/SignUp.png", height: 150, width: 150,),
                SizedBox(height: 50,),
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
                // في SignUp_Screen.dart
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
    );
  }
}
