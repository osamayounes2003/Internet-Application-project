import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'UploadFile_Model.dart';
import 'UploadFile_Services.dart';

class FileUploadController extends GetxController {
  RxString selectedFileName = ''.obs;
  RxList<int> selectedFileBytes = RxList<int>();
  RxBool isUploading = false.obs;
  FileUploadService fileUploadService = FileUploadService();

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
            selectedFileBytes.value = result.files.single.bytes ?? [];
        selectedFileName.value = result.files.single.name;
    } else {
      selectedFileName.value = '';
      Get.snackbar('Error', 'No file selected', snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> uploadFile(int groupId) async {
    if (selectedFileName.value.isEmpty ||  selectedFileBytes.isEmpty) {
      Get.snackbar('Error', 'Please select a file before uploading', snackPosition: SnackPosition.BOTTOM);
    } else {
      isUploading.value = true;
      try {
        FileModel? uploadedFile;
          uploadedFile = await fileUploadService.uploadFileBytes(selectedFileBytes, selectedFileName.value, groupId);
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
