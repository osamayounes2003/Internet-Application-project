import 'package:file_manager_internet_applications_project/Routes/app_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../../CustomComponent/BaseScreen.dart';
import '../../CustomComponent/CustomGrid.dart';

class HomeUser_Screen extends StatefulWidget {
  HomeUser_Screen({super.key});

  @override
  State<HomeUser_Screen> createState() => _HomeUser_ScreenState();
}

class _HomeUser_ScreenState extends State<HomeUser_Screen> {

  // @override
  // void initState() {
  //   super.initState();
  //
  //   FirebaseMessaging.instance.getToken().then((String? token) {
  //     assert(token != null);
  //     print("Firebase Messaging Token: $token");
  //   });
  //
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print('Received a message: ${message.notification?.title}');
  //   });
  // }


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
              GridItem(icon: Icons.create_new_folder, label: "Add New Group", route: "/CreateGroup"),
              GridItem(icon: Icons.folder, label: " Groups", route: "/Groups"),
              GridItem(icon: Icons.file_copy, label: "My Files", route:AppRoutes.myBookedFiles),
              GridItem(icon: Icons.file_present, label: "All Files", route: "/all_files"),
              GridItem(icon: Icons.check, label: "Check-in Files", route: "/check_in_files"),
            ],
          );
        },
      ),
    );
  }
}
