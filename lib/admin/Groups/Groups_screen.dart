import 'package:file_manager_internet_applications_project/admin/Groups/Groups_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Groups_widgets.dart';

class Groups_screen extends StatelessWidget {
  const Groups_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(GroupsController());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          title: const Text(
            'Groups',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
      ),
      body: const GroupsWidgets(),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../Group/Group_screen.dart';
// import 'groups_controller.dart';
// import 'groups_model.dart'; // Ensure this imports your Groups model
//
// class Groups_screen extends StatelessWidget {
//   const Groups_screen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final GroupsController groupsController = Get.put(GroupsController());
//
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(70.0),
//         child: AppBar(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(10),
//             ),
//           ),
//           title: Text(
//             'Groups',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.black,
//           iconTheme: IconThemeData(color: Colors.white),
//         ),
//       ),
//       body: Obx(() {
//         if (groupsController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         if (groupsController.groups.isEmpty) {
//           return Center(child: Text('No groups available'));
//         }
//
//         return SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 16.0),
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.95,
//               child: ListView.builder(
//                 itemCount: groupsController.groups.length,
//                 itemBuilder: (context, index) {
//                   final group = groupsController.groups[index];
//
//                   return Card(
//                     margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                     elevation: 4,
//                     child: ListTile(
//                       leading: Icon(Icons.group, color: Colors.black),
//                       title: Text(
//                         group.name,
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Text('Tap to view details'),
//                       onTap: () {
//                         print(".................................${group.name}");
//                         Get.to(
//                               () => Group_screen(),
//                           arguments: {
//                             'group': group, // Pass the whole group object
//                           },
//                         );
//                         print('Navigating to Group_screen with group: ${group.name}');
//                       },
//
//
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
//
