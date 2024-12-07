import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CommonInterfaces/Profile/ProfileControlller.dart';
import '../../CustomComponent/BaseScreen.dart';
import '../../color_.dart';
import '../../Theme/ThemeController.dart';
import '../ReportAdmin/ReportAdmin_controller.dart';

class HomeAdmin_Screen extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  final DownloadAdminReportController downloadController = Get.put(DownloadAdminReportController());

  HomeAdmin_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    String currentTheme = themeController.currentTheme.value;

    return BaseScreen(
      child: Obx(() {
        if (profileController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primary(context, currentTheme),
            ),
          );
        } else {
          return LayoutBuilder(
            builder: (context, constraints) {
              bool isWideScreen = constraints.maxWidth > 600;

              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: isWideScreen
                      ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Left Column (Profile Image and Name)
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Image.asset("assets/profile.png", height: 150, width: 150),
                            const SizedBox(height: 10),
                            Text(
                              profileController.fullname.value,
                              style: TextStyle(fontSize: 30, color: AppColors.white(context, currentTheme)),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Right Column (Info Fields and Buttons)
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow(
                              context: context,
                              title: "Full Name",
                              value: profileController.fullname.value,
                              theme: currentTheme,
                            ),
                            const SizedBox(height: 15),
                            _buildInfoRow(
                              context: context,
                              title: "Email",
                              value: profileController.email.value,
                              theme: currentTheme,
                            ),
                            const SizedBox(height: 15),
                            _buildInfoRow(
                              context: context,
                              title: "Role",
                              value: profileController.role.value,
                              theme: currentTheme,
                            ),
                            const SizedBox(height: 30),
                            Center(
                              child: Column(
                                children: [
                                  Obx(() {
                                    return downloadController.isLoading.value
                                        ? CircularProgressIndicator(
                                      color: AppColors.primary(context, currentTheme),
                                    )
                                        : ElevatedButton.icon(
                                      onPressed: downloadController.downloadAdminReport,
                                      icon: const Icon(Icons.download, color: Colors.white70),
                                      label: const Text(
                                        "Download Report",
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.button(context, currentTheme),
                                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                      ),
                                    );
                                  }),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.button(context, currentTheme),
                                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                    ),
                                    onPressed: profileController.logout,
                                    child: Text(
                                      "Logout",
                                      style: TextStyle(color: AppColors.gray(context, currentTheme)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      isWideScreen
                          ? Expanded(
                        child: SizedBox(width: 30),
                      )
                          : Container()
                    ],
                  )
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Image.asset("assets/profile.png", height: 150, width: 150),
                            const SizedBox(height: 10),
                            Text(
                              profileController.fullname.value,
                              style: TextStyle(fontSize: 30, color: AppColors.white(context, currentTheme)),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildInfoRow(
                        context: context,
                        title: "Full Name",
                        value: profileController.fullname.value,
                        theme: currentTheme,
                      ),
                      const SizedBox(height: 15),
                      _buildInfoRow(
                        context: context,
                        title: "Email",
                        value: profileController.email.value,
                        theme: currentTheme,
                      ),
                      const SizedBox(height: 15),
                      _buildInfoRow(
                        context: context,
                        title: "Role",
                        value: profileController.role.value,
                        theme: currentTheme,
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: Column(
                          children: [
                            Obx(() {
                              return downloadController.isLoading.value
                                  ? CircularProgressIndicator(
                                color: AppColors.primary(context, currentTheme),
                              )
                                  : ElevatedButton.icon(
                                onPressed: downloadController.downloadAdminReport,
                                icon: const Icon(Icons.download, color: Colors.white70),
                                label: const Text(
                                  "Download Report",
                                  style: TextStyle(color: Colors.white70),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.button(context, currentTheme),
                                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                ),
                              );
                            }),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.button(context, currentTheme),
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              ),
                              onPressed: profileController.logout,
                              child: Text(
                                "Logout",
                                style: TextStyle(color: AppColors.gray(context, currentTheme)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }

  Widget _buildInfoRow({
    required BuildContext context,
    required String title,
    required String value,
    required String theme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, color: AppColors.gray(context, theme)),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(fontSize: 18, color: AppColors.white(context, theme)),
        ),
        Divider(color: AppColors.gray(context, theme)),
      ],
    );
  }
}
