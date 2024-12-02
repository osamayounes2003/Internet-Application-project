import 'package:file_manager_internet_applications_project/color_.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/MyGroupsController.dart';
import '../controllers/UsersController.dart';
import '../../../../Theme/ThemeController.dart';

class InviteUserWidgets {
  // Title section
  static Widget titleSection(String title, BuildContext context) {
    final themeController = Get.find<ThemeController>();
    String currentTheme = themeController.currentTheme.value;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.textPrimary(context, currentTheme),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Section header
  static Widget sectionHeader(String title, BuildContext context) {
    final themeController = Get.find<ThemeController>();
    String currentTheme = themeController.currentTheme.value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.textPrimary(context, currentTheme),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // User list section
  static Widget userList({
    required UsersController usersController,
    required RxInt selectedUserId,
    required ValueChanged<int> onSelectUser,
    required BuildContext context,
  }) {
    final themeController = Get.find<ThemeController>();
    String currentTheme = themeController.currentTheme.value;

    return Expanded(
      flex: 1,
      child: Obx(() {
        if (usersController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (usersController.users.isEmpty) {
          return Center(
            child: Text(
              "no_users_available".tr,
              style: TextStyle(color: AppColors.textSecondary(context, currentTheme)),
            ),
          );
        }
        return ListView.builder(
          itemCount: usersController.users.length,
          itemBuilder: (context, index) {
            final user = usersController.users[index];
            final isSelected = selectedUserId.value == user.id;

            return Card(
              color: AppColors.card(context, currentTheme),
              child: ListTile(
                title: Text(user.fullname, style: TextStyle(color: AppColors.textPrimary(context, currentTheme))),
                trailing: GestureDetector(
                  onTap: () {
                    onSelectUser(isSelected ? 0 : user.id);
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? AppColors.textPrimary(context, currentTheme) : Colors.transparent,
                      border: Border.all(color: AppColors.textPrimary(context, currentTheme), width: 1),
                    ),
                    child: isSelected ? Icon(Icons.check, color: AppColors.card(context, currentTheme), size: 16) : null,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  // Invite button section
  static Widget inviteButton({
    required VoidCallback onPressed,
    required bool isEnabled,
    required BuildContext context,
  }) {
    final themeController = Get.find<ThemeController>();
    String currentTheme = themeController.currentTheme.value;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          child: Text(
            "invite".tr,
            style: TextStyle(color: AppColors.white(context, currentTheme), fontSize: 16),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 50, vertical: 12),
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return AppColors.background2(context, currentTheme);
                }
                return AppColors.button(context, currentTheme);
              },
            ),
          ),
        ),
      ),
    );
  }
}
