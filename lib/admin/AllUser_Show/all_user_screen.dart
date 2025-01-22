import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../CustomComponent/BaseScreen.dart';
import '../../../Theme/ThemeController.dart';
import '../../../color_.dart';
import '../AllGroup-Show/AllGroupShow_controller.dart';
import '../AllUser_Show/allUser_Controller.dart';
import '../../user/Groups/models/Groups_Model.dart';
import '../../user/Reports/UserReports_Controller.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllUsersController usersController = Get.put(AllUsersController());
    final GroupsAdminController groupsAdminController = Get.put(GroupsAdminController());
    final DownloadUserReportController downloadReportController = Get.put(DownloadUserReportController());
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
                    usersController.searchQuery.value = query;
                  },
                  decoration: InputDecoration(
                    labelText: 'Search users'.tr,
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
                    if (usersController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final allUsers = usersController.filteredUsers;

                    if (allUsers.isEmpty) {
                      return Center(
                        child: Text(
                          'No users available'.tr,
                          style: TextStyle(color: AppColors.gray(context, currentTheme)),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: allUsers.length,
                      itemBuilder: (context, index) {
                        final user = allUsers[index];
                        return UserCard(
                          user: user,
                          currentTheme: currentTheme,
                          usersController: usersController,
                          groupsAdminController: groupsAdminController,
                          downloadReportController: downloadReportController,
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

class UserCard extends StatelessWidget {
  final User user;
  final String currentTheme;
  final AllUsersController usersController;
  final GroupsAdminController groupsAdminController;
  final DownloadUserReportController downloadReportController;

  const UserCard({
    Key? key,
    required this.user,
    required this.currentTheme,
    required this.usersController,
    required this.groupsAdminController,
    required this.downloadReportController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: AppColors.background(context, currentTheme),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              user.fullname,
              style: TextStyle(color: AppColors.font(context, currentTheme)),
            ),
            subtitle: Text(
              "Email: ${user.email}\nRole: ${user.role}",
              style: TextStyle(color: AppColors.gray(context, currentTheme)),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Tooltip(
                  message: 'Delete User',
                  child: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _confirmDeleteUser(context, usersController, user.id);
                    },
                  ),
                ),
              ],
            ),
          ),
          ExpansionTile(
            title: Tooltip(
              message: "Details about groups the user is involved in",
              child: Text(
                "Groups Information",
                style: TextStyle(color: AppColors.font(context, currentTheme)),
              ),
            ),
            children: [
              FutureBuilder(
                future: _fetchUserGroups(groupsAdminController, user.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Error: ${snapshot.error}",
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    final Map<String, List<Groups>> groupData = snapshot.data as Map<String, List<Groups>>;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (groupData['adminGroups']!.isNotEmpty) ...[
                            Tooltip(
                              message: "Groups where the user is an admin",
                              child: Text(
                                "Admin of Groups:",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.font(context, currentTheme)),
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...groupData['adminGroups']!.map((group) {
                              return Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                color: AppColors.background(context, currentTheme),
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(vertical: 4.0),
                                child: ListTile(
                                  leading: Icon(Icons.admin_panel_settings, color: Colors.blue),
                                  title: Text(
                                    group.name,
                                    style: TextStyle(color: AppColors.font(context, currentTheme)),
                                  ),
                                  trailing: Tooltip(
                                    message: 'Download Report',
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.download,
                                        color: AppColors.primary(context, currentTheme),
                                      ),
                                      onPressed: () {
                                        downloadReportController.downloadReport(group.id, user.id);
                                      },
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                          const SizedBox(height: 16),
                          if (groupData['memberGroups']!.isNotEmpty) ...[
                            Tooltip(
                              message: "Groups where the user is a member",
                              child: Text(
                                "Member in Groups:",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.font(context, currentTheme)),
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...groupData['memberGroups']!.map((group) {
                              return Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                color: AppColors.background(context, currentTheme),
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(vertical: 4.0),
                                child: ListTile(
                                  leading: Icon(Icons.group, color: Colors.green),
                                  title: Text(
                                    group.name,
                                    style: TextStyle(color: AppColors.font(context, currentTheme)),
                                  ),
                                  trailing: Tooltip(
                                    message: 'Download Report',
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.download,
                                        color: AppColors.primary(context, currentTheme),
                                      ),
                                      onPressed: () {
                                        downloadReportController.downloadReport(group.id, user.id);
                                      },
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                          if (groupData['adminGroups']!.isEmpty && groupData['memberGroups']!.isEmpty)
                            Center(
                              child: Text(
                                "No groups found.",
                                style: TextStyle(color: AppColors.gray(context, currentTheme)),
                              ),
                            ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  void _confirmDeleteUser(BuildContext context, AllUsersController controller, int userId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this user?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                controller.deleteUser(userId);
                Get.back();
                // controller.deleteUser(userId);
                // Navigator.pop(context);
              },
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<Map<String, List<Groups>>> _fetchUserGroups(GroupsAdminController groupsController, int userId) async {
    final adminGroups = await groupsController.fetchGroupsByAdmin(userId);
    final memberGroups = await groupsController.fetchGroupsByMember(userId);
    return {'adminGroups': adminGroups, 'memberGroups': memberGroups};
  }
}
