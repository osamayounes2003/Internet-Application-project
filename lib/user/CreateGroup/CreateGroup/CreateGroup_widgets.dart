import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'CreateGroup_Controller.dart';
import 'package:file_manager_internet_applications_project/color_.dart';

class CreateGroup_widgets {
  static Widget groupIcon() {
    return Image.asset(
      "assets/GroupIcon (2).png",
      color: color_.gray,
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
        if (controller.groupName.value.isEmpty) {
          Get.snackbar('Error', 'Please enter a group name');
          return;
        }
        bool isCreated = await controller.createGroup(controller.groupName.value);
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
            ? color_.background2
            : color_.button,
      ),
    );
  }
}
