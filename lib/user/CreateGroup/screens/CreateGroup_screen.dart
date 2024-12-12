import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../CustomComponent/BaseScreen.dart';
import '../../../Theme/ThemeController.dart';
import '../controllers/CreateGroup_Controller.dart';
import '../../../../color_.dart';

class CreateGroup_screen extends StatelessWidget {
  const CreateGroup_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CreateGroupController controller = Get.put(CreateGroupController());
    final ThemeController themeController = Get.find<ThemeController>();
    final String currentTheme = themeController.currentTheme.value;
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
                      const SizedBox(height: 30),
                      Image.asset(
                        "assets/GroupIcon (2).png",
                        color: AppColors.gray(context, currentTheme),
                        height: 220,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "create group".tr,
                        style: TextStyle(
                            color: AppColors.font(context, currentTheme), fontSize: 25),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.only(left: 60.0, right: 60, top: 3),
                          child: Tooltip(
                            message: "Enter the name of the group",
                            child: TextField(
                              onChanged: (value) {
                                controller.setGroupName(value);
                              },
                              style: TextStyle(
                                  color: AppColors.background2(context, currentTheme)),
                              decoration: InputDecoration(
                                prefixIcon: Tooltip(
                                  message: "Edit group name",
                                  child: Icon(
                                    Icons.edit,
                                    color: AppColors.gray(context, currentTheme),
                                  ),
                                ),
                                hintText: "enter group name".tr,
                                hintStyle: TextStyle(
                                    color: AppColors.gray(context, currentTheme)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Obx(() {
                          return Tooltip(
                            message: "Click to create the group",
                            child: ElevatedButton(
                              onPressed: () async {
                                if (controller.groupName.value.isEmpty) {
                                  Get.snackbar(
                                    'error'.tr,
                                    'please enter a group name'.tr,
                                    backgroundColor:
                                    AppColors.background(context, currentTheme),
                                    colorText: AppColors.font(context, currentTheme),
                                  );
                                  return;
                                }
                                bool isCreated =
                                await controller.createGroup(controller.groupName.value);
                                if (isCreated) {
                                  Get.snackbar(
                                    'success'.tr,
                                    'group created successfully'.tr,
                                    backgroundColor:
                                    AppColors.background(context, currentTheme),
                                    colorText: AppColors.font(context, currentTheme),
                                  );
                                } else {
                                  Get.snackbar(
                                    'error'.tr,
                                    'failed to create group'.tr,
                                    backgroundColor:
                                    AppColors.background(context, currentTheme),
                                    colorText: AppColors.font(context, currentTheme),
                                  );
                                }
                              },
                              child: Text(
                                "create".tr,
                                style: TextStyle(
                                    color: AppColors.white(context, currentTheme)),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 60, vertical: 15),
                                backgroundColor: controller.groupName.value.isNotEmpty
                                    ? AppColors.primary(context, currentTheme)
                                    : AppColors.button(context, currentTheme),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              )
                  : Column(
                children: [
                  Column(
                    children: [
                      Tooltip(
                        message: "Group icon",
                        child: Image.asset(
                          "assets/GroupIcon (2).png",
                          color: AppColors.gray(context, currentTheme),
                          height: 220,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Tooltip(
                        message: "Create a new group",
                        child: Text(
                          "create group".tr,
                          style: TextStyle(
                              color: AppColors.font(context, currentTheme), fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0, right: 60, top: 3),
                    child: Tooltip(
                      message: "Enter the name of the group",
                      child: TextField(
                        onChanged: (value) {
                          controller.setGroupName(value);
                        },
                        style:
                        TextStyle(color: AppColors.background2(context, currentTheme)),
                        decoration: InputDecoration(
                          prefixIcon: Tooltip(
                            message: "Edit group name",
                            child: Icon(
                              Icons.edit,
                              color: AppColors.gray(context, currentTheme),
                            ),
                          ),
                          hintText: "enter group name".tr,
                          hintStyle: TextStyle(color: AppColors.gray(context, currentTheme)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Obx(() {
                    return Tooltip(
                      message: "Click to create the group",
                      child: ElevatedButton(
                        onPressed: () async {
                          if (controller.groupName.value.isEmpty) {
                            Get.snackbar(
                              'error'.tr,
                              'please enter a group name'.tr,
                              backgroundColor:
                              AppColors.background(context, currentTheme),
                              colorText: AppColors.font(context, currentTheme),
                            );
                            return;
                          }
                          bool isCreated =
                          await controller.createGroup(controller.groupName.value);
                          if (isCreated) {
                            Get.snackbar(
                              'success'.tr,
                              'group created successfully'.tr,
                              backgroundColor:
                              AppColors.background(context, currentTheme),
                              colorText: AppColors.font(context, currentTheme),
                            );
                          } else {
                            Get.snackbar(
                              'error'.tr,
                              'failed to create group'.tr,
                              backgroundColor:
                              AppColors.background(context, currentTheme),
                              colorText: AppColors.font(context, currentTheme),
                            );
                          }
                        },
                        child: Text(
                          "create".tr,
                          style:
                          TextStyle(color: AppColors.white(context, currentTheme)),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          padding:
                          const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                          backgroundColor: controller.groupName.value.isNotEmpty
                              ? AppColors.primary(context, currentTheme)
                              : AppColors.button(context, currentTheme),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
