import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'UploadFile_Model.dart';
import 'UploadFile_Services.dart';

class FileUploadController extends GetxController {
  RxString selectedFileName = ''.obs;
  RxBool isUploading = false.obs;
  FileUploadService fileUploadService = FileUploadService();

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      selectedFileName.value = result.files.single.path ?? '';
    } else {
      selectedFileName.value = '';
      Get.snackbar('Error', 'No file selected', snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> uploadFile() async {
    if (selectedFileName.value.isEmpty) {
      Get.snackbar('Error', 'Please select a file before uploading', snackPosition: SnackPosition.BOTTOM);
    } else {
      isUploading.value = true;
      try {
        FileModel? uploadedFile = await fileUploadService.uploadFile(selectedFileName.value);
        if (uploadedFile != null) {
          Get.snackbar('Success', 'File uploaded successfully: ${uploadedFile.name}', snackPosition: SnackPosition.BOTTOM);
        }
      } catch (e) {
        Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
      } finally {
        isUploading.value = false;
      }
    }
  }
}
