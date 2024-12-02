import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Routes/app_routes.dart';
import '../Loclaization/handleChangeLang.dart';
import '../Theme/ThemeController.dart';
import '../color_.dart';

class SidebarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    String currentTheme = themeController.currentTheme.value;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20.0),
          color: AppColors.background2(context, currentTheme),
          child: Row(
            children: [
              Image.asset(
                "assets/file.png",
                height: 50,
                width: 50,
              ),
              const SizedBox(width: 10),
              Text(
                "file manager".tr,
                style: TextStyle(
                    color: AppColors.font(context, currentTheme),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
         Divider(color: AppColors.font(context, currentTheme)),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              _buildListTile(context, Icons.home, "Home".tr, "/home_user", currentTheme),
              _buildListTile(context, Icons.create_new_folder, "Add New Group".tr, "/CreateGroup", currentTheme),
              _buildListTile(context, Icons.folder_copy, "Groups".tr, "/Groups", currentTheme),
              _buildListTile(context, Icons.file_present_rounded, "My Booked file".tr, AppRoutes.myBookedFiles, currentTheme),
              _buildListTile(context, Icons.person_add, "Joining Requests to My Groups".tr, "/JoiningRequests_toMyGroups", currentTheme),
              // _buildListTile(context, Icons.check, "Check-in Files".tr, "/check_in_files", currentTheme),
              _buildListTile(context, Icons.add_alert_outlined, "Joining Requests".tr, "/JoiningRequests", currentTheme),
              _buildListTile(context, Icons.translate, "change language".tr, "", currentTheme, isLanguageChange: true),
              _buildListTile(context, Icons.dark_mode_outlined, "Light/Dark".tr, "", currentTheme, ismodeChange: true),
            ],
          ),
        ),
        Divider(color: AppColors.font(context, currentTheme), height: 1),
        _buildListTile(context, Icons.person, "profile".tr, "/profile", currentTheme),
      ],
    );
  }

  ListTile _buildListTile(BuildContext context, IconData icon, String title, String route, String currentTheme, {bool isLanguageChange = false, bool ismodeChange = false}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.font(context, currentTheme)),
      title: Text(title, style: TextStyle(color: AppColors.font(context, currentTheme))),
      onTap: () async {
        if (isLanguageChange) {
          changeLanguage();
        } else if (ismodeChange) {
          // themeController.toggleTheme();
          // Get.offAllNamed('/home_user', arguments: {'themeChanged': true});
          Get.toNamed('/Change_Theme');
        } else {
          Get.toNamed(route);
        }
      },
    );
  }
}
