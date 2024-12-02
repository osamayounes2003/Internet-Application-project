import 'package:file_manager_internet_applications_project/CustomComponent/BaseScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Theme/ThemeController.dart';
import '../../../color_.dart';
import '../../Groups/controllers/Groups_Controller.dart';
import '../widgets/JoinRequestsUsers_widgets.dart';

class JoiningRequestUsers_screen extends StatelessWidget {
  JoiningRequestUsers_screen({Key? key}) : super(key: key);

  final GroupsController _groupsController = Get.put(GroupsController());

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final String currentTheme = themeController.currentTheme.value;

    return BaseScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          JoinRequestsUsers_widgets.header(context),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              if (_groupsController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (_groupsController.ownGroups.isEmpty) {
                return Center(
                  child: Text(
                    "no_groups_available".tr,
                    style: TextStyle(color: AppColors.textSecondary(context, currentTheme)),
                  ),
                );
              }
              return JoinRequestsUsers_widgets.list(
                _groupsController.ownGroups,
                context,
                currentTheme,
              );
            }),
          ),
        ],
      ),
    );
  }
}
