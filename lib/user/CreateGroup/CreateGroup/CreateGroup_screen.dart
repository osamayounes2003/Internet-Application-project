import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../CustomComponent/BaseScreen.dart';
import 'CreateGroup_Controller.dart';
import 'CreateGroup_widgets.dart';
import 'package:file_manager_internet_applications_project/color_.dart';

class CreateGroup_screen extends StatelessWidget {
  const CreateGroup_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CreateGroupController controller = Get.put(CreateGroupController());
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
                      CreateGroup_widgets.groupIcon(),
                      SizedBox(height: 20),
                      CreateGroup_widgets.createGroupText(),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        CreateGroup_widgets.groupNameField(controller),
                        SizedBox(height: 40),
                        Obx(() {
                          return CreateGroup_widgets.createButton(controller);
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
                      CreateGroup_widgets.groupIcon(),
                      SizedBox(height: 20),
                      CreateGroup_widgets.createGroupText(),
                    ],
                  ),
                  SizedBox(height: 20),
                  CreateGroup_widgets.groupNameField(controller),
                  SizedBox(height: 40),
                  Obx(() {
                    return CreateGroup_widgets.createButton(controller);
                  }),
                  SizedBox(height: 30),
                ],
              ),
              SizedBox(height: 30,),
              // Obx(() {
              //   return controller.group.value.id != null
              //    ? CreateGroup_widgets.additionalOptions(controller)
              //   : Container();
              // }
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
