import 'package:file_manager_internet_applications_project/user/UploadFile/UploadFile_Controller.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class UploadFile_Screen extends StatelessWidget {
  final FileUpload_Controller fileUploadController = Get.put(FileUpload_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 600,
              width: double.infinity,
              color: Colors.black87,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/SelectFile.png",
                      height: 150,
                      width: 150,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        "Choose the file you want to upload",
                        style: TextStyle(color: Colors.white70, fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              FilePickerResult? result = await FilePicker.platform.pickFiles();
                              if (result != null) {
                                fileUploadController.selectFile(result.files.single.name);
                                print('Selected File: ${result.files.single.name}'); // عرض اسم الملف المختار في Debug
                              } else {
                                print('No file selected');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white24,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            child: const Text(
                              "Storage",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                padding: EdgeInsets.all(40),
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Obx(() {
                    return Text(
                      fileUploadController.selectedFileName.value.isNotEmpty
                          ? fileUploadController.selectedFileName.value
                          : "No file selected",
                      style: TextStyle(color: Colors.black87),
                    );
                  }),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                fileUploadController.uploadFile();
              },
              child: Column(
                children: [
                  Image.asset(
                    "assets/UploadFile.png",
                    height: 100,
                    width: 100,
                  ),
                  Text("Press to upload"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
