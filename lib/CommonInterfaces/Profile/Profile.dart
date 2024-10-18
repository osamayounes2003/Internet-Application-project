import 'package:file_manager_internet_applications_project/CustomComponent/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../color_.dart';
import 'ProfileControlller.dart';

class Profile extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: Obx(() {
        if (profileController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15, top: 100),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset("assets/profile.png", height: 200, width: 200),
                  SizedBox(height: 8),
                  Text("${profileController.fullname.value}",
                      style: TextStyle(fontSize: 40, color: color_.font)),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("Role",
                            style: TextStyle(fontSize: 15, color: color_.gray)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("${profileController.role.value}",
                            style: TextStyle(fontSize: 18, color: color_.font)),
                      ),
                      Divider(
                        color: color_.gray,
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("Email",
                            style: TextStyle(fontSize: 15, color: color_.gray)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("${profileController.email.value}",
                            style: TextStyle(fontSize: 18, color: color_.font)),
                      ),
                      Divider(
                        color: color_.gray,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.toNamed('ResetPasswordScreen');
                        },
                        child: Text(
                          "change password",
                        ),
                      ),
                      CustomElevatedButton(
                        color: color_.button,
                          title: 'Logout',
                          onPressed: () {
                            profileController.logout();
                          }),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
