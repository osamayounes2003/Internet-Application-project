import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../color_.dart';
import '../Groups/Groups_Model.dart';
import 'Group_Widgets.dart';

class Group_screen extends StatefulWidget {
  const Group_screen({Key? key}) : super(key: key);

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<Group_screen> with SingleTickerProviderStateMixin {
  late Groups group;
  late TabController _tabController;
  List<String> members = [];
  List<String> uploadedFiles = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Map<String, dynamic> arguments = Get.arguments;
    print(arguments);
    group = arguments['group'];

    if (group is! Groups) {
      throw Exception('Expected a Groups object');
    }

    members = group.listOfUsers;
    uploadedFiles = group.listOfFiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110.0),
        child: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          title: Text(
            group.name,
            style: TextStyle(color: color_.white),
          ),
          backgroundColor: color_.black,
          iconTheme: IconThemeData(color: color_.white),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: color_.white,
            labelColor: color_.white,
            unselectedLabelColor: color_.gray,
            tabs: [
              Tab(text: 'Members'),
              Tab(text: 'Files'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MembersTab(members: members),
          FilesTab(uploadedFiles: uploadedFiles),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:open_filex/open_filex.dart';
// import 'dart:io';
// import '../../color_.dart';
// import '../Groups/Groups_Model.dart';
//
// class Group_screen extends StatefulWidget {
//   const Group_screen({Key? key}) : super(key: key);
//
//   @override
//   _GroupScreenState createState() => _GroupScreenState();
// }
//
// class _GroupScreenState extends State<Group_screen> with SingleTickerProviderStateMixin {
//   late Groups group; // Store the group object
//   late TabController _tabController;
//   List<String> members = [];
//   List<String> uploadedFiles = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this); // Initialize TabController
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//
//     // Retrieve the group object passed from Groups_screen
//     final Map<String, dynamic> arguments = Get.arguments;
//     group = arguments['group'];
//
//     // Populate the members and uploadedFiles with data from the group
//     members = group.listOfUsers.map((user) => user.fullname).toList();
//     uploadedFiles = group.listOfFiles ?? [];
//   }
//
//   // Function to open files
//   void _openFile(File file) async {
//     print('Opening file: ${file.path}');
//     final result = await OpenFilex.open(file.path);
//     print('Open file result: $result');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(110.0),
//         child: AppBar(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(10),
//             ),
//           ),
//           title: Text(
//             group.name, // Display the group name from the passed object
//             style: TextStyle(color: color_.white),
//           ),
//           backgroundColor: color_.black,
//           iconTheme: IconThemeData(color: color_.white),
//           bottom: TabBar(
//             controller: _tabController,
//             indicatorColor: color_.white,
//             labelColor: color_.white,
//             unselectedLabelColor: color_.gray,
//             tabs: [
//               Tab(text: 'Members'),
//               Tab(text: 'Files'),
//             ],
//           ),
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           // Members Tab
//           members.isEmpty
//               ? Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.person_add, size: 50, color: color_.black),
//                 SizedBox(height: 10),
//                 Text(
//                   "No members available",
//                   style: TextStyle(fontSize: 16, color: color_.black),
//                 ),
//               ],
//             ),
//           )
//               : ListView.builder(
//             itemCount: members.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 leading: Icon(Icons.person, color: color_.black),
//                 title: Text(members[index]),
//               );
//             },
//           ),
//           // Files Tab
//           uploadedFiles.isEmpty
//               ? Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.upload_file, size: 50, color: color_.black),
//                 Text("No files uploaded."),
//               ],
//             ),
//           )
//               : ListView.builder(
//             itemCount: uploadedFiles.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 leading: Icon(Icons.insert_drive_file, color: color_.black),
//                 title: Text(uploadedFiles[index]), // Display the file name
//                 onTap: () {
//                   // Dummy file opening logic, replace with actual file opening if needed
//                   _openFile(File(uploadedFiles[index]));
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }