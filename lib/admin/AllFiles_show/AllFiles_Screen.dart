import 'package:file_manager_internet_applications_project/CustomComponent/BaseScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../color_.dart';
import '../../../Theme/ThemeController.dart';
import '../../user/Reports/FileReports_Controller.dart';
import 'AllFiles_Controller.dart';

class AllFilesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FileController fileController = Get.put(FileController());
    final ThemeController themeController = Get.find<ThemeController>();
    final String currentTheme = themeController.currentTheme.value;
    final downloadReportController = Get.put(DownloadFileReportController());

    return BaseScreen(
      child: Obx(() {
        if (fileController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (fileController.files.isEmpty) {
          return Center(child: Text("No files available."));
        }

        return ListView.builder(
          itemCount: fileController.files.length,
          itemBuilder: (context, index) {
            final file = fileController.files[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              color: AppColors.background(context, currentTheme),
              child: ListTile(
                leading: Icon(
                  file['status'] == 'AVAILABLE' ? Icons.check_circle : Icons.warning,
                  color: file['status'] == 'AVAILABLE' ? Colors.green : Colors.red,
                ),
                title: Text(
                  file['name'],
                  style: TextStyle(color: AppColors.font(context, currentTheme)),
                ),
                subtitle: Text(
                  "Status: ${file['status']}\nBooked by: ${file['bookedUser']?['fullname'] ?? 'None'}",
                  style: TextStyle(color: AppColors.gray(context, currentTheme)),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.download, color: AppColors.primary(context, currentTheme)),
                  onPressed: () {
                    downloadReportController.downloadReportForFile(file['id'], file['folderId']);
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
