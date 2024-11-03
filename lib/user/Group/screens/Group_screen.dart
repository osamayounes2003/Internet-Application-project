import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../CustomComponent/BaseScreen.dart';

import '../../Groups/models/Groups_Model.dart';
import '../widgets/Group_widgets.dart';

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
                Group_widgets.buildHeader(context, group, isAdmin),
                Group_widgets.buildViewToggle(
                  onSelect: (view) {
                    setState(() {
                      currentView = view;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: currentView == 'Members'
                      ? Group_widgets.buildMembersTab(members)
                      : Group_widgets.buildFilesTab(uploadedFiles),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}