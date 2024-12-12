import 'package:file_manager_internet_applications_project/CustomComponent/BaseScreen.dart';
import 'package:file_manager_internet_applications_project/user/JoiningRequests_FromGroups/controllers/InvitationController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Theme/ThemeController.dart';
import '../../../color_.dart';
import 'package:intl/intl.dart';

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder<ThemeController>(builder: (themeController) {
              final currentTheme = themeController.currentTheme.value;
              return Text(
                "Joining Requests".tr,
                style: TextStyle(
                  color: AppColors.textPrimary(context, currentTheme),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
          ),
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
                  return GetBuilder<ThemeController>(builder: (themeController) {
                    final currentTheme = themeController.currentTheme.value;
                    return Card(
                      color: AppColors.background2(context, currentTheme),
                      child: ListTile(
                        title: Text(
                          invitation.folderName,
                          style: TextStyle(color: AppColors.background(context, currentTheme)),
                        ),
                        subtitle: Text(
                          "Owner".tr + ": ${invitation.ownerName} \n " +
                              "Sent At".tr + ": ${DateFormat('yyyy-MM-dd HH:mm').format(invitation.sendAt)}",
                          style: TextStyle(color: AppColors.font(context, currentTheme)),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Tooltip(
                              message: "Accept Invitation",
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.background(context, currentTheme),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.check, color: Colors.green),
                                  onPressed: () => _controller.acceptInvitation(invitation.invitationId, invitation.folderId),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Tooltip(
                              message: "Reject Invitation",
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.background(context, currentTheme),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.close, color: Colors.red),
                                  onPressed: () => _controller.rejectInvitation(invitation.invitationId),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}