import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../CustomComponent/BaseScreen.dart';
import '../../Theme/ThemeController.dart';
import '../CreateGroup/widgets/CreateGroup_widgets.dart';
import 'UpdateGroupInfo_Controller.dart';
import '../../../../color_.dart';

class UpdateGroupInfo_Screen extends StatelessWidget {
  const UpdateGroupInfo_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    String currentTheme = themeController.currentTheme.value;

    final Map<String, dynamic>? arguments = Get.arguments;

    if (arguments == null ||
        arguments['groupId'] == null ||
        arguments['groupName'] == null ||
        arguments['settings'] == null) {
      return BaseScreen(
        child: Center(
          child: Text(
            "invalid_data_provided".tr,
            style: TextStyle(
              color: AppColors.font(context, currentTheme),
              fontSize: 18,
            ),
          ),
        ),
      );
    }

    final int groupId = arguments?['groupId'] ?? 0;
    final groupName = arguments!['groupName'];
    final settings = arguments!['settings'];

    final GroupSettingsController controller = Get.put(GroupSettingsController(groupId: groupId, settings: settings, name: groupName));
    final bool isWeb = MediaQuery.of(context).size.width > 600;

    return BaseScreen(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0, left: 40, right: 40),
          child: Column(
            children: [
              isWeb
                  ? Row(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 30),
                      CreateGroup_widgets.groupIcon(context, currentTheme),
                      SizedBox(height: 20),
                      Text(
                        "edit_group_settings".tr,
                        style: TextStyle(
                          fontSize: 25,
                          color: AppColors.font(context, currentTheme),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60.0),
                          child: TextField(
                            onChanged: (value) {
                              controller.groupName.value = value;
                            },
                            style: TextStyle(color: AppColors.font(context, currentTheme)),
                            controller: TextEditingController(text: controller.groupName.value),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.edit, color: AppColors.button(context, currentTheme)),
                              hintText: "enter_new_group_name".tr,  // Use translation key
                              hintStyle: TextStyle(color: AppColors.gray(context, currentTheme)),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),

                        Obx(() {
                          return SwitchListTile(
                            title: Text(
                              "private_folder".tr,  // Use translation key
                              style: TextStyle(color: AppColors.font(context, currentTheme)),
                            ),
                            value: controller.isPrivate.value,
                            onChanged: (value) {
                              controller.isPrivate.value = value;
                            },
                            activeColor: AppColors.button(context, currentTheme),
                            inactiveThumbColor: AppColors.font(context, currentTheme),
                          );
                        }),

                        Obx(() {
                          return SwitchListTile(
                            title: Text(
                              "disable_add_file".tr,
                              style: TextStyle(color: AppColors.font(context, currentTheme)),
                            ),
                            value: controller.disableAddFile.value,
                            onChanged: (value) {
                              controller.disableAddFile.value = value;
                            },
                            activeColor: AppColors.button(context, currentTheme),
                            inactiveThumbColor: AppColors.font(context, currentTheme),
                          );
                        }),

                        SizedBox(height: 30),

                        ElevatedButton(
                          onPressed: () {
                            controller.updateGroupSettings();
                          },
                          child: Text("update_settings".tr),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                            backgroundColor: AppColors.button(context, currentTheme),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
                  : Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "edit_group_settings".tr,
                    style: TextStyle(
                      fontSize: 25,
                      color: AppColors.font(context, currentTheme),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60.0),
                    child: TextField(
                      onChanged: (value) {
                        controller.groupName.value = value;
                      },
                      style: TextStyle(color: AppColors.font(context, currentTheme)),
                      controller: TextEditingController(text: controller.groupName.value),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.edit, color: AppColors.button(context, currentTheme)),
                        hintText: "enter_new_group_name".tr,  // Use translation key
                        hintStyle: TextStyle(color: AppColors.gray(context, currentTheme)),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),

                  Obx(() {
                    return SwitchListTile(
                      title: Text(
                        "private_folder".tr,
                        style: TextStyle(color: AppColors.font(context, currentTheme)),
                      ),
                      value: controller.isPrivate.value,
                      onChanged: (value) {
                        controller.isPrivate.value = value;
                      },
                      activeColor: AppColors.button(context, currentTheme),
                      inactiveThumbColor: AppColors.font(context, currentTheme),
                    );
                  }),

                  Obx(() {
                    return SwitchListTile(
                      title: Text(
                        "disable_add_file".tr,  // Use translation key
                        style: TextStyle(color: AppColors.font(context, currentTheme)),
                      ),
                      value: controller.disableAddFile.value,
                      onChanged: (value) {
                        controller.disableAddFile.value = value;
                      },
                      activeColor: AppColors.button(context, currentTheme),
                      inactiveThumbColor: AppColors.font(context, currentTheme),
                    );
                  }),

                  SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: () {
                      controller.updateGroupSettings();
                    },
                    child: Text("update_settings".tr),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                      backgroundColor: AppColors.button(context, currentTheme),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
