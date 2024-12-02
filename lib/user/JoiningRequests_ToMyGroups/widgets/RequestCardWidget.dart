import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../Theme/ThemeController.dart';
import '../../../color_.dart';
import '../controllers/JoinRequestToMyGroups_Controller.dart';
import '../models/JoinRequestsToMyGroups_Model.dart';

class RequestCardWidget extends StatelessWidget {
  final JoinRequestToMyGroups request;
  final int groupId;
  final JoinRequestToMyGroupsController joinRequestController;

  RequestCardWidget({
    required this.request,
    required this.groupId,
    required this.joinRequestController,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final String currentTheme = themeController.currentTheme.value;

    return Card(
      color: currentTheme == 'dark' ? AppColors.background2(context, currentTheme) : AppColors.background(context, currentTheme),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(request.nameUser, style: TextStyle(color: AppColors.textPrimary(context, currentTheme))),
        subtitle: Text(
          "requested_on".tr+"${DateFormat('dd-MM-yyyy HH:mm').format(request.sendAt)}",
          style: TextStyle(color: AppColors.textSecondary(context, currentTheme)),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.background2(context, currentTheme),
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: () async {
                  await joinRequestController.rejectInvitation(request.joinRequestId, groupId);
                  await joinRequestController.fetchJoinRequests(groupId);
                },
              ),
            ),
            SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: AppColors.background2(context, currentTheme),
              child: IconButton(
                icon: Icon(Icons.check, color: Colors.green),
                onPressed: () async {
                  await joinRequestController.acceptInvitation(request.joinRequestId, groupId);
                  await joinRequestController.fetchJoinRequests(groupId);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
