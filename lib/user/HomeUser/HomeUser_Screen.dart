import 'package:file_manager_internet_applications_project/CustomComponent/ToolTip.dart';
import 'package:file_manager_internet_applications_project/Routes/app_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../CustomComponent/BaseScreen.dart';
import '../../CustomComponent/CustomGrid.dart';
import '../../Theme/ThemeController.dart';

class HomeUser_Screen extends StatefulWidget {
  HomeUser_Screen({super.key});

  @override
  State<HomeUser_Screen> createState() => _HomeUser_ScreenState();
}

class _HomeUser_ScreenState extends State<HomeUser_Screen> {

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments as Map?;
    if (arguments != null && arguments['themeChanged'] == true) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: _buildGridView(),
    );
  }

  Widget _buildGridView() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount;
          if (constraints.maxWidth > 1200) {
            crossAxisCount = 4;
          } else if (constraints.maxWidth > 800) {
            crossAxisCount = 3;
          } else {
            crossAxisCount = 2;
          }

          return GridView.count(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            children: [
              CustomTooltip(
                  message: 'if you want to create your own group '.tr,
                  child: GridItem(icon: Icons.create_new_folder, label: 'Add New Group'.tr, route: "/CreateGroup")),
              CustomTooltip(
                  message: 'see all group and your group and joined group '.tr,
                  child: GridItem(icon: Icons.folder_copy, label: 'Groups'.tr, route: "/Groups")),
              CustomTooltip(
                  message: 'all files you are check in '.tr,
                  child: GridItem(icon: Icons.file_present_rounded, label: 'My Booked Files'.tr, route: AppRoutes.myBookedFiles)),
              CustomTooltip(
                  message: 'user who send request to join one of your groups'.tr,
                  child: GridItem(icon: Icons.person_add, label: 'Joining Requests to My Groups'.tr, route: "/JoiningRequests_toMyGroups")),
              CustomTooltip(
                  message: 'user invite you to join there groups'.tr,
                  child: GridItem(icon: Icons.add_alert_outlined, label: "Joining Requests".tr, route: "/JoiningRequests")),
            ],
          );
        },
      ),
    );
  }
}
