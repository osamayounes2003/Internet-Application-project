import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CustomComponent/BaseScreen.dart';
import '../../Theme/ThemeController.dart';
import '../../color_.dart';
import '../Groups/models/Groups_Model.dart';
import 'package:file_manager_internet_applications_project/user/Reports/FileReports_Controller.dart';

class FileDetailsScreen extends StatelessWidget {
  const FileDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>?;

    if (arguments == null || arguments['file'] == null) {
      return BaseScreen(
        child: Center(
          child: Text(
            'No file data available',
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
        ),
      );
    }

    final File file = arguments['file'];
    final int folderId = file.folderId;

    final downloadReportController = Get.put(DownloadFileReportController());

    final themeController = Get.find<ThemeController>();
    String currentTheme = themeController.currentTheme.value;

    final bool isWeb = MediaQuery.of(context).size.width > 600;

    return BaseScreen(
      child: Align(
        alignment: Alignment.topLeft,
        child: Card(
          margin: const EdgeInsets.all(20),
          elevation: 10,
          color: AppColors.background2(context, currentTheme),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: isWeb ? 600 : double.infinity,
            height: 400,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.report_problem,
                      color: AppColors.primary(context, currentTheme),
                    ),
                    onPressed: () {
                      downloadReportController.downloadReportForFile(file.id, folderId);
                    },
                  ),
                ),
                isWeb
                    ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.insert_drive_file,
                        size: 50,
                        color: AppColors.primary(context, currentTheme),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "File Name: ${file.name}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.font(context, currentTheme),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Status: ${file.status}",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.gray(context, currentTheme),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Folder ID: ${file.folderId}",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.gray(context, currentTheme),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            file.bookedUser != null
                                ? "Booked by: ${file.bookedUser!.fullname}"
                                : "No user booked",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.gray(context, currentTheme),
                            ),
                          ),
                          file.bookedUser == null
                              ? ElevatedButton(
                            onPressed: () {
                              // إضافة عملية Check In
                            },
                            child: Text("Check In"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary(context, currentTheme),
                            ),
                          )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.insert_drive_file,
                      size: 50,
                      color: AppColors.primary(context, currentTheme),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "File Name: ${file.name}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.font(context, currentTheme),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Status: ${file.status}",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.gray(context, currentTheme),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Folder ID: ${file.folderId}",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.gray(context, currentTheme),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      file.bookedUser != null
                          ? "Booked by: ${file.bookedUser!.fullname}"
                          : "No user booked",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.gray(context, currentTheme),
                      ),
                    ),
                    file.bookedUser == null
                        ? ElevatedButton(
                      onPressed: () {
                        // إضافة عملية Check In
                      },
                      child: Text("Check In"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary(context, currentTheme),
                      ),
                    )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
