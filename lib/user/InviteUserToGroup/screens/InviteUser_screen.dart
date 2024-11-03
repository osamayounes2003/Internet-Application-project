import 'package:file_manager_internet_applications_project/CustomComponent/BaseScreen.dart';
import 'package:file_manager_internet_applications_project/color_.dart';
import 'package:file_manager_internet_applications_project/user/InviteUserToGroup/widgets/InviteUsers_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/UsersModel.dart';
import '../controllers/MyGroupsController.dart';
import '../controllers/UsersController.dart';
import '../controllers/InviteUserController.dart';

class InviteUser_screen extends StatefulWidget {
  const InviteUser_screen({Key? key}) : super(key: key);

  @override
  _InviteUser_screenState createState() => _InviteUser_screenState();
}

class _InviteUser_screenState extends State<InviteUser_screen> {
  final TextEditingController _usernameController = TextEditingController();
  RxList<Users> filteredUsers = <Users>[].obs;
  RxInt selectedUserId = 0.obs;
  RxInt selectedGroupId = 0.obs;

  final MyGroupsController groupsController = Get.put(MyGroupsController());
  final UsersController usersController = Get.put(UsersController());
  final InviteUserController inviteUserController = Get.put(InviteUserController());

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_filterUsers);
    groupsController.fetchMyGroups();
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
    return BaseScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InviteUserWidgets.titleSection("Invite User to Group", color_.gray),
          InviteUserWidgets.sectionHeader("Users", color_.gray),
          InviteUserWidgets.userList(
            usersController: usersController,
            selectedUserId: selectedUserId,
            onSelectUser: (id) => setState(() {
              selectedUserId.value = id;
            }),
          ),
          InviteUserWidgets.sectionHeader("My Groups", color_.gray),
          InviteUserWidgets.groupList(
            groupsController: groupsController,
            selectedGroupId: selectedGroupId,
            onSelectGroup: (id) => setState(() {
              selectedGroupId.value = id;
            }),
          ),
          InviteUserWidgets.inviteButton(
            onPressed: () async {
              if (selectedUserId.value != 0 && selectedGroupId.value != 0) {
                await inviteUserController.inviteUser(selectedUserId.value, selectedGroupId.value);
              } else {
                Get.snackbar("Warning", "Please select a user and a group.");
              }
            },
            isEnabled: selectedUserId.value != 0 && selectedGroupId.value != 0,
          ),
        ],
      ),
    );
  }
}
