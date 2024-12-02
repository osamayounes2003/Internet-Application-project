import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../color_.dart';
import '../controllers/CreateGroup_Controller.dart';

class CreateGroup_widgets {
  static Widget groupIcon(BuildContext context, String theme) {
    return Image.asset(
      "assets/GroupIcon (2).png",
      color: AppColors.gray(context, theme),
      height: 220,
    );
  }

  static Widget createGroupText(BuildContext context, String theme) {
    return Text(
      "create group".tr,
      style: TextStyle(color: AppColors.font(context, theme), fontSize: 25),
    );
  }

  static Widget groupNameField(BuildContext context, CreateGroupController controller, String theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 60.0, right: 60, top: 3),
      child: TextField(
        onChanged: (value) {
          controller.setGroupName(value);
        },
        style: TextStyle(color: AppColors.background2(context, theme)),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.edit,
            color: AppColors.gray(context, theme),
          ),
          hintText: "enter group name".tr,
          hintStyle: TextStyle(color: AppColors.gray(context, theme)),
        ),
      ),
    );
  }

  static Widget createButton(BuildContext context, CreateGroupController controller, String theme) {
    return ElevatedButton(
      onPressed: () async {
        if (controller.groupName.value.isEmpty) {
          Get.snackbar(
            'error'.tr,
            'please enter a group name'.tr,
            backgroundColor: AppColors.background(context, theme),
            colorText: AppColors.font(context, theme),
          );
          return;
        }
        bool isCreated = await controller.createGroup(controller.groupName.value);
        if (isCreated) {
          Get.snackbar(
            'success'.tr,
            'group created successfully'.tr,
            backgroundColor: AppColors.background(context, theme),
            colorText: AppColors.font(context, theme),
          );
        } else {
          Get.snackbar(
            'error'.tr,
            'failed to create group'.tr,
            backgroundColor: AppColors.background(context, theme),
            colorText: AppColors.font(context, theme),
          );
        }
      },
      child: Text(
        "create".tr,
        style: TextStyle(color: AppColors.white(context, theme)),
      ),
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
        backgroundColor: controller.groupName.value.isNotEmpty
            ? AppColors.primary(context, theme)
            : AppColors.button(context, theme),
      ),
    );
  }
}
