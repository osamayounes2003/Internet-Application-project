import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Theme/ThemeController.dart';
import '../models/UsersModel.dart';
import '../controllers/MyGroupsController.dart';
import '../controllers/UsersController.dart';
import '../controllers/InviteUserController.dart';
import '../../../../CustomComponent/BaseScreen.dart';
import '../../../../color_.dart';
import '../widgets/InviteUsers_widgets.dart';

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
          InviteUserWidgets.titleSection("invite_user_to_group".tr, context),
          InviteUserWidgets.sectionHeader("users".tr, context),
          InviteUserWidgets.userList(
            usersController: usersController,
            selectedUserId: selectedUserId,
            onSelectUser: (id) => setState(() {
              selectedUserId.value = id;
            }),
            context: context,
          ),
          InviteUserWidgets.inviteButton(
            onPressed: () async {
              if (selectedUserId.value != 0) {
                await inviteUserController.inviteUser(selectedUserId.value, groupId!);
              } else {
                Get.snackbar("Warning", "please_select_a_user".tr);
              }
            },
            isEnabled: selectedUserId.value != 0,
            context: context,
          ),
        ],
      ),
    );
  }
}
