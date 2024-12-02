import 'package:file_manager_internet_applications_project/color_.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'header.dart';
import '../../CustomComponent/SideBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Theme/ThemeController.dart';

class BaseScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Widget child;

  BaseScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    String currentTheme = themeController.currentTheme.value;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.background(context, currentTheme),
      drawer: MediaQuery.of(context).size.width > 600
          ? null
          : Drawer(
        // backgroundColor: Colors.red,
        child: SidebarContent(),
      ),
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width > 600)
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Container(
                width: 250,
                color: AppColors.background2(context, currentTheme),
                  child: SidebarContent(),
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(scaffoldKey: scaffoldKey),
                Expanded(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: child,
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
