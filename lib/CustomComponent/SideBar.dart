import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              const SizedBox(width: 10),
              const Text(
                "File Manager",
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              _buildListTile(Icons.home, "Home", "/home_user"),
              _buildListTile(Icons.create_new_folder, "Add New Group", "/new_group"),
              _buildListTile(Icons.folder_copy, "My Groups", "/my_groups"),
              _buildListTile(Icons.folder, "All Groups", "/all_groups"),
              _buildListTile(Icons.file_copy, "My Files", "/my_files"),
              _buildListTile(Icons.file_present, "All Files", "/all_files"),
              _buildListTile(Icons.check, "Check-in Files", "/check_in_files"),
            ],
          ),
        ),
        const Divider(color: Colors.white38, height: 1),
        _buildListTile(Icons.person, "User Name", "/profile"),
      ],
    );
  }

  ListTile _buildListTile(IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white70)),
      onTap: () => Get.toNamed(route),
    );
  }
}
