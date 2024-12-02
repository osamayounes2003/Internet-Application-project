import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../CustomComponent/BaseScreen.dart';
import '../../../Theme/ThemeController.dart';
import '../../../color_.dart';
import '../controllers/Groups_Controller.dart';
import '../widgets/Groups_widgets.dart';

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
                // حقل البحث
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
                    Groups_widgets.customButton(
                      context,
                      "my groups".tr,
                          () {
                        groupsController.currentGroupListType.value = GroupListType.myGroups;
                        groupsController.showMyGroups();
                      },
                      currentTheme,
                    ),
                    const SizedBox(width: 2),
                    Groups_widgets.customButton(
                      context,
                      "joined groups".tr,
                          () {
                        groupsController.currentGroupListType.value = GroupListType.joinedGroups;
                        groupsController.showJoinedGroups();
                      },
                      currentTheme,
                    ),
                    const SizedBox(width: 2),
                    Groups_widgets.customButton(
                      context,
                      "public groups".tr,
                          () {
                        groupsController.currentGroupListType.value = GroupListType.publicGroups;
                        groupsController.showPublicGroups();
                      },
                      currentTheme,
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
                        return Groups_widgets.groupListTile(
                          context,
                          group,
                          isAdmin,
                          groupsController,
                          currentTheme,
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
