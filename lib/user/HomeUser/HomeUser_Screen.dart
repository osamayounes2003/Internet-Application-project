import 'package:flutter/material.dart';
import '../../CustomComponent/BaseScreen.dart';
import '../../CustomComponent/CustomGrid.dart';

class HomeUser_Screen extends StatelessWidget {
  HomeUser_Screen({super.key});

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
              GridItem(icon: Icons.create_new_folder, label: "Add New Group", route: "/new_group"),
              GridItem(icon: Icons.folder_copy, label: "My Groups", route: "/my_groups"),
              GridItem(icon: Icons.folder, label: "All Groups", route: "/Groups"),
              GridItem(icon: Icons.file_copy, label: "My Files", route: "/my_files"),
              GridItem(icon: Icons.file_present, label: "All Files", route: "/all_files"),
              GridItem(icon: Icons.check, label: "Check-in Files", route: "/check_in_files"),
            ],
          );
        },
      ),
    );
  }
}
