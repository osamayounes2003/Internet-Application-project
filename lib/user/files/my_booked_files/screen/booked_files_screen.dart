
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../color_.dart';
import '../controller/booked_files_controller.dart';
import 'file_details_screen.dart'; // Import the detail screen

class MyBookedFiles extends StatelessWidget {
  final MyBookedFilesController controller = Get.put(MyBookedFilesController());

   MyBookedFiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' My Booked Files'),
      ),
      body:
      Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: color_.black,));
        }

        return ListView.builder(
          itemCount: controller.myBookedFiles.length,
          itemBuilder: (context, index) {
            final file = controller.myBookedFiles[index];
            return ListTile(
              title: Text(file.name),
              trailing: Icon(Icons.file_copy_sharp),
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
