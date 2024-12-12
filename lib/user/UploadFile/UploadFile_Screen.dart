import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CustomComponent/BaseScreen.dart';
import '../../Theme/ThemeController.dart';
import '../../color_.dart';
import 'UploadFile_Controller.dart';

class UploadFile_Screen extends StatelessWidget {
  final FileUploadController fileUploadController = Get.put(FileUploadController());

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    String currentTheme = themeController.currentTheme.value;

    final groupId = Get.arguments != null && Get.arguments.containsKey('groupId')
        ? Get.arguments['groupId']
        : null;

    return BaseScreen(
      child: Scaffold(
        backgroundColor: AppColors.scaffold(context, currentTheme),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                color: AppColors.background(context, currentTheme),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/SelectFile.png",
                        height: 150,
                        width: 150,
                        color: AppColors.button(context, currentTheme),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          "choose_file_to_upload".tr, // Translated text
                          style: TextStyle(
                            color: AppColors.font(context, currentTheme),
                            fontSize: 25,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Tooltip(
                          message: "Select a file from your device",
                          child: ElevatedButton(
                            onPressed: () async {
                              await fileUploadController.selectFile();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.button(context, currentTheme),
                            ),
                            child: Text(
                              "select_file".tr,
                              style: TextStyle(color: AppColors.font(context, currentTheme)), // Translated text
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // File name display box
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  padding: EdgeInsets.all(40),
                  width: MediaQuery.of(context).size.width > 600 ? 400 : 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.gray(context, currentTheme),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Obx(() {
                      return Tooltip(
                        message: "Currently selected file",
                        child: Text(
                          fileUploadController.selectedFileName.value.isNotEmpty
                              ? fileUploadController.selectedFileName.value
                              : "no_file_selected".tr, // Translated text
                          style: TextStyle(color: AppColors.font(context, currentTheme)), // Dynamic text color
                        ),
                      );
                    }),
                  ),
                ),
              ),
              // Upload Button Section
              Tooltip(
                message: "Tap to upload the selected file",
                child: InkWell(
                  onTap: () async {
                    await fileUploadController.uploadFile(groupId);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/UploadFile.png",
                        height: 100,
                        width: 100,
                        color: AppColors.button(context, currentTheme),
                      ),
                      Text(
                        "press_to_upload".tr, // Translated text
                        style: TextStyle(color: AppColors.font(context, currentTheme)), // Dynamic font color
                      ),
                    ],
                  ),
                ),
              ),
              // Uploading Indicator
              Obx(() {
                return fileUploadController.isUploading.value
                    ? CircularProgressIndicator()
                    : SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }
}