import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'FileTracing_Model.dart';

class FileTracingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the list of file tracings passed as arguments
    final List<FileTracingModel> fileTracingList = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("File Tracing"),
      ),
      body: fileTracingList.isEmpty
          ? Center(child: Text("No file tracing records available."))
          : ListView.builder(
        itemCount: fileTracingList.length,
        itemBuilder: (context, index) {
          final fileTracing = fileTracingList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: ListTile(
              title: Text("User ID: ${fileTracing.userId}"),
              subtitle: Text("Type: ${fileTracing.type}\nCreated At: ${fileTracing.createdAt}"),
            ),
          );
        },
      ),
    );
  }
}
