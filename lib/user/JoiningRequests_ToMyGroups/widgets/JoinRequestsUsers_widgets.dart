import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Theme/ThemeController.dart';
import '../../../color_.dart';
import '../screens/RequestsCard_screen.dart';

class JoinRequestsUsers_widgets {
  static Widget header(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final String currentTheme = themeController.currentTheme.value;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "joining_requests_to_my_groups".tr,
        style: TextStyle(
          color: AppColors.textPrimary(context, currentTheme),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget list(
      List<dynamic> groups, BuildContext context, String currentTheme) {
    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
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
                  trailing: Icon(Icons.group_add_rounded, color: AppColors.textPrimary(context, currentTheme)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
