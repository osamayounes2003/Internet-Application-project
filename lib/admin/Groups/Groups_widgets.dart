import 'package:file_manager_internet_applications_project/admin/Group/Group_screen.dart';
import 'package:file_manager_internet_applications_project/admin/Groups/Groups_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupsWidgets extends StatelessWidget {
  const GroupsWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GroupsController groupsController = Get.put(GroupsController());

    return Obx(() {
      if (groupsController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (groupsController.groups.isEmpty) {
        return const Center(child: Text('No groups available'));
      }

      return ListView.builder(
        itemCount: groupsController.groups.length,
        itemBuilder: (context, index) {
          final group = groupsController.groups[index];

          return GestureDetector(
            onTap: () {
                Get.to(() => Group_screen(), arguments: {'group': group});
              },
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.group, color: Colors.black),
                title: Text(
                  group.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Owner: ${group.owner.fullname}'),
              ),
            ),
          );
        },
      );
    });
  }
}

// // GroupsWidgets.dart
// import 'package:file_manager_internet_applications_project/admin/Groups/Groups_Controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class GroupsWidgets extends StatelessWidget {
//   const GroupsWidgets({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final GroupsController groupsController = Get.put(GroupsController());
//
//     return Obx(() {
//       if (groupsController.isLoading.value) {
//         return const Center(child: CircularProgressIndicator());
//       }
//
//       if (groupsController.groups.isEmpty) {
//         return const Center(child: Text('No groups available'));
//       }
//
//       return ListView.builder(
//         itemCount: groupsController.groups.length,
//         itemBuilder: (context, index) {
//           final group = groupsController.groups[index];
//
//           return Card(
//             margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             elevation: 4,
//             child: ListTile(
//               leading: const Icon(Icons.group, color: Colors.black),
//               title: Text(
//                 group.name,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text('Owner: ${group.owner.fullname}'),
//             ),
//           );
//         },
//       );
//     });
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../Group/Group_screen.dart';
// import 'groups_controller.dart';
//
// class GroupsWidgets extends StatelessWidget {
//   const GroupsWidgets({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final GroupsController groupsController = Get.find();
//
//     return Obx(() {
//       if (groupsController.isLoading.value) {
//         return const Center(child: CircularProgressIndicator());
//       }
//
//       if (groupsController.groups.isEmpty) {
//         return const Center(child: Text('No groups available'));
//       }
//
//       return SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 16.0),
//           child: Container(
//             height: MediaQuery.of(context).size.height * 0.95,
//             child: ListView.builder(
//               itemCount: groupsController.groups.length,
//               itemBuilder: (context, index) {
//                 final group = groupsController.groups[index];
//
//                 return Card(
//                   margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   elevation: 4,
//                   child: ListTile(
//                     leading: const Icon(Icons.group, color: Colors.black),
//                     title: Text(
//                       group.name,
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: const Text('Tap to view details'),
//                     onTap: () {
//                       Get.to(
//                             () => Group_screen(),
//                         arguments: {
//                           'group': group,
//                         },
//                       );
//                       print('Navigating to Group_screen with group: ${group.name}');
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
