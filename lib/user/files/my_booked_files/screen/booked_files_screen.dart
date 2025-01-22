// import 'package:file_manager_internet_applications_project/user/files/booked_files_by_folder/screen/file_details_screen.dart';
import 'package:file_manager_internet_applications_project/user/files/my_booked_files/model/file_model.dart';
import 'package:file_manager_internet_applications_project/user/files/my_booked_files/screen/file_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../CustomComponent/BaseScreen.dart';
import '../../../../CustomComponent/ToolTip.dart';
import '../../../../Theme/ThemeController.dart';
import '../../../../color_.dart';
import '../controller/booked_files_controller.dart';

class MyBookedFiles extends StatelessWidget {
  const MyBookedFiles({super.key});

  @override
  Widget build(BuildContext context) {
    final MyBookedFilesController controller = Get.put(MyBookedFilesController());
    final ThemeController themeController = Get.find<ThemeController>();
    final String currentTheme = themeController.currentTheme.value;

    return BaseScreen(
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.myBookedFiles.isEmpty) {
          return Center(child: Text("No files available."));
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.myBookedFiles.length,
                itemBuilder: (context, index) {
                  final file = controller.myBookedFiles[index];
                  return InkWell(
                    onTap: (){
                      Get.to(FileDetails(file: file));
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      color: AppColors.background(context, currentTheme),
                      child: ListTile(
                        leading: CustomTooltip(
                          message: file.status == 'AVAILABLE' ? 'File is available' : 'File is not available',
                          child: Icon(
                            file.status == 'AVAILABLE' ? Icons.check_circle : Icons.warning,
                            color: file.status == 'AVAILABLE' ? Colors.green : Colors.red,
                          ),
                        ),
                        title: CustomTooltip(
                          message: "File name: ${file.name}",
                          child: Text(
                              file.name ,
                            style: TextStyle(color: AppColors.font(context, currentTheme)),
                          ),
                        ),
                        subtitle: CustomTooltip(
                          message: "Status: ${file.status}\nBooked by: ${file.bookedUser?.fullname ?? 'None'}",
                          child: Text(
                            "Status: ${file.status}\nBooked by: ${file.bookedUser?.fullname ?? 'None'}",
                            style: TextStyle(color: AppColors.gray(context, currentTheme)),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (controller.totalPages.value > 1)
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 8.0,
                  children: List.generate(controller.totalPages.value, (pageIndex) {
                    return ElevatedButton(
                      onPressed: () {
                        print(pageIndex);
                        controller.fetchBookedFiles(pageIndex);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: pageIndex == controller.currentPage.value
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
}
