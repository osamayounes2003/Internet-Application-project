import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import '../../../CustomComponent/CustomButton.dart';
import '../../../color_.dart';
import '../../Groups/models/Groups_Model.dart';

class Group_widgets {
  static Widget buildHeader(BuildContext context, Groups group, bool isAdmin) {
    return Row(
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
            icon: Icon(Icons.settings, color: color_.gray),
            onSelected: (String value) {
            },
            itemBuilder: (BuildContext context) => isAdmin
                ? <PopupMenuEntry<String>>[
              PopupMenuItem(value: 'add_file', child: Text("Add File")),
              PopupMenuItem(value: 'invite_user', child: Text("Invite User")),
              PopupMenuItem(value: 'join_requests', child: Text("Join Requests")),
              PopupMenuItem(value: 'file_requests', child: Text("File Requests")),
            ]
                : <PopupMenuEntry<String>>[
              PopupMenuItem(value: 'File_upload_request', child: Text("File upload request")),
            ],
          ),
      ],
    );
  }

  static Widget buildViewToggle({required Function(String) onSelect}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomElevatedButton(
            title: "Files",
            onPressed: () {
              onSelect('Files');
            },
            color: color_.button,
          ),
        ),
        SizedBox(width: 2),
        Expanded(
          child: CustomElevatedButton(
            title: "Members",
            onPressed: () {
              onSelect('Members');
            },
            color: color_.button,
          ),
        ),
      ],
    );
  }

  static Widget buildMembersTab(List<String> members) {
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
        : ListView.builder(
      itemCount: members.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.person, color: color_.black),
          title: Text(members[index]),
        );
      },
    );
  }

  static Widget buildFilesTab(List<String> uploadedFiles) {
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
        : ListView.builder(
      itemCount: uploadedFiles.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.insert_drive_file, color: color_.black),
          title: Text(uploadedFiles[index]),
          onTap: () {
            _openFile(uploadedFiles[index]);
          },
        );
      },
    );
  }

  static void _openFile(String filePath) async {
    print('Opening file: $filePath');
    final result = await OpenFilex.open(filePath);
    print('Open file result: $result');
  }
}

