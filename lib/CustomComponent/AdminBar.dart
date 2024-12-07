import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Theme/ThemeController.dart';
import '../color_.dart';
import '../Routes/app_routes.dart';
import '../Loclaization/handleChangeLang.dart';

List<Widget> AdminBar(BuildContext context, String currentTheme) {
  return [
    _buildListTile(context, Icons.home, "Home".tr, "/home_admin", currentTheme),
    _buildListTile(context, Icons.folder_copy, "Groups".tr, "/groups-admin", currentTheme),
    _buildListTile(context, Icons.people_alt_outlined, "users".tr, "/AdminUsersScreen", currentTheme),
    _buildListTile(context, Icons.file_copy_outlined, "Files".tr, "/allfiles_admin", currentTheme),
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
