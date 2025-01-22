import 'package:file_manager_internet_applications_project/user/files/my_booked_files/controller/booked_files_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../CustomComponent/BaseScreen.dart';
import '../../CustomComponent/CustomButton.dart';
import '../../SharedPreferences/shared_preferences_service.dart';
import '../../Theme/ThemeController.dart';
import '../../color_.dart';
import '../Groups/models/Groups_Model.dart';
import 'package:file_manager_internet_applications_project/user/Reports/FileReports_Controller.dart';
import 'package:http/http.dart' as http;
import 'FileTracingUser_Controller.dart';

class FileDetailsScreen extends StatefulWidget {
  const FileDetailsScreen({Key? key}) : super(key: key);

  @override
  _FileDetailsScreenState createState() => _FileDetailsScreenState();
}

class _FileDetailsScreenState extends State<FileDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize TabController with 2 tabs
    _tabController = TabController(length: 2, vsync: this);
  }

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
    MyBookedFilesController _MyBookedFilesController = Get.put(MyBookedFilesController());

    final themeController = Get.find<ThemeController>();
    String currentTheme = themeController.currentTheme.value;

    final bool isWeb = MediaQuery.of(context).size.width > 600;

    // Get the FileTracingUserController and call fetchFileTracing
    FileTracingUserController fileTracingUserController = Get.put(FileTracingUserController());
    fileTracingUserController.fetchFileTracing(file.id);
    fileTracingUserController.fetchBackupData(file.id);

    return BaseScreen(
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Card(
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
                      child: Tooltip(
                        message: 'Download file report', // Tooltip for the report icon
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
                                  color: AppColors.font(context, currentTheme),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Folder ID: ${file.folderId}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.font(context, currentTheme),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                file.bookedUser != null
                                    ? "Booked by: ${file.bookedUser!.fullname}"
                                    : "No user booked",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.font(context, currentTheme),
                                ),
                              ),
                              file.bookedUser == null
                                  ? Tooltip(
                                message: 'Check in this file', // Tooltip for Check In button
                                child: ElevatedButton(
                                  onPressed: () {
                                    _MyBookedFilesController.fileCheckIn(file.id);
                                  },
                                  child: Text("Check In"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary(context, currentTheme),
                                  ),
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
                            color: AppColors.font(context, currentTheme),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Folder ID: ${file.folderId}",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.font(context, currentTheme),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          file.bookedUser != null
                              ? "Booked by: ${file.bookedUser!.fullname}"
                              : "No user booked",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.font(context, currentTheme),
                          ),
                        ),
                        file.bookedUser == null
                            ? Tooltip(
                          message: 'Check in this file', // Tooltip for Check In button
                          child: ElevatedButton(
                            onPressed: () {
                              _MyBookedFilesController.fileCheckIn(file.id);
                            },
                            child: Text("Check In"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary(context, currentTheme),
                            ),
                          ),
                        )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Add TabBar here
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Tracing'),
                Tab(text: 'Backup'),
              ],
            ),
            // Add TabBarView here
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // First Tab: Tracing
                  Obx(() {
                    if (fileTracingUserController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (fileTracingUserController.fileTracingList.isEmpty) {
                      return Center(child: Text('No file tracings available'));
                    }

                    return ListView.builder(
                      itemCount: fileTracingUserController.fileTracingList.length,
                      itemBuilder: (context, index) {
                        final fileTracing = fileTracingUserController.fileTracingList[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          child: ListTile(
                            title: Text("User ID: ${fileTracing.userId}"),
                            subtitle: Text("Type: ${fileTracing.type}\nCreated At: ${fileTracing.createdAt}"),
                          ),
                        );
                      },
                    );
                  }),

                  // Second Tab: Backup
                  Center(
                    child: Obx(() {
                      if (fileTracingUserController.isLoading.value) {
                        return CircularProgressIndicator();
                      }

                      if (fileTracingUserController.backupList.isEmpty) {
                        return Text('No backup data available');
                      }

                      return ListView.builder(
                        itemCount: fileTracingUserController.backupList.length,
                        itemBuilder: (context, index) {
                          final backup = fileTracingUserController.backupList[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            child: ListTile(
                              title: Text(backup.name),
                              subtitle: Text("Created At: ${backup.createdAt}"),
                              trailing:  Tooltip(
                                message: 'Click Download File',
                                child: CustomElevatedButton(
                                  title: 'Download',
                                  onPressed: () async {
                                    // final url = "http://195.88.87.77:8888/api/v1/downloads/file?filename="+backup.name;
                                    // print(backup.name);
                                    // if (url != null && await canLaunchUrl(url as Uri)) {
                                    //   await launchUrl(url as Uri, forceSafariVC: false, forceWebView: false);
                                    // } else {
                                    //   // Handle the error if the URL can't be launched
                                    //   Get.snackbar('Error', 'Could not launch $url');
                                    final url = "http://195.88.87.77:8888/api/v1/downloads/file?filename=${Uri.encodeComponent(backup.name)}";
                          final token = await SharedPreferencesService().getToken();

                          if (token == null) {
                          Get.snackbar('Error', 'User is not authenticated');
                          return;
                          }

                          try {
                          final response = await http.get(
                          Uri.parse(url),
                          headers: {'Authorization': 'Bearer $token'},
                          );

                          if (response.statusCode == 200) {
                          print("File downloaded successfully");
                          } else {
                            print(response.reasonPhrase);
                          Get.snackbar('Error', 'Failed to download file: ${response.reasonPhrase}');
                          }
                          } catch (e) {
                          Get.snackbar('Error', 'An error occurred: $e');
                          }

                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
