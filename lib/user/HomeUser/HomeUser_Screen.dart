import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../CustomComponent/CustomGrid.dart';

class HomeUser_Screen extends StatelessWidget {
  const HomeUser_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 70.0, horizontal: 8),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white70,
                      width: 2.0,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed('profile');
                    },
                    child: Icon(
                      Icons.person,
                      color: Colors.white70,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "user name",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Image.asset(
                "assets/file.png",
                height: 125,
                width: 125,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "File Manager",
                style: TextStyle(color: Colors.white70, fontSize: 30),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  GridItem(icon: Icons.upload_file, label: "Upload File", route: "/upload"),
                  GridItem(icon: Icons.folder_copy, label: "Groups", route: "/groups"),
                  GridItem(icon: Icons.file_copy, label: "Files", route: "/files"),
                  // _buildGridItem(
                  //     Icons.create_new_folder, "New Group", "/newGroup"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(IconData icon, String label, String route) {
    return Card(
      color: Colors.white24,
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
              Icon(icon, size: 50, color: Colors.white70),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(color: Colors.white70, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
