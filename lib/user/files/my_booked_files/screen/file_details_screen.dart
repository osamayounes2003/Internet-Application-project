import 'package:file_manager_internet_applications_project/user/FileDetailes/FileTracingUser_Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../CustomComponent/CustomButton.dart';
import '../../../../SharedPreferences/shared_preferences_service.dart';
import '../../../UploadFile/UploadFile_Model.dart';
import '../../check_out_file/controller/check_out_controller.dart';
import '../controller/booked_files_controller.dart';
import '../model/file_model.dart';
import '../widgets/detail_row.dart';

class FileDetails extends StatelessWidget {
  final Content file;

  FileDetails({Key? key, required this.file}) : super(key: key);
  final CheckoutController checkoutController = Get.put(CheckoutController());
  final FileTracingUserController fileTracingUserController =
      Get.put(FileTracingUserController());

  @override
  Widget build(BuildContext context) {
    fileTracingUserController.fetchBackupData(file.id);

    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(file.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
        child: ListView(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                // Responsive padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailRow(label: 'Name:', value: file.name ?? 'Unknown'),
                    DetailRow(
                      label: 'Status:',
                      value: file.status == 'UNAVAILABLE'
                          ? '!${file.status}'
                          : 'AVAILABLE',
                    ),
                    SizedBox(height: screenWidth * 0.04), // Responsive spacing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Tooltip(
                          message: 'Click Check Out File',
                          child: CustomElevatedButton(
                            title: 'Check Out',
                            onPressed: () {
                              checkoutController.showCheckoutDialog(file.id);
                            },
                          ),
                        ),
                        Tooltip(
                          message: 'Click Download File',
                          child: CustomElevatedButton(
                            title: 'Download',
                            onPressed: () async {
                              final url = file.url;
                              print(file.url);
                              if (url != null && await canLaunch(url)) {
                                await launch(url,
                                    forceSafariVC: false, forceWebView: false);
                              } else {
                                // Handle the error if the URL can't be launched
                                Get.snackbar('Error', 'Could not launch $url');
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Obx(() {
                if (fileTracingUserController.isLoading.value) {
                  return CircularProgressIndicator();
                }

                if (fileTracingUserController.backupList.isEmpty) {
                  return Text('No backup data available');
                }

                return Container(
                  height: 500,
                  child: ListView.builder(
                    itemCount: fileTracingUserController.backupList.length,
                    itemBuilder: (context, index) {
                      final backup = fileTracingUserController.backupList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: ListTile(
                          title: Text(backup.name),
                          subtitle: Text("Created At: ${backup.createdAt}"),
                          trailing: Tooltip(
                            message: 'Click Download File',
                            child: CustomElevatedButton(
                              title: 'Download',
                              onPressed: () async {
                                final url =
                                    "http://195.88.87.77:8888/api/v1/downloads/file?filename=${backup.name}/${backup.name}";
                                print(backup.name);

                                if (url != null && await canLaunch(url)) {
                                  await launch(url,
                                      forceSafariVC: false, forceWebView: false);
                                } else {
                                  // Handle the error if the URL can't be launched
                                  Get.snackbar('Error', 'Could not launch $url');
                                }

                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
