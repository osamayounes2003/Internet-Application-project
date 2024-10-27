// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:file_picker/file_picker.dart';
//
// import '../CreateGroup/CreateGroup_Controller.dart';
//
// class AddFilesScreen extends StatelessWidget {
//   const AddFilesScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final CreateGroupController controller = Get.find<CreateGroupController>();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add Files"),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Get.back(result: controller.uploadedFiles);
//             },
//             child: Text(
//               "Done",
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//       body: Obx(() {
//         return ListView.builder(
//           itemCount: controller.uploadedFiles.length,
//           itemBuilder: (context, index) {
//             final file = controller.uploadedFiles[index];
//
//             return ListTile(
//               title: Text(file.name),
//               subtitle: Text(file.path ?? ''),
//               trailing: IconButton(
//                 icon: Icon(Icons.delete),
//                 onPressed: () {
//                   controller.uploadedFiles.removeAt(index);
//                 },
//               ),
//             );
//           },
//         );
//       }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final List<PlatformFile>? files = (await FilePicker.platform.pickFiles(allowMultiple: true)) as List<PlatformFile>?;
//
//           if (files != null) {
//             controller.addFiles(files); // Add the newly selected files
//           }
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }




// import 'package:file_manager_internet_applications_project/color_.dart';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:get/get.dart';
// import 'package:open_filex/open_filex.dart';
//
// class AddFiles_screen extends StatefulWidget {
//   const AddFiles_screen({Key? key}) : super(key: key);
//
//   @override
//   State<AddFiles_screen> createState() => _AddFiles_screenState();
// }
//
// class _AddFiles_screenState extends State<AddFiles_screen> {
//   List<PlatformFile> _uploadedFiles = [];
//   late int groupId; // Use late to ensure it's initialized
//
//   @override
//   void initState() {
//     super.initState();
//     if (Get.arguments != null && Get.arguments is int) {
//       groupId = Get.arguments as int; // Get the group ID passed from CreateGroup_screen
//     } else {
//       groupId = -1; // Default value indicating an error
//       print('Error: Group ID not passed or is not an int');
//     }
//   }
//
//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
//
//     if (result != null) {
//       setState(() {
//         _uploadedFiles.addAll(result.files);
//       });
//     } else {
//       print('File picking canceled');
//     }
//   }
//
//   void _openFile(PlatformFile file) async {
//     // Open the file using its path
//     print('Opening file: ${file.path}');
//     if (file.path != null) {
//       final result = await OpenFilex.open(file.path!);
//       print('Open file result: $result'); // Debugging line
//     } else {
//       print('File path is null');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(65.0),
//         child: AppBar(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(10),
//             ),
//           ),
//           title: Text(
//             'Add Files',
//             style: TextStyle(color: color_.white),
//           ),
//           backgroundColor: color_.black,
//           iconTheme: IconThemeData(color: color_.white),
//         ),
//       ),
//       body: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: _uploadedFiles.isEmpty
//                       ? Center(child: Text("No files uploaded yet."))
//                       : ListView.builder(
//                     itemCount: _uploadedFiles.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         leading: Icon(Icons.insert_drive_file, color: color_.black),
//                         title: Text(_uploadedFiles[index].name),
//                         onTap: () => _openFile(_uploadedFiles[index]), // Open file on tap
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 20,
//             right: 20,
//             child: FloatingActionButton(
//               onPressed: _pickFile,
//               backgroundColor: color_.black,
//               child: Icon(Icons.upload_file, color: color_.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
