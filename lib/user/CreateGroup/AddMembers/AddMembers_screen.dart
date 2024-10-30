import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_manager_internet_applications_project/color_.dart';
import 'AddMembers_Controller.dart';
import 'AddMembers_widgets.dart';

class AddMembers_screen extends StatefulWidget {
  const AddMembers_screen({Key? key}) : super(key: key);

  @override
  State<AddMembers_screen> createState() => _AddMembers_screenState();
}

class _AddMembers_screenState extends State<AddMembers_screen> {
  TextEditingController _searchController = TextEditingController();
  List<String> selectedItems = [];
  final AddMembersController controller = Get.put(AddMembersController());

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args != null) {
      int groupId = args['groupId'];
    }
    _searchController.addListener(_filterSearchResults);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterSearchResults() {
    controller.filterUsers(_searchController.text);
  }

  void _toggleSelection(String item) {
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add(item);
      }
    });
  }

  void _onAddPressed() {
    final int groupId = Get.arguments['groupId'];
    for (String selectedItem in selectedItems) {
      final selectedUser = controller.users.firstWhere((user) => user.fullname == selectedItem);
      controller.addUser(groupId, selectedUser.id);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Members', style: TextStyle(color: color_.white)),
        backgroundColor: color_.black,
        iconTheme: IconThemeData(color: color_.white),
      ),
      body: Column(
        children: [
          AddMembers_widgets.searchBar(_searchController, _filterSearchResults),
          SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              final itemsToShow = controller.filteredItems.isNotEmpty
                  ? controller.filteredItems
                  : controller.users.map((user) => user.fullname).toList();
              return AddMembers_widgets.userList(itemsToShow, selectedItems, _toggleSelection);
            }),
          ),
          AddMembers_widgets.addButton(_onAddPressed, selectedItems.isNotEmpty),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:file_manager_internet_applications_project/color_.dart';
//
// import 'AddMembers_Controller.dart';
//
// class AddMembers_screen extends StatefulWidget {
//   const AddMembers_screen({Key? key}) : super(key: key);
//
//   @override
//   State<AddMembers_screen> createState() => _AddMembers_screenState();
// }
// class _AddMembers_screenState extends State<AddMembers_screen> {
//   TextEditingController _searchController = TextEditingController();
//   List<String> selectedItems = [];
//   final AddMembersController controller = Get.put(AddMembersController());
//
//   @override
//   void initState() {
//     super.initState();
//
//     final args = Get.arguments;
//     if (args != null) {
//       int groupId = args['groupId'];
//     }
//
//     _searchController.addListener(_filterSearchResults);
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   void _filterSearchResults() {
//     controller.filterUsers(_searchController.text);
//   }
//
//   void _toggleSelection(String item) {
//     setState(() {
//       if (selectedItems.contains(item)) {
//         selectedItems.remove(item);
//       } else {
//         selectedItems.add(item);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(65.0),
//         child: AppBar(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(10),
//             ),
//           ),
//           title: Text('Add Members', style: TextStyle(color: color_.white)),
//           backgroundColor: color_.black,
//           iconTheme: IconThemeData(color: color_.white),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: color_.gray),
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: color_.black),
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 10),
//           Expanded(
//             child: Obx(() {
//               final itemsToShow = controller.filteredItems.isNotEmpty
//                   ? controller.filteredItems
//                   : controller.users.map((user) => user.fullname).toList();
//
//               return itemsToShow.isNotEmpty
//                   ? ListView.builder(
//                 itemCount: itemsToShow.length,
//                 itemBuilder: (context, index) {
//                   String item = itemsToShow[index];
//                   bool isSelected = selectedItems.contains(item);
//                   return ListTile(
//                     title: Text(item, style: TextStyle(color: color_.black)),
//                     trailing: GestureDetector(
//                       onTap: () => _toggleSelection(item),
//                       child: Container(
//                         width: 30,
//                         height: 30,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: isSelected ? color_.black : color_.gray,
//                             width: 2,
//                           ),
//                           color: isSelected ? color_.black : Colors.white30,
//                         ),
//                         child: isSelected
//                             ? Icon(Icons.check, color: color_.white)
//                             : null,
//                       ),
//                     ),
//                   );
//                 },
//               )
//                   : Center(child: Text("No results found"));
//             }),
//           ),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: Padding(
//               padding: const EdgeInsets.only(right: 18.0, bottom: 20),
//               child: ElevatedButton(
//                 onPressed: () {
//                   final int groupId = Get.arguments['groupId'];
//                   for (String selectedItem in selectedItems) {
//                     final selectedUser = controller.users.firstWhere((user) => user.fullname == selectedItem);
//                     controller.addUser(groupId, selectedUser.id);
//                   }
//                   Navigator.pop(context);
//                 },
//                 child: Text("Add", style: TextStyle(color: color_.white, fontSize: 16)),
//                 style: ElevatedButton.styleFrom(
//                   shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   ),
//                   padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
//                   backgroundColor: selectedItems.isNotEmpty ? color_.black : color_.gray,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// class _AddMembers_screenState extends State<AddMembers_screen> {
//   TextEditingController _searchController = TextEditingController();
//   List<String> filteredItems = [];
//   List<String> selectedItems = [];
//   late final Function(String) onMemberAdded;
//   final AddMembersController controller = Get.put(AddMembersController());
//
//   @override
//   void initState() {
//     super.initState();
//
//     final args = Get.arguments;
//     if (args != null) {
//       int groupId = args['groupId'];
//     }
//
//     onMemberAdded = Get.arguments?['onMemberAdded'] ?? (String member) {
//       print("Default: Added member $member");
//     };
//
//     _searchController.addListener(_filterSearchResults);
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   void _filterSearchResults() {
//     controller.filterUsers(_searchController.text); // استخدم دالة filterUsers للقيام بالتصفية
//   }
//
//
//
//
//   void _toggleSelection(String item) {
//     setState(() {
//       if (selectedItems.contains(item)) {
//         selectedItems.remove(item);
//       } else {
//         selectedItems.add(item);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(65.0),
//         child: AppBar(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(10),
//             ),
//           ),
//           title: Text('Add Members', style: TextStyle(color: color_.white)),
//           backgroundColor: color_.black,
//           iconTheme: IconThemeData(color: color_.white),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: color_.gray),
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: color_.black),
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 10),
//           Expanded(
//             child: Obx(() {
//               // استخدم controller.users أو filteredItems هنا
//               return filteredItems.isNotEmpty
//                   ? ListView.builder(
//                 itemCount: filteredItems.length,
//                 itemBuilder: (context, index) {
//                   String item = filteredItems[index];
//                   bool isSelected = selectedItems.contains(item);
//                   return ListTile(
//                     title: Text(item, style: TextStyle(color: color_.black)),
//                     trailing: GestureDetector(
//                       onTap: () => _toggleSelection(item),
//                       child: Container(
//                         width: 30,
//                         height: 30,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: isSelected ? color_.black : color_.gray,
//                             width: 2,
//                           ),
//                           color: isSelected ? color_.black : Colors.white30,
//                         ),
//                         child: isSelected
//                             ? Icon(Icons.check, color: color_.white)
//                             : null,
//                       ),
//                     ),
//                   );
//                 },
//               )
//                   : Center(child: Text("No results found"));
//             }),
//           ),
//
//           // Expanded(
//           //   child: Obx(() {
//           //     return filteredItems.isEmpty && controller.users.isNotEmpty
//           //         ? ListView.builder(
//           //       itemCount: controller.users.length,
//           //       itemBuilder: (context, index) {
//           //         String item = controller.users[index].fullname;
//           //         bool isSelected = selectedItems.contains(item);
//           //         return ListTile(
//           //           title: Text(item, style: TextStyle(color: color_.black)),
//           //           trailing: GestureDetector(
//           //             onTap: () => _toggleSelection(item),
//           //             child: Container(
//           //               width: 30,
//           //               height: 30,
//           //               decoration: BoxDecoration(
//           //                 shape: BoxShape.circle,
//           //                 border: Border.all(
//           //                   color: isSelected ? color_.black : color_.gray,
//           //                   width: 2,
//           //                 ),
//           //                 color: isSelected ? color_.black : Colors.white30,
//           //               ),
//           //               child: isSelected
//           //                   ? Icon(Icons.check, color: color_.white)
//           //                   : null,
//           //             ),
//           //           ),
//           //         );
//           //       },
//           //     )
//           //         : Center(child: Text("No results found"));
//           //   }),
//           // ),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: Padding(
//               padding: const EdgeInsets.only(right: 18.0,bottom: 20),
//               child:
//               ElevatedButton(
//                 onPressed: () {
//                   final int groupId = Get.arguments['groupId'];
//                   for (String selectedItem in selectedItems) {
//                     final selectedUser = controller.users.firstWhere((user) => user.fullname == selectedItem);
//                     controller.addUser(groupId, selectedUser.id);
//                   }
//                   Navigator.pop(context);
//                 },
//                 child: Text("Add", style: TextStyle(color: color_.white, fontSize: 16)),
//                 style: ElevatedButton.styleFrom(
//                   shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   ),
//                   padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
//                   backgroundColor: selectedItems.isNotEmpty ? color_.black : color_.gray,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




