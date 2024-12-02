import 'package:file_manager_internet_applications_project/CustomComponent/BaseScreen.dart';
import 'package:file_manager_internet_applications_project/Theme/ThemeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../color_.dart';

class ChangethemeScreen extends StatelessWidget {
  ChangethemeScreen({super.key});

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentTheme = themeController.currentTheme.value;
      return BaseScreen(
        child: Column(
          children: [
            Text(
             "Theme",
              style: TextStyle(
                color: AppColors.fontOnBackground(context, currentTheme),
                fontSize: MediaQuery.of(context).size.width > 600 ? 24 : 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.grey,
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                ],
              ),
              title: Text(
                'Light Theme',
                style: TextStyle(
                  color: AppColors.fontOnBackground(context, currentTheme),
                ),
              ),
              onTap: () {
                themeController.setTheme('light');
              },
            ),
            ListTile(
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.black,
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.black12,
                  ),
                ],
              ),
              title: Text(
                'Dark Theme',
                style: TextStyle(
                  color: AppColors.fontOnBackground(context, currentTheme),
                ),
              ),
              onTap: () {
                themeController.setTheme('dark');
              },
            ),
            ListTile(
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.indigo,
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.blue,
                  ),
                ],
              ),
              title: Text(
                'Blue Navy Theme',
                style: TextStyle(
                  color: AppColors.fontOnBackground(context, currentTheme),
                ),
              ),
              onTap: () {
                themeController.setTheme('blueNavy');
              },
            ),
            ListTile(
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.amberAccent,
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.yellowAccent,
                  ),
                ],
              ),
              title: Text(
                'Golden Theme',
                style: TextStyle(
                  color: AppColors.fontOnBackground(context, currentTheme),
                ),
              ),
              onTap: () {
                themeController.setTheme('golden');
              },
            ),

          ],
        ),
      );
    });
  }
}
