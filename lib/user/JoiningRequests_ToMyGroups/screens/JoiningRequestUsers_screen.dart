import 'package:file_manager_internet_applications_project/CustomComponent/BaseScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Theme/ThemeController.dart';
import '../../../color_.dart';
import '../../Groups/controllers/Groups_Controller.dart';
import '../screens/RequestsCard_screen.dart';

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "joining_requests_to_my_groups".tr,
              style: TextStyle(
                color: AppColors.textPrimary(context, currentTheme),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
              return ListView.builder(
                itemCount: _groupsController.ownGroups.length,
                itemBuilder: (context, index) {
                  final group = _groupsController.ownGroups[index];
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              contentPadding: EdgeInsets.zero,
                              content: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: MediaQuery.of(context).size.height * 0.5,
                                  child: Requestscard(
                                    groupId: group.id,
                                    groupName: group.name,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Card(
                          color: AppColors.card(context, currentTheme),
                          child: ListTile(
                            title: Text(
                              group.name,
                              style: TextStyle(color: AppColors.textPrimary(context, currentTheme)),
                            ),
                            trailing: Tooltip(
                              message: "Add to Group",
                              child: Icon(Icons.group_add_rounded, color: AppColors.textPrimary(context, currentTheme)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}