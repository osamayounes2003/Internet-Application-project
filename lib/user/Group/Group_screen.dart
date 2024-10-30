import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CustomComponent/BaseScreen.dart';
import '../../CustomComponent/CustomButton.dart';
import '../../color_.dart';
import '../Groups/Groups_Model.dart';
import 'Group_Widgets.dart';

class Group_screen extends StatefulWidget {
  const Group_screen({Key? key}) : super(key: key);

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<Group_screen> {
  late Groups group;
  late bool isAdmin;
  String currentView = 'Members';
  List<String> members = [];
  List<String> uploadedFiles = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Map<String, dynamic> arguments = Get.arguments;
    group = arguments['group'];
    isAdmin = arguments['isAdmin'] ?? false;

    if (group is! Groups) {
      throw Exception('Expected a Groups object');
    }
print("adddddddddddddddddd:$isAdmin");
    members = group.listOfUsers.map((user) => user.fullname).toList();
    uploadedFiles = group.listOfFiles;
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isLargeScreen = constraints.maxWidth > 600;
          return Container(
            width: isLargeScreen ? 600 : double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          group.name,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: MediaQuery.of(context).size.width > 600 ? 24 : 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          group.owner!.fullname.toString(),
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: MediaQuery.of(context).size.width > 600 ? 20 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    if (isAdmin)
                      PopupMenuButton<String>(
                        icon: Icon(Icons.settings,color: color_.gray,),
                        onSelected: (String value) {
                          switch (value) {
                            case 'add_file':
                              print("Add File");
                              Get.toNamed("/upload", arguments: {'groupId': group.id});
                              break;
                            case 'invite_user':
                              print("Invite User");
                              break;
                            case 'join_requests':
                              print("Join Requests");
                              break;
                            case 'file_requests':
                              print("File Requests");
                              break;
                            case 'File_upload_request':
                              print("Request File Addition");
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) => isAdmin
                            ? <PopupMenuEntry<String>>[
                          PopupMenuItem(
                            value: 'add_file',
                            child: Text("Add File"),
                          ),
                          PopupMenuItem(
                            value: 'invite_user',
                            child: Text("Invite User"),
                          ),
                          PopupMenuItem(
                            value: 'join_requests',
                            child: Text("Join Requests"),
                          ),
                          PopupMenuItem(
                            value: 'file_requests',
                            child: Text("File Requests"),
                          ),
                        ]
                            : <PopupMenuEntry<String>>[
                          PopupMenuItem(
                            value: 'File_upload_request',
                            child: Text("File upload request"),
                          ),
                        ],
                      ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        title: "Files",
                        onPressed: () {
                          setState(() {
                            currentView = 'Files';
                          });
                        },
                        color: color_.button,
                      ),
                    ),
                    SizedBox(width: 2),
                    Expanded(
                      child: CustomElevatedButton(
                        title: "Members",
                        onPressed: () {
                          setState(() {
                            currentView = 'Members';
                          });
                        },
                        color: color_.button,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: currentView == 'Members'
                      ? MembersTab(members: members)
                      : FilesTab(uploadedFiles: uploadedFiles),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FilesTab extends StatelessWidget {
  final List<String> uploadedFiles;

  const FilesTab({Key? key, required this.uploadedFiles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return uploadedFiles.isEmpty
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.upload_file, size: 50, color: color_.black),
          Text("No files uploaded."),
        ],
      ),
    )
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomElevatedButton(
          title: "Check in more than one file",
          onPressed: () {},
          color: color_.button,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: uploadedFiles.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(
                    vertical: 8, horizontal: 16),
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.insert_drive_file, color: color_.black),
                  title: Text(
                    uploadedFiles[index],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {

                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class MembersTab extends StatelessWidget {
  final List<String> members;

  const MembersTab({Key? key, required this.members}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return members.isEmpty
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_add, size: 50, color: color_.black),
          SizedBox(height: 10),
          Text(
            "No members available",
            style: TextStyle(fontSize: 16, color: color_.black),
          ),
        ],
      ),
    )
        : Expanded(
      child: ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(
                vertical: 8, horizontal: 16),
            elevation: 4,
            child: ListTile(
              leading: Icon(Icons.person, color: color_.black),
              title: Text(
                members[index],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
