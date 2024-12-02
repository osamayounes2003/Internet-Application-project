import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CustomComponent/BaseScreen.dart';
import '../../Theme/ThemeController.dart';
import '../../color_.dart';
import 'ProfileControlller.dart';

class Profile extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    String currentTheme = themeController.currentTheme.value;

    return BaseScreen(
      child: Obx(() {
        if (profileController.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: AppColors.primary(context, currentTheme)));
        } else {
          return Container(
            constraints: BoxConstraints(maxWidth: 800),
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            // color: AppColors.background(context, currentTheme),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                                style: TextStyle(fontSize: 40, color: AppColors.font(context, currentTheme)),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text("Role".tr, style: TextStyle(fontSize: 15, color: AppColors.gray(context, currentTheme))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    "${profileController.role.value}",
                                    style: TextStyle(fontSize: 18, color: AppColors.font(context, currentTheme)),
                                  ),
                                ),
                                Divider(color: AppColors.gray(context, currentTheme)),
                                SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text("Email".tr, style: TextStyle(fontSize: 15, color: AppColors.gray(context, currentTheme))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    "${profileController.email.value}",
                                    style: TextStyle(fontSize: 18, color: AppColors.font(context, currentTheme)),
                                  ),
                                ),
                                Divider(color: AppColors.gray(context, currentTheme)),
                                SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Image.asset("assets/profile.png", height: 200, width: 200),
                          SizedBox(height: 8),
                          Text(
                            "${profileController.fullname.value}",
                            style: TextStyle(fontSize: 40, color: AppColors.font(context, currentTheme)),
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text("Role".tr, style: TextStyle(fontSize: 15, color: AppColors.gray(context, currentTheme))),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "${profileController.role.value}",
                                  style: TextStyle(fontSize: 18, color: AppColors.font(context, currentTheme)),
                                ),
                              ),
                              Divider(color: AppColors.gray(context, currentTheme)),
                              SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text("Email".tr, style: TextStyle(fontSize: 15, color: AppColors.gray(context, currentTheme))),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "${profileController.email.value}",
                                  style: TextStyle(fontSize: 18, color: AppColors.font(context, currentTheme)),
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
                Divider(color: AppColors.gray(context, currentTheme)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.toNamed('ResetPasswordScreen');
                      },
                      child: Text(
                        "Change Password".tr,
                        style: TextStyle(color: AppColors.primary(context, currentTheme)),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.button(context, currentTheme),
                      ),
                      onPressed: () {
                        profileController.logout();
                      },
                      child: Text(
                        "Logout".tr,
                        style: TextStyle(color: AppColors.fontOnBackground(context, currentTheme)),
                      ),
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
