
import 'package:file_manager_internet_applications_project/Auth/ResetPassword/NewPassord_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPassword_Screen extends StatelessWidget {
   NewPassword_Screen({super.key});
   final NewPassword_Controller controller = Get.put(NewPassword_Controller());


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical:100,horizontal: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/Resetpassword.png",
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Text(
                  "Create new Password",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'your new password must be different from previous used password',
                  style: TextStyle(fontSize: 18,color: Colors.grey),
                  textAlign: TextAlign.center,
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
                    labelText: 'Confirm Password',
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: controller.resetPassword,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black45,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)))),
                      child: const Text(
                        "reset",
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
