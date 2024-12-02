import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../CustomComponent/BaseScreen.dart';
import '../../../Theme/ThemeController.dart';
import '../controllers/CreateGroup_Controller.dart';
import '../widgets/CreateGroup_widgets.dart';
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
                      SizedBox(height: 30),
                      CreateGroup_widgets.groupIcon(context, currentTheme),
                      SizedBox(height: 20),
                      CreateGroup_widgets.createGroupText(context, currentTheme),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        CreateGroup_widgets.groupNameField(context, controller, currentTheme),
                        SizedBox(height: 40),
                        Obx(() {
                          return CreateGroup_widgets.createButton(context, controller, currentTheme);
                        }),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              )
                  : Column(
                children: [
                  Column(
                    children: [
                      CreateGroup_widgets.groupIcon(context, currentTheme),
                      SizedBox(height: 20),
                      CreateGroup_widgets.createGroupText(context, currentTheme),
                    ],
                  ),
                  SizedBox(height: 20),
                  CreateGroup_widgets.groupNameField(context, controller, currentTheme),
                  SizedBox(height: 40),
                  Obx(() {
                    return CreateGroup_widgets.createButton(context, controller, currentTheme);
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
