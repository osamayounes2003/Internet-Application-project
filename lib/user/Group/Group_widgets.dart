import 'package:flutter/material.dart';
import 'dart:io';
import 'package:open_filex/open_filex.dart';
import '../../color_.dart';

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
}

class FilesTab extends StatelessWidget {
  final List<String> uploadedFiles;

  const FilesTab({Key? key, required this.uploadedFiles}) : super(key: key);

  void _openFile(File file) async {
    print('Opening file: ${file.path}');
    final result = await OpenFilex.open(file.path);
    print('Open file result: $result');
  }

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
        : ListView.builder(
      itemCount: uploadedFiles.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.insert_drive_file, color: color_.black),
          title: Text(uploadedFiles[index]),
          onTap: () {
            _openFile(File(uploadedFiles[index]));
          },
        );
      },
    );
  }
}
