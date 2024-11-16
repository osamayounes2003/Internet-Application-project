
import 'package:file_manager_internet_applications_project/user/files/booked_files_by_folder/controller/booked_files_by_folder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../color_.dart';
import '../../my_booked_files/screen/file_details_screen.dart';

class BookedFilesByFolderScreen extends StatelessWidget {
 BookedFilesByFolderController controller = Get.put(BookedFilesByFolderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booked files '),
      ),
      body:
      Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: color_.black,));
        }

        return ListView.builder(
          itemCount: controller.filesOfFolder.length,
          itemBuilder: (context, index) {
            final file = controller.filesOfFolder[index];
            return ListTile(
              title: Text(file.name),
              subtitle: Text('Status: ${file.status}'),
              onTap: () {

                Get.to(() => FileDetailScreen(file: file));
              },
            );
          },
        );
      }),


    );
  }
}
