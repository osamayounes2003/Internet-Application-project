import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../CustomComponent/ToolTip.dart';
import '../../../Theme/ThemeController.dart';
import '../models/UsersModel.dart';
import '../controllers/MyGroupsController.dart';
import '../controllers/UsersController.dart';
import '../controllers/InviteUserController.dart';
import '../../../../CustomComponent/BaseScreen.dart';
import '../../../../color_.dart';

class InviteUser_screen extends StatefulWidget {
  const InviteUser_screen({Key? key}) : super(key: key);

  @override
  _InviteUser_screenState createState() => _InviteUser_screenState();
}

class _InviteUser_screenState extends State<InviteUser_screen> {
  final TextEditingController _usernameController = TextEditingController();
  RxList<Users> filteredUsers = <Users>[].obs;
  RxInt selectedUserId = 0.obs;
  late int? groupId;

  final UsersController usersController = Get.put(UsersController());
  final InviteUserController inviteUserController = Get.put(InviteUserController());

  @override
  void initState() {
    super.initState();
    groupId = Get.arguments?['groupId'];

    _usernameController.addListener(_filterUsers);
    usersController.fetchUsers();
  }

  void _filterUsers() {
    final query = _usernameController.text.toLowerCase();
    filteredUsers.value = usersController.users.where((user) {
      return user.fullname.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final String currentTheme = themeController.currentTheme.value;

    if (groupId == null) {
      return BaseScreen(
        child: Center(
          child: Text(
            "no_group_selected".tr,
            style: TextStyle(
              color: AppColors.textSecondary(context, currentTheme),
              fontSize: 18,
            ),
          ),
        ),
      );
    }

    return BaseScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "invite_user_to_group".tr,
              style: TextStyle(
                color: AppColors.textPrimary(context, currentTheme),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Section Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "users".tr,
              style: TextStyle(
                color: AppColors.textPrimary(context, currentTheme),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // User List Section
          Expanded(
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
                      trailing: CustomTooltip(
                        message: isSelected ? "Selected" : "Select this user",
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedUserId.value = isSelected ? 0 : user.id;
                            });
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
                    ),
                  );
                },
              );
            }),
          ),
          // Invite Button Section
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: CustomTooltip(
                message: "Invite selected user to the group",
                child: ElevatedButton(
                  onPressed: selectedUserId.value != 0 ? () async {
                    await inviteUserController.inviteUser(selectedUserId.value, groupId!);
                  } : null,
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
            ),
          ),
        ],
      ),
    );
  }
}