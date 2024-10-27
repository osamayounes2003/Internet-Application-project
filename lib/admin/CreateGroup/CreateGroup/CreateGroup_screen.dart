import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'CreateGroup_Controller.dart';

import 'CreateGroup_widgets.dart';

class CreateGroup_screen extends StatelessWidget {
  const CreateGroup_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CreateGroupController controller = Get.put(CreateGroupController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0, left: 40, right: 40),
          child: Center(
            child: Column(
              children: [
                CreateGroup_widgets.groupIcon(),
                SizedBox(height: 20,),
                CreateGroup_widgets.createGroupText(),
                SizedBox(height: 20,),
                CreateGroup_widgets.groupNameField(controller),
                SizedBox(height: 40),
                Obx(() {
                  return CreateGroup_widgets.createButton(controller);
                }),
                SizedBox(height: 30),
                Obx(() {
                  return controller.group.value.id != null
                      ? CreateGroup_widgets.additionalOptions(controller)
                      : Container();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:file_picker/file_picker.dart';
// import 'CreateGroup_Controller.dart';
// import 'package:file_manager_internet_applications_project/color_.dart';
//
// class CreateGroup_screen extends StatelessWidget {
//   const CreateGroup_screen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final CreateGroupController controller = Get.put(CreateGroupController());
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 80.0, left: 40, right: 40),
//           child: Center(
//             child: Column(
//               children: [
//                 Image.asset(
//                   "assets/GroupIcon (2).png",
//                   color: color_.black,
//                   height: 220,
//                 ),
//                 SizedBox(height: 20,),
//                 Text(
//                   "Create a Group",
//                   style: TextStyle(color: color_.black, fontSize: 25),
//                 ),
//                 SizedBox(height: 20,),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 60.0, right: 60, top: 3),
//                   child: TextField(
//                     onChanged: (value) {
//                       controller.setGroupName(value);
//                     },
//                     style: TextStyle(color: color_.gray),
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(
//                         Icons.edit,
//                         color: color_.black,
//                       ),
//                       hintText: "Enter group name",
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 40),
//                 Obx(() {
//                   return ElevatedButton(
//                     onPressed: () async {
//                       bool isCreated = await controller.createGroup(controller.groupName.value);
//                       if (isCreated) {
//                         Get.snackbar('Success', 'Group created successfully');
//                       } else {
//                         Get.snackbar('Error', 'Failed to create group');
//                       }
//                     },
//                     child: Text(
//                       "Create",
//                       style: TextStyle(color: color_.white),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       ),
//                       padding: EdgeInsets.only(left: 60, right: 60, bottom: 15, top: 15),
//                       backgroundColor: controller.groupName.value.isNotEmpty
//                           ? color_.black
//                           : color_.gray,
//                     ),
//                   );
//                 }),
//                 SizedBox(height: 30),
//                 Obx(() {
//                   return controller.group.value.id != null
//                       ? Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           IconButton(
//                             onPressed: () async {
//                               final result = await FilePicker.platform.pickFiles(allowMultiple: true);
//                               if (result != null) {
//                                 final List<PlatformFile> files = result.files;
//                                 controller.addFiles(files);
//                                 Get.snackbar('Success', 'Files added successfully');
//                               } else {
//                                 Get.snackbar('Info', 'No files selected');
//                               }
//                             },
//                             icon: Row(
//                               children: [
//                                 Icon(
//                                   Icons.file_copy_outlined,
//                                   size: 40,
//                                   color: color_.black,
//                                 ),
//                                 SizedBox(width: 15),
//                                 Text(
//                                   "Add Files",
//                                   style: TextStyle(fontSize: 17),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 30),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               Get.toNamed("/AddMembers", arguments: {
//                                 'groupId': controller.group.value.id
//                               });
//                               print("..................................${controller.group.value.id}");
//                             },
//                             icon: Row(
//                               children: [
//                                 Icon(
//                                   Icons.account_circle,
//                                   size: 40,
//                                   color: color_.black,
//                                 ),
//                                 SizedBox(width: 15),
//                                 Text(
//                                   "Add Members",
//                                   style: TextStyle(fontSize: 17),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   )
//                       : Container();
//                 }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




