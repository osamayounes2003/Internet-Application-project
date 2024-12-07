import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../SharedPreferences/shared_preferences_service.dart';
import '../color_.dart';
import 'UserBar.dart';
import 'AdminBar.dart';
import 'header.dart';
import '../../CustomComponent/SideBar.dart';
import '../Theme/ThemeController.dart';

class BaseScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Widget child;
  final SharedPreferencesService sharedPreferencesService = SharedPreferencesService();

  BaseScreen({Key? key, required this.child}) : super(key: key);

  Future<String> _getUserRole() async {
    return await sharedPreferencesService.getRole() ?? 'USER';
  }

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
        child: FutureBuilder<String>(
          future: _getUserRole(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error loading role"));
            }

            String role = snapshot.data!;
            return SidebarContent(
              menuItems: role == 'ADMIN'
                  ? AdminBar(context, currentTheme)
                  : Userbar(context, currentTheme),
            );
          },
        ),
      ),
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width > 600)
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 250,
                color: AppColors.background2(context, currentTheme),
                child: FutureBuilder<String>(
                  future: _getUserRole(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error loading role"));
                    }

                    String role = snapshot.data!;
                    return SidebarContent(
                      menuItems: role == 'ADMIN'
                          ? AdminBar(context, currentTheme)
                          : Userbar(context, currentTheme),
                    );
                  },
                ),
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(scaffoldKey: scaffoldKey),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
