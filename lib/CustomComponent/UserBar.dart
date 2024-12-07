import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Theme/ThemeController.dart';
import '../color_.dart';
import '../Routes/app_routes.dart';
import '../Loclaization/handleChangeLang.dart';

List<Widget> Userbar(BuildContext context, String currentTheme) {
  return [
    _buildListTile(context, Icons.home, "Home".tr, "/home_user", currentTheme),
    _buildListTile(context, Icons.create_new_folder, "Add New Group".tr, "/CreateGroup", currentTheme),
    _buildListTile(context, Icons.folder_copy, "Groups".tr, "/Groups", currentTheme),
    _buildListTile(context, Icons.file_present_rounded, "My Booked file".tr, AppRoutes.myBookedFiles, currentTheme),
    _buildListTile(context, Icons.person_add, "Joining Requests to My Groups".tr, "/JoiningRequests_toMyGroups", currentTheme),
    _buildListTile(context, Icons.add_alert_outlined, "Joining Requests".tr, "/JoiningRequests", currentTheme),
    _buildListTile(context, Icons.translate, "change language".tr, "", currentTheme, isLanguageChange: true),
    _buildListTile(context, Icons.dark_mode_outlined, "Light/Dark".tr, "", currentTheme, ismodeChange: true),
  ];
}

ListTile _buildListTile(BuildContext context, IconData icon, String title, String route, String currentTheme, {bool isLanguageChange = false, bool ismodeChange = false}) {
  return ListTile(
    leading: Icon(icon, color: AppColors.font(context, currentTheme)),
    title: Text(title, style: TextStyle(color: AppColors.font(context, currentTheme))),
    onTap: () async {
      if (isLanguageChange) {
        changeLanguage();
      } else if (ismodeChange) {
        Get.toNamed('/Change_Theme');
      } else {
        Get.toNamed(route);
      }
    },
  );
}
