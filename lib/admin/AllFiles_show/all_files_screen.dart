import 'package:file_manager_internet_applications_project/CustomComponent/BaseScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../color_.dart';
import '../../../Theme/ThemeController.dart';
import '../../CustomComponent/ToolTip.dart';
import '../../user/FileDetailes/file_tracing_controller.dart';
import '../../user/Groups/models/Groups_Model.dart';
import '../../user/Reports/FileReports_Controller.dart';
import '../AllGroup-Show/AllGroupShow_controller.dart';
import 'AllFiles_Controller.dart';

class AllFilesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AllfilesController fileController = Get.put(AllfilesController());
    final ThemeController themeController = Get.find<ThemeController>();
    final String currentTheme = themeController.currentTheme.value;
    final downloadReportController = Get.put(DownloadFileReportController());
    final fileTracingController = Get.put(FileTracingController());

    return BaseScreen(
      child: Obx(() {
        if (fileController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (fileController.files.isEmpty) {
          return Center(child: Text("No files available."));
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: fileController.files.length,
                itemBuilder: (context, index) {
                  final file = fileController.files[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    color: AppColors.background(context, currentTheme),
                    child: ListTile(
                      leading: CustomTooltip(
                        message: file['status'] == 'AVAILABLE' ? 'File is available' : 'File is not available',
                        child: Icon(
                          file['status'] == 'AVAILABLE' ? Icons.check_circle : Icons.warning,
                          color: file['status'] == 'AVAILABLE' ? Colors.green : Colors.red,
                        ),
                      ),
                      title: CustomTooltip(
                        message: "File name: ${file['name']}",
                        child: Text(
                          file['name'],
                          style: TextStyle(color: AppColors.font(context, currentTheme)),
                        ),
                      ),
                      subtitle: CustomTooltip(
                        message: "Status: ${file['status']}\nBooked by: ${file['bookedUser']?['fullname'] ?? 'None'}",
                        child: Text(
                          "Status: ${file['status']}\nBooked by: ${file['bookedUser']?['fullname'] ?? 'None'}",
                          style: TextStyle(color: AppColors.gray(context, currentTheme)),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTooltip(
                            message: 'Download file',
                            child: IconButton(
                              icon: Icon(Icons.download, color: AppColors.primary(context, currentTheme)),
                              onPressed: () {
                                downloadReportController.downloadReportForFile(file['id'], file['folderId']);
                              },
                            ),
                          ),
                          CustomTooltip(
                            message: 'delete file',
                            child: IconButton(
                              icon: Icon(Icons.delete,
                                  color: AppColors.primary(context, currentTheme)),
                              onPressed: () {
                                fileController.deleteFile(file['id']);
                              },
                            ),
                          ),
                          CustomTooltip(
                            message: 'file tracing',
                            child: IconButton(
                              icon: Icon(Icons.track_changes,
                                  color: AppColors.primary(context, currentTheme)),
                              onPressed: () {
                                _showFileTracingDialog(context, file['id'], fileTracingController);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (fileController.totalPages.value > 1)
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 8.0,
                  children: List.generate(fileController.totalPages.value, (pageIndex) {
                    return ElevatedButton(
                      onPressed: () {
                        fileController.fetchFiles(pageIndex);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: pageIndex == fileController.currentPage.value
                            ? AppColors.primary(context, currentTheme)
                            : AppColors.gray(context, currentTheme),
                      ),
                      child: Text((pageIndex + 1).toString()),
                    );
                  }),
                ),
              ),
          ],
        );
      }),
    );
  }

  void _showFileTracingDialog(BuildContext context, int folderId, FileTracingController fileTracingController) async {
    final GroupsAdminController groupsController = Get.find<GroupsAdminController>();

    List<UserInFolder> usersInFolder = await groupsController.getUsersByFolderId(folderId);

    List<DropdownMenuItem<int>> userItems = [
      DropdownMenuItem(value: 0, child: Text("Any User")),
      ...usersInFolder.map((userInFolder) {
        return DropdownMenuItem(
          value: userInFolder.user.id,
          child: Text(userInFolder.user.fullname ?? 'Unknown User'),
        );
      }),
    ];

    List<DropdownMenuItem<String>> typeItems = [
      DropdownMenuItem(value: "", child: Text("Both")),
      DropdownMenuItem(value: "CHECK_IN", child: Text("Check In")),
      DropdownMenuItem(value: "CHECK_OUT", child: Text("Check Out")),
    ];

    if (!userItems.any((item) => item.value == fileTracingController.selectedUserId.value)) {
      fileTracingController.selectedUserId.value = 0;
    }
    if (!typeItems.any((item) => item.value == fileTracingController.selectedType.value)) {
      fileTracingController.selectedType.value = "";
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("File Tracing"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton<int>(
                  value: fileTracingController.selectedUserId.value,
                  onChanged: (value) {
                    fileTracingController.selectedUserId.value = value!;
                  },
                  hint: Text("Select User"),
                  items: userItems,
                ),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  value: fileTracingController.selectedType.value,
                  onChanged: (value) {
                    fileTracingController.selectedType.value = value!;
                  },
                  hint: Text("Select Type"),
                  items: typeItems,
                ),
                const SizedBox(height: 10),
                ListTile(
                  title: Text(
                    "Start Date: ${fileTracingController.startDate.value.toLocal()}",
                  ),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: fileTracingController.startDate.value,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      fileTracingController.startDate.value = pickedDate;
                    }
                  },
                ),
                ListTile(
                  title: Text(
                    "End Date: ${fileTracingController.endDate.value.toLocal()}",
                  ),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: fileTracingController.endDate.value,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      fileTracingController.endDate.value = pickedDate;
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                fileTracingController.sendFileTracingRequest(folderId);
                Get.back();
              },
              child: Text("Send Request"),
            ),
          ],
        );
      },
    );
  }
}
