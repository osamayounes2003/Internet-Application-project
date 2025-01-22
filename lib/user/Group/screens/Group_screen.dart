import 'package:file_manager_internet_applications_project/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../CustomComponent/BaseScreen.dart';
import '../../../CustomComponent/CustomButton.dart';
import '../../../Theme/ThemeController.dart';
import '../../../color_.dart';
import '../../DeleteGroup/DeleteGroup_controller.dart';
import '../../Groups/models/Groups_Model.dart';
import '../../RemoveOrLeaveUserFromGroup/RemoveUser_Controller.dart';
import '../multi_select_file/multi_select_item_controller.dart';

class Group_screen extends StatefulWidget {
  const Group_screen({Key? key}) : super(key: key);

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<Group_screen> {
  Groups? group;
  bool isAdmin = false;
  String currentView = 'Members';
  List<String> members = [];
  List<File> uploadedFiles = [];
  final RemoveUserController removeUserController = Get.put(RemoveUserController());
  final DeleteGroupController deleteGroupController = Get.put(DeleteGroupController());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic>? arguments = Get.arguments;

    if (arguments != null) {
      group = arguments['group'];
      isAdmin = arguments['isAdmin'] ?? false;
    }

    if (group != null) {
      print("Group name: ${group!.name}, Admin status: $isAdmin");
      members = group!.listOfUsers.map((user) => user.user.fullname).toList();
      uploadedFiles = group!.listOfFiles;
    } else {
      print("Group not found, displaying default view.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    String currentTheme = themeController.currentTheme.value;

    if (group == null) {
      return BaseScreen(
        child: Center(
          child: Text("no_group_selected".tr,
              style: TextStyle(color: AppColors.font(context, themeController.currentTheme.value), fontSize: 18)),
        ),
      );
    }

    return BaseScreen(
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isLargeScreen = constraints.maxWidth > 600;
          return Container(
            width: isLargeScreen ? 600 : double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          group!.name,
                          style: TextStyle(
                            color: AppColors.font(context, themeController.currentTheme.value),
                            fontSize: MediaQuery.of(context).size.width > 600 ? 24 : 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          group!.owner!.fullname.toString(),
                          style: TextStyle(
                            color: AppColors.font(context, themeController.currentTheme.value),
                            fontSize: MediaQuery.of(context).size.width > 600 ? 20 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    if (isAdmin)
                      PopupMenuButton<String>(
                        icon: CustomTooltip(
                          message: "Group settings",
                          child: Icon(Icons.settings, color: AppColors.button(context, themeController.currentTheme.value)),
                        ),
                        onSelected: (String value) async {
                          switch (value) {
                            case 'add_file':
                              print("Add File");
                              Get.toNamed("/upload", arguments: {'groupId': group!.id});
                              break;
                            case 'invite_user':
                              Get.toNamed("/InviteUser", arguments: {'groupId': group!.id});
                              break;
                            case 'File_upload_request':
                              Get.toNamed("/PendingFile", arguments: {'groupId': group!.id});
                              print("Request File Addition");
                              break;
                            case 'remove user':
                              Get.toNamed('/Remove_User', arguments: {
                                'groupId': group!.id,
                                'members': group!.listOfUsers,
                              });
                              break;
                            case 'Edit Group':
                              Get.toNamed("/UpdateGroup", arguments: {
                                'groupId': group!.id,
                                'groupName': group!.name,
                                'settings': group!.settings,
                              });
                              break;
                            case 'delete Group':
                              final confirmed = await Get.defaultDialog<bool>(
                                title: 'Confirm Delete',
                                middleText: 'Are you sure you want to delete this group?',
                                onCancel: () => false,
                                onConfirm: () async {
                                  await deleteGroupController.deleteGroup(group!.id);
                                  Get.back(result: true);
                                },
                              );
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          PopupMenuItem(value: 'add_file', child: Text("add_file".tr)),
                          PopupMenuItem(value: 'invite_user', child: Text("invite_user".tr)),
                          PopupMenuItem(value: 'File_upload_request', child: Text("File_upload_request".tr)),
                          PopupMenuItem(value: 'remove user', child: Text("remove_user".tr)),
                          PopupMenuItem(value: 'Edit Group', child: Text("edit_group".tr)),
                          PopupMenuItem(value: 'delete Group', child: Text("delete_group".tr)),
                        ],
                      ),
                    if (!isAdmin)
                      PopupMenuButton<String>(
                        icon: CustomTooltip(
                          message: "Group settings",
                          child: Icon(Icons.settings, color: AppColors.button(context, themeController.currentTheme.value)),
                        ),
                        onSelected: (String value) async {
                          switch (value) {
                            case 'add_file':
                              print("Add File");
                              Get.toNamed("/upload", arguments: {'groupId': group!.id});
                              break;
                            case 'leave group':
                              print(group?.id);
                              final confirmed = await Get.defaultDialog<bool>(
                                title: 'Confirm Leave',
                                middleText: 'Are you sure you want to leave this group?',
                                onCancel: () => false,
                                onConfirm: () async {
                                  await removeUserController.removeUser(group!.id, isme: true);
                                  Get.back(result: true);
                                },
                              );
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          PopupMenuItem(value: 'add_file', child: Text("add_file".tr)),
                          PopupMenuItem(value: 'leave group', child: Text("leave_group".tr)),
                        ],
                      ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTooltip(
                        message: "View uploaded files",
                        child: CustomElevatedButton(
                          title: "files".tr,
                          onPressed: () {
                            setState(() {
                              currentView = 'Files';
                            });
                          },
                          color: AppColors.button(context, themeController.currentTheme.value),
                        ),
                      ),
                    ),
                    SizedBox(width: 2),
                    Expanded(
                      child: CustomTooltip(
                        message: "View group members",
                        child: CustomElevatedButton(
                          title: "members".tr,
                          onPressed: () {
                            setState(() {
                              currentView = 'Members';
                            });
                          },
                          color: AppColors.button(context, themeController.currentTheme.value),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: currentView == 'Members'
                      ? MembersTab(members: group!.listOfUsers, groupId: group!.id)
                      : FilesTab(uploadedFiles: uploadedFiles),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// class FilesTab extends StatelessWidget {
//   final List<File> uploadedFiles;
//
//   const FilesTab({Key? key, required this.uploadedFiles}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final themeController = Get.find<ThemeController>();
//     String currentTheme = themeController.currentTheme.value;
//
//     return uploadedFiles.isEmpty
//         ? Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.upload_file, size: 50, color: AppColors.button(context, currentTheme)),
//           Text("No files uploaded.", style: TextStyle(color: AppColors.font(context, currentTheme))),
//         ],
//       ),
//     )
//         : Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomElevatedButton(
//           title: "Check in more than one file",
//           onPressed: () {
//             //TODO multi select
//         Get.to(SelectMultiFileScreen(files: uploadedFiles));
//           },
//           color: AppColors.button(context, currentTheme),
//         ),
//         Expanded(
//           child: ListView.builder(
//             itemCount: uploadedFiles.length,
//             itemBuilder: (context, index) {
//               return Card(
//                 margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                 elevation: 4,
//                 color: AppColors.background(context, currentTheme),
//                 child: ListTile(
//                   leading: Icon(Icons.insert_drive_file, color: AppColors.button(context, currentTheme)),
//                   title: Text(
//                     uploadedFiles[index].name,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.font(context, currentTheme),
//                     ),
//                   ),
//                   onTap: () {
//                     Get.toNamed(
//                       '/File_Details',
//                       arguments: {
//                         'file': uploadedFiles[index],
//                       },
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
class FilesTab extends StatelessWidget {
  final List<File> uploadedFiles;
  final MultiSelectFileController controller =
  Get.put(MultiSelectFileController());

  FilesTab({Key? key, required this.uploadedFiles}) : super(key: key) {
    controller.files.assignAll(uploadedFiles);
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    String currentTheme = themeController.currentTheme.value;
    uploadedFiles.sort((a, b) {
      return a.status.compareTo(b.status);
    });
    return GetBuilder<MultiSelectFileController>(
        builder: (controller) =>
        uploadedFiles.isNotEmpty ?
        Column(
          children: [
            Row(
              children: [
                ListTile(
                  title: Text("Select All"),
                  leading: Checkbox(
                    value: controller.selectMultiFile.value,
                    onChanged: (bool? value) {
                      controller.selectAllFiles();
                    },
                  ),
                ).expanded(flex: 1),
                CustomElevatedButton(
                    title: "CheckIn",
                    onPressed: () {
                      controller.checkInMultiFile(controller.selectedIds);
                    })
              ],
            ),
            ListView.separated(
              itemCount: uploadedFiles.length,
              itemBuilder: (context, index) {
                final file = uploadedFiles[index];
                return Card(
                  child: ListTile(
    onTap: () {
                    Get.toNamed(
                      '/File_Details',
                      arguments: {
                        'file': uploadedFiles[index],
                      },
                    );
                  },
                    title:   Text(file.name),
                    subtitle: Text('Status: ${file.status}'),
                    leading: file.status == "AVAILABLE"
                        ? Checkbox(
                      value: file.isSelected,
                      onChanged: (bool? value) {
                        controller.toggleSelection(file.id);
                      },
                    )
                        : Icon(Icons.cancel_presentation , color: Colors.red,),
                  ),
                );
              }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 5,); },
            ).expanded(flex: 1),
          ],
        ): Container()
    );
  }
}
class MembersTab extends StatelessWidget {
  final List<UserInFolder> members;
  final int groupId;

  const MembersTab({Key? key, required this.members, required this.groupId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    String currentTheme = themeController.currentTheme.value;

    return members.isEmpty
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_add, size: 50, color: AppColors.button(context, currentTheme)),
          SizedBox(height: 10),
          Text(
            "No members available",
            style: TextStyle(fontSize: 16, color: AppColors.font(context, currentTheme)),
          ),
        ],
      ),
    )
        : ListView.builder(
      itemCount: members.length,
      itemBuilder: (context, index) {
        final user = members[index].user;

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 4,
          color: AppColors.background(context, currentTheme),
          child: ListTile(
            onTap: () {
              Get.toNamed(
                '/Member_Details',
                arguments: {
                  'user': user,
                  'member': members[index],
                  'groupId': groupId,
                },
              );
            },
            leading: Icon(Icons.person, color: AppColors.button(context, currentTheme)),
            title: Text(
              user.fullname,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.font(context, currentTheme),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomTooltip extends StatelessWidget {
  final String message;
  final Widget child;

  const CustomTooltip({
    Key? key,
    required this.message,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      padding: EdgeInsets.all(8),
      verticalOffset: 20,
      preferBelow: true,
      child: child,
    );
  }
}