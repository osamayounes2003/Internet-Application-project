import 'package:file_manager_internet_applications_project/color_.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../CustomComponent/CustomGrid.dart';

class HomeUser_Screen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   HomeUser_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWeb = screenWidth > 600;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: color_.background,
      drawer: !isWeb
          ? Drawer(
        backgroundColor: Colors.black87,
        child: SidebarContent(),
      )
          : null,
      body: Row(
        children: [
          if (isWeb)
            Container(
              width: 250,
              color: Colors.black87,
              child: SidebarContent(),
            ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (!isWeb)
                        IconButton(
                          icon: Icon(Icons.menu, color: Colors.white70),
                          onPressed: () {
                            print("Opening drawer...");
                            _scaffoldKey.currentState?.openDrawer();
                          },
                        ),
                      Text(
                        "File Manager",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: isWeb ? 24 : 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.notifications, color: Colors.white70),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GridView.count(
                      crossAxisCount: isWeb ? 4 : 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      children: [
                        GridItem(icon: Icons.create_new_folder, label: "Add New Group", route: "/new_group"),
                        GridItem(icon: Icons.folder_copy, label: "My Groups", route: "/my_groups"),
                        GridItem(icon: Icons.folder, label: "All Groups", route: "/all_groups"),
                        GridItem(icon: Icons.file_copy, label: "My Files", route: "/my_files"),
                        GridItem(icon: Icons.file_present, label: "All Files", route: "/all_files"),
                        GridItem(icon: Icons.check, label: "Check-in Files", route: "/check_in_files"),
                      ],
                    ),
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

class SidebarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20.0),
          color: Colors.black,
          child: Row(
            children: [
              Image.asset(
                "assets/file.png",
                height: 50,
                width: 50,
              ),
              SizedBox(width: 10),
              Text(
                "File Manager",
                style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Divider(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              ListTile(
                leading: Icon(Icons.create_new_folder, color: Colors.white70),
                title: Text("Add New Group", style: TextStyle(color: Colors.white70)),
                onTap: () => Get.toNamed("/new_group"),
              ),
              ListTile(
                leading: Icon(Icons.folder_copy, color: Colors.white70),
                title: Text("My Groups", style: TextStyle(color: Colors.white70)),
                onTap: () => Get.toNamed("/my_groups"),
              ),
              ListTile(
                leading: Icon(Icons.folder, color: Colors.white70),
                title: Text("All Groups", style: TextStyle(color: Colors.white70)),
                onTap: () => Get.toNamed("/all_groups"),
              ),
              ListTile(
                leading: Icon(Icons.file_copy, color: Colors.white70),
                title: Text("My Files", style: TextStyle(color: Colors.white70)),
                onTap: () => Get.toNamed("/my_files"),
              ),
              ListTile(
                leading: Icon(Icons.file_present, color: Colors.white70),
                title: Text("All Files", style: TextStyle(color: Colors.white70)),
                onTap: () => Get.toNamed("/all_files"),
              ),
              ListTile(
                leading: Icon(Icons.check, color: Colors.white70),
                title: Text("Check-in Files", style: TextStyle(color: Colors.white70)),
                onTap: () => Get.toNamed("/check_in_files"),
              ),
            ],
          ),
        ),
        Divider(color: Colors.white38, height: 1),
        ListTile(
          leading: Icon(Icons.person, color: Colors.white70),
          title: Text("User Name", style: TextStyle(color: Colors.white70)),
          onTap: () => Get.toNamed("/profile"),
        ),
      ],
    );
  }
}
