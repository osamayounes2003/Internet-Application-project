// import 'package:file_manager_internet_applications_project/CustomComponent/BaseScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'PendinfFile_Controller.dart';
//
// class PendingFile extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final PendingFileController fileController = Get.put(PendingFileController());
//
//     return BaseScreen(
//       child: Obx(() {
//         if (fileController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         if (fileController.files.isEmpty) {
//           return Center(child: Text("No files available."));
//         }
//
//         return ListView.builder(
//           itemCount: fileController.files.length,
//           itemBuilder: (context, index) {
//             final file = fileController.files[index];
//             return Card(
//               margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//               child: ListTile(
//                 leading: Icon(
//                   file.status == 'PENDING' ? Icons.warning : Icons.check_circle,
//                   color: file.status == 'PENDING' ? Colors.red : Colors.green,
//                 ),
//                 title: Text(file.name),
//                 subtitle: Text("Status: ${file.status}"),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.check, color: Colors.green),
//                       onPressed: () {
//                         fileController.updateFileStatus(file.id, true);
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.close, color: Colors.red),
//                       onPressed: () {
//                         fileController.updateFileStatus(file.id, false);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
import 'package:file_manager_internet_applications_project/CustomComponent/BaseScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'PendinfFile_Controller.dart';

class PendingFile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PendingFileController fileController = Get.put(PendingFileController());

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
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      leading: Icon(
                        file.status == 'PENDING' ? Icons.warning : Icons.check_circle,
                        color: file.status == 'PENDING' ? Colors.red : Colors.green,
                      ),
                      title: Text(file.name),
                      subtitle: Text("Status: ${file.status}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.check, color: Colors.green),
                            onPressed: () {
                              fileController.updateFileStatus(file.id, true);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.red),
                            onPressed: () {
                              fileController.updateFileStatus(file.id, false);
                            },
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
                            ? Colors.blue
                            : Colors.grey,
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
