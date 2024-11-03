import 'package:file_manager_internet_applications_project/color_.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/MyGroupsController.dart';
import '../controllers/UsersController.dart';

class InviteUserWidgets {
  static Widget titleSection(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget sectionHeader(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget userList({
    required UsersController usersController,
    required RxInt selectedUserId,
    required ValueChanged<int> onSelectUser,
  }) {
    return Flexible(
      flex: 1,
      child: Obx(() {
        if (usersController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (usersController.users.isEmpty) {
          return Center(
            child: Text(
              "No Users Available",
              style: TextStyle(color: color_.gray),
            ),
          );
        }
        return ListView.builder(
          itemCount: usersController.users.length,
          itemBuilder: (context, index) {
            final user = usersController.users[index];
            final isSelected = selectedUserId.value == user.id;

            return Card(
              color: color_.gray,
              child: ListTile(
                title: Text(user.fullname, style: TextStyle(color: Colors.white)),
                trailing: GestureDetector(
                  onTap: () {
                    onSelectUser(isSelected ? 0 : user.id);
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? Colors.white : Colors.transparent,
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: isSelected ? Icon(Icons.check, color: color_.gray, size: 16) : null,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  static Widget groupList({
    required MyGroupsController groupsController,
    required RxInt selectedGroupId,
    required ValueChanged<int> onSelectGroup,
  }) {
    return Flexible(
      flex: 1,
      child: Obx(() {
        if (groupsController.groups.isEmpty) {
          return Center(
            child: Text(
              "No Groups Available",
              style: TextStyle(color: color_.gray),
            ),
          );
        }
        return ListView.builder(
          itemCount: groupsController.groups.length,
          itemBuilder: (context, index) {
            final group = groupsController.groups[index];
            final isSelectedGroup = selectedGroupId.value == group.id;

            return Card(
              color: color_.gray,
              child: ListTile(
                title: Text(group.name, style: TextStyle(color: Colors.white)),
                trailing: GestureDetector(
                  onTap: () {
                    onSelectGroup(isSelectedGroup ? 0 : group.id);
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelectedGroup ? Colors.white : Colors.transparent,
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: isSelectedGroup ? Icon(Icons.check, color: color_.gray, size: 16) : null,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  static Widget inviteButton({
    required VoidCallback onPressed,
    required bool isEnabled,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          child: Text(
            "Invite",
            style: TextStyle(color: Colors.white, fontSize: 16),
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
                  return color_.background2;
                }
                return color_.button;
              },
            ),
          ),
        ),
      ),
    );
  }
}
