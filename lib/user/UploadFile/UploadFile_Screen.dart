import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CustomComponent/BaseScreen.dart';
import 'UploadFile_Controller.dart';

class UploadFile_Screen extends StatelessWidget {
  final FileUploadController fileUploadController = Get.put(FileUploadController());

  @override
  Widget build(BuildContext context) {
    final groupId = Get.arguments != null && Get.arguments.containsKey('groupId')
        ? Get.arguments['groupId']
        : null;

    return BaseScreen(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
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
                        child: ElevatedButton(
                          onPressed: () async {
                            await fileUploadController.selectFile();
                          },
                          child: Text("Select File"),
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
                  width: MediaQuery.of(context).size.width > 600 ? 400 : 300,
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
                onTap: () async {
                  await fileUploadController.uploadFile(groupId);
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
