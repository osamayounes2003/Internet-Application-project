import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../CustomComponent/BaseScreen.dart';
import '../../../color_.dart';
import '../controllers/Groups_Controller.dart';
import '../widgets/Groups_widgets.dart';

class Groups_screen extends StatelessWidget {
  const Groups_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GroupsController groupsController = Get.put(GroupsController());

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Groups_widgets.customButton("My Groups", () {
                      groupsController.showMyGroups();
                    }),
                    const SizedBox(width: 2),
                    Groups_widgets.customButton("Joined Groups", () {
                      groupsController.showJoinedGroups();
                    }),
                    const SizedBox(width: 2),
                    Groups_widgets.customButton("Public Groups", () {
                      groupsController.showPublicGroups();
                    }),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Obx(() {
                    if (groupsController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final currentGroupList = groupsController.currentGroupList;

                    if (currentGroupList.isEmpty) {
                      return const Center(
                        child: Text(
                          'No groups available',
                          style: TextStyle(color: color_.gray),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: currentGroupList.length,
                      itemBuilder: (context, index) {
                        final group = currentGroupList[index];
                        bool isAdmin = currentGroupList.value ==
                            groupsController.ownGroups.value;

                        return Groups_widgets.groupListTile(
                          context,
                          group,
                          isAdmin,
                          groupsController,
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
