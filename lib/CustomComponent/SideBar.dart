import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Routes/app_routes.dart';
import '../Loclaization/handleChangeLang.dart';
import '../Theme/ThemeController.dart';
import '../color_.dart';

class SidebarContent extends StatelessWidget {
  final List<Widget> menuItems;

  SidebarContent({required this.menuItems});

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
            children: menuItems,
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
          Get.toNamed('/Change_Theme');
        } else {
          Get.toNamed(route);
        }
      },
    );
  }
}
