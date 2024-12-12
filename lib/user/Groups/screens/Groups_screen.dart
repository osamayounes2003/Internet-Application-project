import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../CustomComponent/BaseScreen.dart';
import '../../../CustomComponent/ToolTip.dart';
import '../../../Theme/ThemeController.dart';
import '../../../color_.dart';
import '../controllers/Groups_Controller.dart';
import '../../../CustomComponent/CustomButton.dart';

class Groups_screen extends StatelessWidget {
  const Groups_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GroupsController groupsController = Get.put(GroupsController());
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
                // Search field
                TextField(
                  onChanged: (query) {
                    groupsController.searchQuery.value = query;
                    groupsController.searchGroups();
                  },
                  decoration: InputDecoration(
                    labelText: 'search groups'.tr,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // My Groups Button
                    Expanded(
                      child: CustomTooltip(
                        message: "View your groups",
                        child: CustomElevatedButton(
                          title: "my groups".tr,
                          onPressed: () {
                            groupsController.currentGroupListType.value = GroupListType.myGroups;
                            groupsController.showMyGroups();
                          },
                          color: AppColors.primary(context, currentTheme),
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    // Joined Groups Button
                    Expanded(
                      child: CustomTooltip(
                        message: "View groups you have joined",
                        child: CustomElevatedButton(
                          title: "joined groups".tr,
                          onPressed: () {
                            groupsController.currentGroupListType.value = GroupListType.joinedGroups;
                            groupsController.showJoinedGroups();
                          },
                          color: AppColors.primary(context, currentTheme),
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    // Public Groups Button
                    Expanded(
                      child: CustomTooltip(
                        message: "View available public groups",
                        child: CustomElevatedButton(
                          title: "public groups".tr,
                          onPressed: () {
                            groupsController.currentGroupListType.value = GroupListType.publicGroups;
                            groupsController.showPublicGroups();
                          },
                          color: AppColors.primary(context, currentTheme),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Obx(() {
                    if (groupsController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final currentGroupList = groupsController.currentGroupList;

                    if (currentGroupList.isEmpty) {
                      return Center(
                        child: Text(
                          'no groups available'.tr,
                          style: TextStyle(color: AppColors.gray(context, currentTheme)),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: currentGroupList.length,
                      itemBuilder: (context, index) {
                        final group = currentGroupList[index];
                        bool isAdmin = (currentGroupList.value == groupsController.ownGroups.value || groupsController.currentGroupListType.value == GroupListType.myGroups);
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          elevation: 4,
                          color: AppColors.background(context, currentTheme),
                          child: ListTile(
                            onTap: () {
                              if (groupsController.currentGroupListType.value != GroupListType.publicGroups ||
                                  groupsController.currentGroupList.value == groupsController.notJoinedOtherGroups.value) {
                                Get.toNamed("/Group", arguments: {'group': group, 'isAdmin': isAdmin});
                              }
                            },
                            leading: Icon(Icons.group, color: AppColors.font(context, currentTheme)),
                            title: Text(
                              group.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.font(context, currentTheme),
                              ),
                            ),
                            subtitle: Text(
                              'owner'.tr + ': ${group.owner?.fullname ?? "unknown".tr}',
                              style: TextStyle(color: AppColors.gray(context, currentTheme)),
                            ),
                            trailing: groupsController.currentGroupListType.value == GroupListType.publicGroups ||
                                groupsController.currentGroupList.value == groupsController.notJoinedOtherGroups.value
                                ? CustomTooltip(
                              message: "Send a join request",
                              child: CustomElevatedButton(
                                color: AppColors.button(context, currentTheme),
                                onPressed: () {
                                  groupsController.sendJoinRequest(group);
                                },
                                title: "join request".tr,
                              ),
                            )
                                : null,
                          ),
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