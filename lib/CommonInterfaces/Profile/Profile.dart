import 'package:file_manager_internet_applications_project/CustomComponent/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CustomComponent/BaseScreen.dart';
import '../../color_.dart';
import 'ProfileControlller.dart';

class Profile extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  Profile({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Obx(() {
        if (profileController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Container(
            constraints: BoxConstraints(maxWidth: 800), // Set a maximum width
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20), // Padding around the container
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start (left)
              children: [
                SizedBox(height: 20),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 600) {
                      return Row(
                        children: [
                          Column(
                            children: [
                              Image.asset("assets/profile.png", height: 200, width: 200),
                              SizedBox(height: 8),
                              Text(
                                "${profileController.fullname.value}",
                                style: TextStyle(fontSize: 40, color: color_.font),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Expanded( // Use Expanded to fill the remaining space
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text("Role", style: TextStyle(fontSize: 15, color: color_.gray)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    "${profileController.role.value}",
                                    style: TextStyle(fontSize: 18, color: color_.font),
                                  ),
                                ),
                                Divider(color: color_.gray),
                                SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text("Email", style: TextStyle(fontSize: 15, color: color_.gray)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    "${profileController.email.value}",
                                    style: TextStyle(fontSize: 18, color: color_.font),
                                  ),
                                ),
                                Divider(color: color_.gray),
                                SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center, // Align children to the start (left)
                        children: [
                          SizedBox(height: 20),
                          Image.asset("assets/profile.png", height: 200, width: 200),
                          SizedBox(height: 8),
                          Text(
                            "${profileController.fullname.value}",
                            style: TextStyle(fontSize: 40, color: color_.font),
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text("Role", style: TextStyle(fontSize: 15, color: color_.gray)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "${profileController.role.value}",
                                  style: TextStyle(fontSize: 18, color: color_.font),
                                ),
                              ),
                              Divider(color: color_.gray),
                              SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text("Email", style: TextStyle(fontSize: 15, color: color_.gray)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "${profileController.email.value}",
                                  style: TextStyle(fontSize: 18, color: color_.font),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
                Divider(color: color_.gray),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.toNamed('ResetPasswordScreen');
                      },
                      child: Text("Change Password"),
                    ),
                    CustomElevatedButton(
                      color: color_.button,
                      title: 'Logout',
                      onPressed: () {
                        profileController.logout();
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      }),
    );
  }


}
