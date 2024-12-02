import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../CustomComponent/CustomButton.dart';
import '../../../color_.dart';
import '../controllers/Groups_Controller.dart';

class Groups_widgets {
  static Widget customButton(
      BuildContext context,
      String title,
      VoidCallback onPressed,
      String theme,
      ) {
    return Expanded(
      child: CustomElevatedButton(
        title: title.tr,
        onPressed: onPressed,
        color: AppColors.primary(context, theme),
      ),
    );
  }

  static Widget groupListTile(
      BuildContext context,
      var group,
      bool isAdmin,
      GroupsController groupsController,
      String theme,
      ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      color: AppColors.background(context, theme),
      child: ListTile(
        onTap: () {
          if (groupsController.currentGroupListType.value != GroupListType.publicGroups ||
              groupsController.currentGroupList.value == groupsController.notJoinedOtherGroups.value) {
            Get.toNamed("/Group", arguments: {'group': group, 'isAdmin': isAdmin});
          }
        },
        leading: Icon(Icons.group, color: AppColors.font(context, theme)),
        title: Text(
          group.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.font(context, theme),
          ),
        ),
        subtitle: Text(
          'owner'.tr + ': ${group.owner?.fullname ?? "unknown".tr}',
          style: TextStyle(color: AppColors.gray(context, theme)),
        ),
        trailing: groupsController.currentGroupListType.value == GroupListType.publicGroups ||
            groupsController.currentGroupList.value == groupsController.notJoinedOtherGroups.value
            ? CustomElevatedButton(
          color: AppColors.button(context, theme),
          onPressed: () {
            groupsController.sendJoinRequest(group);
          },
          title: "join request".tr,
        )
            : null,
      ),
    );
  }
}
