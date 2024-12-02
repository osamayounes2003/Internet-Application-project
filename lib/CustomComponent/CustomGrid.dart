import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../color_.dart';
import 'package:file_manager_internet_applications_project/Theme/ThemeController.dart'; // استيراد الـ ThemeController

class GridItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;

  const GridItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String theme = Get.find<ThemeController>().currentTheme.value;

    return Card(
      color: AppColors.card(context, theme),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(route);
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: AppColors.font(context, theme),
              ),
              const SizedBox(height: 30),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.font(context, theme),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
