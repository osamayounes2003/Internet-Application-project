import 'package:file_manager_internet_applications_project/CustomComponent/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CustomComponent/CustomInput.dart';
import 'NewPassord_controller.dart';

class NewPassword_Screen extends StatefulWidget {
  final String emailAddress;

  NewPassword_Screen({super.key, required this.emailAddress});

  @override
  State<NewPassword_Screen> createState() => _NewPassword_ScreenState();
}

class _NewPassword_ScreenState extends State<NewPassword_Screen> {
  @override
  Widget build(BuildContext context) {
    final NewPassword_Controller controller = Get.put(NewPassword_Controller(
      emailAddress: widget.emailAddress,
    ));

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
          child: Column(
            children: [
              Image.asset(
                "assets/Resetpassword.png",
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 50,
              ),
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
                  'Your new password must be different from the previously used password',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              CustomTextFormField(
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
              CustomTextFormField(
                controller: controller.confirmPasswordController,
                labelText: 'Confirm Password',
                isObscure: !controller.isPasswordVisible.value,
                suffixIcon: Icon(
                  controller.isPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.black,
                ),
                onSuffixIconPressed: controller.togglePasswordVisibility,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomElevatedButton(
                      title: 'Reset',
                      onPressed: () {
                        controller.resetPassword;
                      },
                    )
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
