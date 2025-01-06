import 'package:file_manager_internet_applications_project/color_.dart';
import 'package:file_manager_internet_applications_project/user/Group/multi_select_file/multi_select_item_controller.dart';
import 'package:file_manager_internet_applications_project/user/Groups/models/Groups_Model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectMultiFileScreen extends StatelessWidget {
  final MultiSelectFileController controller = Get.put(MultiSelectFileController());

  SelectMultiFileScreen({Key? key, required List<File> files}) : super(key: key) {
    controller.files.assignAll(files); // Initialize the file list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Multi File'),
        actions: [
          IconButton(
            color: Colors.green,
            icon: Icon(Icons.check),
            onPressed: () {
              var selected = controller.selectedIds;
              controller.checkInMultiFile(selected);
              if (selected.isNotEmpty) {
                print(selected);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected IDs: $selected')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('No files selected.')),
                );
              }
            },
          ),
          IconButton(
            color: Colors.blue,
            icon: Icon(Icons.select_all),
            onPressed: () {
              controller.selectAllFiles(); // Toggle select all files
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Toggled selection for all files')),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator()); // Show loading indicator
        }

        // Filter available files
        List<File> availableFiles = controller.files.where((file) => file.status == 'AVAILABLE').toList();

        if (availableFiles.isEmpty) {
          return Center(child: Text('No files available.'));
        }
        return ListView.builder(
          itemCount: availableFiles.length,
          itemBuilder: (context, index) {
            final file = availableFiles[index];
            return ListTile(
              title: Text(file.name),
              subtitle: Text('Status: ${file.status}'),
              trailing: Checkbox(
                value: file.isSelected,
                onChanged: (bool? value) {
                  controller.toggleSelection(file.id);
                },
              ),
            );
          },
        );
      }),
    );
  }
}