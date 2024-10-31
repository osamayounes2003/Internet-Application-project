import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CustomComponent/BaseScreen.dart';
import '../../color_.dart';
import 'Groups_Controller.dart';
import 'Groups_widgets.dart';

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



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../CustomComponent/BaseScreen.dart';
// import '../../CustomComponent/CustomButton.dart';
// import '../../color_.dart';
// import '../Group/Group_screen.dart';
// import 'Groups_Controller.dart';
//
// class Groups_screen extends StatelessWidget {
//   const Groups_screen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final GroupsController groupsController = Get.put(GroupsController());
//
//     return BaseScreen(
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           bool isLargeScreen = constraints.maxWidth > 600;
//
//           return Container(
//             width: isLargeScreen ? 600 : double.infinity,
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: CustomElevatedButton(
//                         title: "My Groups",
//                         onPressed: () {
//                           groupsController.showMyGroups();
//                         },
//                         color: color_.button,
//                       ),
//                     ),
//                     SizedBox(width: 2),
//                     Expanded(
//                       child: CustomElevatedButton(
//                         title: "Joined Groups",
//                         onPressed: () {
//                           groupsController.showJoinedGroups();
//                         },
//                         color: color_.button,
//                       ),
//                     ),
//                     SizedBox(width: 2),
//                     Expanded(
//                       child: CustomElevatedButton(
//                         title: "Public Groups",
//                         onPressed: () {
//                           groupsController.showPublicGroups();
//                         },
//                         color: color_.button,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 Expanded(
//                   child: Obx(() {
//                     if (groupsController.isLoading.value) {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//
//                     final currentGroupList = groupsController.currentGroupList;
//
//                     if (currentGroupList.isEmpty) {
//                       return const Center(
//                           child: Text(
//                         'No groups available',
//                         style: TextStyle(color: color_.gray),
//                       ));
//                     }
//
//                     return ListView.builder(
//                       itemCount: currentGroupList.length,
//                       itemBuilder: (context, index) {
//                         final group = currentGroupList[index];
//
//                         return Card(
//                           margin: const EdgeInsets.symmetric(
//                               vertical: 8, horizontal: 16),
//                           elevation: 4,
//                           child: ListTile(
//                             onTap: () {
//                               if (currentGroupList.value != groupsController.notJoinedOtherGroups.value) {
//                                 if(currentGroupList.value == groupsController.joinedOtherGroups.value){
//                                   Get.to(() => Group_screen(),
//                                       arguments: {'group': group,'isAdmin': false});
//                                 }
//                                 if(currentGroupList.value == groupsController.ownGroups.value){
//                                   Get.to(() => Group_screen(),
//                                       arguments: {'group': group,'isAdmin': true});
//                                 }
//                               }
//                             },
//                             leading:
//                                 const Icon(Icons.group, color: Colors.black),
//                             title: Text(
//                               group.name,
//                               style:
//                                   const TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             subtitle: Text(
//                               'Owner: ${group.owner?.fullname ?? "Unknown"}',
//                             ),
//                             trailing: currentGroupList.value ==
//                                     groupsController.notJoinedOtherGroups.value
//                                 ? CustomElevatedButton(
//                               color: color_.black,
//                                     onPressed: () {
//                                       groupsController.sendJoinRequest(group);
//                                     },
//                                     title:"Join Request",
//                                   )
//                                 : null,
//                           ),
//                         );
//                       },
//                     );
//                   }),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
