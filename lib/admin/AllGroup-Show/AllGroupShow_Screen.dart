import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../CustomComponent/BaseScreen.dart';
import '../../../Theme/ThemeController.dart';
import '../../../color_.dart';
import '../../user/DeleteGroup/DeleteGroup_controller.dart';
import '../../user/Groups/controllers/Groups_Controller.dart';
import '../../user/Groups/models/Groups_Model.dart';
import 'AllGroupShow_controller.dart';

class AdminGroupsScreen extends StatelessWidget {
  const AdminGroupsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GroupsAdminController groupsController = Get.put(GroupsAdminController());
    final ThemeController themeController = Get.find<ThemeController>();
    final String currentTheme = themeController.currentTheme.value;

    return BaseScreen(
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isLargeScreen = constraints.maxWidth > 600;

          return Container(
            width: isLargeScreen ? 600 : double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (query) {
                    groupsController.searchQuery.value = query;
                    groupsController.searchGroups();
                  },
                  decoration: InputDecoration(
                    labelText: 'Search groups'.tr,
                    prefixIcon: Icon(Icons.search, color: AppColors.gray(context, currentTheme)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: AppColors.gray(context, currentTheme)),
                    ),
                    labelStyle: TextStyle(color: AppColors.gray(context, currentTheme)),
                  ),
                  style: TextStyle(color: AppColors.font(context, currentTheme)),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Obx(() {
                    if (groupsController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final allGroups = groupsController.currentGroupList;

                    if (allGroups.isEmpty) {
                      return Center(
                        child: Text(
                          'No groups available'.tr,
                          style: TextStyle(color: AppColors.gray(context, currentTheme)),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: allGroups.length,
                      itemBuilder: (context, index) {
                        final group = allGroups[index];
                        return GroupCard(
                          group: group,
                          currentTheme: currentTheme,
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class GroupCard extends StatelessWidget {
  final Groups group;
  final String currentTheme;

  const GroupCard({
    Key? key,
    required this.group,
    required this.currentTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DeleteGroupController deleteGroupController = Get.put(DeleteGroupController());

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: AppColors.background(context, currentTheme),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          group.name,
          style: TextStyle(color: AppColors.font(context, currentTheme)),
        ),
        subtitle: Text(
          "Admin: ${group.owner?.fullname ?? 'N/A'}\n"
              "Private: ${group.settings.contains('PRIVATE_FOLDER') ? 'Yes' : 'No'}\n"
              "Disable File Upload : ${group.settings.contains('DISABLE_ADD_FILE') ? 'Yes' : 'No'}",
          style: TextStyle(color: AppColors.gray(context, currentTheme)),
        ),
        onTap: () {
          Get.toNamed('/groupdetailes_admin', arguments: {
            'group': group,
          });
        },
        trailing: Tooltip(
          message: 'Delete group',
          child: IconButton(
            icon: Icon(Icons.delete, color: AppColors.font(context, currentTheme)),
            onPressed: () {
              _showDeleteConfirmationDialog(context, group.id, deleteGroupController);
            },
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int groupId, DeleteGroupController deleteGroupController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Group", style: TextStyle(color: AppColors.font(context, currentTheme))),
          content: Text("Are you sure you want to delete this group?", style: TextStyle(color: AppColors.font(context, currentTheme))),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Cancel", style: TextStyle(color: AppColors.gray(context, currentTheme))),
            ),
            TextButton(
              onPressed: () {
                deleteGroupController.deleteGroup(groupId);
                Get.back(); // Close the dialog
              },
              child: Text("Delete", style: TextStyle(color: AppColors.font(context, currentTheme))),
            ),
          ],
        );
      },
    );
  }
}
