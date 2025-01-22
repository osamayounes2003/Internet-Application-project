import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Theme/ThemeController.dart';
import '../color_.dart';

class Header extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

   Header({Key? key, required this.scaffoldKey}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    String currentTheme = themeController.currentTheme.value;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (MediaQuery.of(context).size.width <= 600)
            IconButton(
              icon: Icon(Icons.menu, color: AppColors.fontOnBackground(context, currentTheme)),
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ),
          Text(
            "file manager".tr,
            style: TextStyle(
              color: AppColors.fontOnBackground(context, currentTheme),
              fontSize: MediaQuery.of(context).size.width > 600 ? 24 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: AppColors.fontOnBackground(context, currentTheme)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
