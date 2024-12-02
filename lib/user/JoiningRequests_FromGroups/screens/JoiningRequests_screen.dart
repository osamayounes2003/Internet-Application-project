import 'package:file_manager_internet_applications_project/CustomComponent/BaseScreen.dart';
import 'package:file_manager_internet_applications_project/user/JoiningRequests_FromGroups/controllers/InvitationController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Theme/ThemeController.dart';
import '../../../color_.dart';
import '../widgets/JoiningRequests_widgets.dart';

class JoiningRequests_screen extends StatelessWidget {
  JoiningRequests_screen({Key? key}) : super(key: key);

  final InvitationController _controller = Get.put(InvitationController());

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final currentTheme = themeController.currentTheme.value;

    return BaseScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          JoiningRequests_widgets.titleText("Joining Requests".tr, context),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              if (_controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (_controller.invitations.isEmpty) {
                return Center(
                  child: Text(
                    "No Joining Requests Available".tr,
                    style: TextStyle(color: AppColors.font(context, currentTheme)),
                  ),
                );
              }
              return ListView.builder(
                itemCount: _controller.invitations.length,
                itemBuilder: (context, index) {
                  final invitation = _controller.invitations[index];
                  return JoiningRequests_widgets.invitationCard(context, invitation, _controller);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
