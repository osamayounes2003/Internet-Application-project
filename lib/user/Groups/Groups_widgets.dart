import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CustomComponent/CustomButton.dart';
import '../../color_.dart';
import '../Group/Group_screen.dart';
import 'Groups_Controller.dart';

class Groups_widgets {
  static Widget customButton(String title, VoidCallback onPressed) {
    return Expanded(
      child: CustomElevatedButton(
        title: title,
        onPressed: onPressed,
        color: color_.button,
      ),
    );
  }

  static Widget groupListTile(
      BuildContext context, var group, bool isAdmin, GroupsController groupsController) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: ListTile(
        onTap: () {
          Get.to(() => Group_screen(), arguments: {'group': group, 'isAdmin': isAdmin});
        },
        leading: const Icon(Icons.group, color: Colors.black),
        title: Text(
          group.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Owner: ${group.owner?.fullname ?? "Unknown"}',
        ),
        trailing: groupsController.currentGroupList.value ==
            groupsController.notJoinedOtherGroups.value
            ? CustomElevatedButton(
          color: color_.black,
          onPressed: () {
            groupsController.sendJoinRequest(group);
          },
          title: "Join Request",
        )
            : null,
      ),
    );
  }
}
