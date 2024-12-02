import 'package:file_manager_internet_applications_project/color_.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../../Theme/ThemeController.dart';
import '../controllers/InvitationController.dart';

class JoiningRequests_widgets {
  static Widget titleText(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<ThemeController>(builder: (themeController) {
        final currentTheme = themeController.currentTheme.value;
        return Text(
          text.tr,
          style: TextStyle(
            color: AppColors.textPrimary(context, currentTheme),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        );
      }),
    );
  }

  static Widget invitationCard(
      BuildContext context,
      dynamic invitation,
      InvitationController controller,
      ) {
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
            "Owner".tr+"${invitation.ownerName} \n "+"Sent At".tr+"${DateFormat('yyyy-MM-dd HH:mm').format(invitation.sendAt)}",
            style: TextStyle(color: AppColors.font(context, currentTheme)),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _acceptButton(context, () => controller.acceptInvitation(invitation.invitationId, invitation.folderId), currentTheme),
              const SizedBox(width: 8),
              _rejectButton(context, () => controller.rejectInvitation(invitation.invitationId), currentTheme),
            ],
          ),
        ),
      );
    });
  }

  static Widget _acceptButton(BuildContext context, VoidCallback onPressed, String currentTheme) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background(context, currentTheme),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(Icons.check, color: Colors.green),
        onPressed: onPressed,
      ),
    );
  }

  static Widget _rejectButton(BuildContext context, VoidCallback onPressed, String currentTheme) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background(context, currentTheme),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(Icons.close, color: Colors.red),
        onPressed: onPressed,
      ),
    );
  }
}
