import 'package:get/get.dart';

class FileUpload_Controller extends GetxController {
  RxString selectedFileName = ''.obs;

  void selectFile(String fileName) {
    selectedFileName.value = fileName;
  }

  void uploadFile() {
    if (selectedFileName.value.isEmpty) {
      Get.snackbar("Error", "Please select a file before uploading",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar("Success", "File uploaded: ${selectedFileName.value}",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
