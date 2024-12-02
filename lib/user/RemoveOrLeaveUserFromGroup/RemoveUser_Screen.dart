import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../CustomComponent/BaseScreen.dart';
import '../../../color_.dart';
import '../Groups/models/Groups_Model.dart';
import 'RemoveUser_Controller.dart';

class RemoveUser_screen extends StatefulWidget {
  const RemoveUser_screen({Key? key}) : super(key: key);

  @override
  _RemoveUser_screenState createState() => _RemoveUser_screenState();
}

class _RemoveUser_screenState extends State<RemoveUser_screen> {
  late int? groupId;
  late List<UserInFolder> members;
  RxInt selectedUserId = 0.obs;
  final RemoveUserController removeUserController = Get.put(RemoveUserController());

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments;
    groupId = arguments?['groupId'];
    members = arguments?['members'] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    if (groupId == null || members.isEmpty) {
      return BaseScreen(
        child: Center(
          child: Text(
            "No group or members found.",
            style: TextStyle(color: color_.gray, fontSize: 18),
          ),
        ),
      );
    }

    return BaseScreen(
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Remove User from Group",
                style: TextStyle(
                  color: color_.gray,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final user = members[index].user;
                  final isSelected = selectedUserId.value == user.id;

                  return Card(
                    color: color_.gray,
                    child: ListTile(
                      title: Text(
                        user.fullname,
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        user.email,
                        style: TextStyle(color: Colors.white70),
                      ),
                      trailing: GestureDetector(
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
                            color: isSelected ? Colors.white : Colors.transparent,
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: isSelected
                              ? Icon(Icons.check, color: color_.gray, size: 16)
                              : null,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: selectedUserId.value != 0 &&
                      !removeUserController.isLoading.value
                      ? () async {
                    if (groupId != null) {
                      await removeUserController.removeUser(
                        groupId!,
                        userId: selectedUserId.value,
                      );
                    }
                  }
                      : null,
                  child: removeUserController.isLoading.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                    "Remove User",
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
            ),
          ],
        );
      }),
    );
  }
}
