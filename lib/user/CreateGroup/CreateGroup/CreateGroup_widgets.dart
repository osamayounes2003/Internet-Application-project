import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'CreateGroup_Controller.dart';
import 'package:file_manager_internet_applications_project/color_.dart';

class CreateGroup_widgets {
  static Widget groupIcon() {
    return Image.asset(
      "assets/GroupIcon (2).png",
      color: color_.button,
      height: 220,
    );
  }

  static Widget createGroupText() {
    return Text(
      "Create a Group",
      style: TextStyle(color: color_.font, fontSize: 25),
    );
  }

  static Widget groupNameField(CreateGroupController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 60.0, right: 60, top: 3),
      child: TextField(
        onChanged: (value) {
          controller.setGroupName(value);
        },
        style: TextStyle(color: color_.gray),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.edit,
            color: color_.gray,
          ),
          hintText: "Enter group name",
        ),
      ),
    );
  }

  static Widget createButton(CreateGroupController controller) {
    return ElevatedButton(
      onPressed: () async {
        bool isCreated =
            await controller.createGroup(controller.groupName.value);
        if (isCreated) {
          Get.snackbar('Success', 'Group created successfully');
        } else {
          Get.snackbar('Error', 'Failed to create group');
        }
      },
      child: Text(
        "Create",
        style: TextStyle(color: color_.white),
      ),
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        padding: EdgeInsets.only(left: 60, right: 60, bottom: 15, top: 15),
        backgroundColor: controller.groupName.value.isNotEmpty
            ? color_.black
            : color_.button,
      ),
    );
  }

  static Widget additionalOptions(CreateGroupController controller) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () async {
                final result =
                    await FilePicker.platform.pickFiles(allowMultiple: true);
                if (result != null) {
                  final List<PlatformFile> files = result.files;
                  controller.addFiles(files);
                  Get.snackbar('Success', 'Files added successfully');
                } else {
                  Get.snackbar('Info', 'No files selected');
                }
              },
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.toNamed("/upload", arguments: {'groupId': controller.group.value.id});
                    },
                    icon: Row(
                      children: [
                        Icon(
                          Icons.file_copy_outlined,
                          size: 40,
                          color: color_.gray,
                        ),
                        SizedBox(width: 15),
                        Text(
                          "Add File",
                          style: TextStyle(fontSize: 17, color: color_.gray),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Get.toNamed("/AddMembers",
                    arguments: {'groupId': controller.group.value.id});
                print(
                    "..................................${controller.group.value.id}");
              },
              icon: Row(
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 40,
                    color: color_.gray,
                  ),
                  SizedBox(width: 15),
                  Text(
                    "Add Members",
                    style: TextStyle(fontSize: 17, color: color_.gray),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
