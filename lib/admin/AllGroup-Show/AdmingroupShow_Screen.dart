import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../CustomComponent/BaseScreen.dart';
import '../../../CustomComponent/CustomButton.dart';
import '../../../Theme/ThemeController.dart';
import '../../../color_.dart';
import '../../user/Group/screens/Group_screen.dart';
import '../../user/Groups/models/Groups_Model.dart';
import '../../user/Reports/UserReports_Controller.dart';
import 'AllGroupShow_controller.dart';

class AdminGroupShow_screen extends StatefulWidget {
  const AdminGroupShow_screen({Key? key}) : super(key: key);

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<AdminGroupShow_screen> with SingleTickerProviderStateMixin {
  Groups? group;
  String currentView = 'Members';
  List<String> members = [];
  List<File> uploadedFiles = [];
  late TabController _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Map<String, dynamic>? arguments = Get.arguments;

    if (arguments != null) {
      group = arguments['group'];
    }

    if (group != null) {
      members = group!.listOfUsers.map((user) => user.user.fullname).toList();
      uploadedFiles = group!.listOfFiles;

      Get.find<GroupsAdminController>().categorizeUsersByStatus(group!.id);
    } else {
      print("Group not found, displaying default view.");
    }

    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {

    final themeController = Get.find<ThemeController>();
    String currentTheme = themeController.currentTheme.value;
    final downloadReportController = Get.put(DownloadUserReportController());


    if (group == null) {
      return BaseScreen(
        child: Center(
          child: Text("no_group_selected".tr,
              style: TextStyle(color: AppColors.font(context, currentTheme), fontSize: 18)),
        ),
      );
    }

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
                          group!.name,
                          style: TextStyle(
                            color: AppColors.font(context, themeController.currentTheme.value),
                            fontSize: MediaQuery.of(context).size.width > 600
                                ? 24
                                : 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          group!.owner!.fullname.toString(),
                          style: TextStyle(
                            color: AppColors.font(context, themeController.currentTheme.value),
                            fontSize: MediaQuery.of(context).size.width > 600
                                ? 20
                                : 16,
                            fontWeight: FontWeight.bold,
                          ),
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
                        title: "files".tr,
                        onPressed: () {
                          setState(() {
                            currentView = 'Files';
                          });
                        },
                        color: AppColors.button(context, themeController.currentTheme.value),
                      ),
                    ),
                    SizedBox(width: 2),
                    Expanded(
                      child: CustomElevatedButton(
                        title: "members".tr,
                        onPressed: () {
                          setState(() {
                            currentView = 'Members';
                          });
                        },
                        color: AppColors.button(context, themeController.currentTheme.value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: currentView == 'Members'
                      ? DefaultTabController(
                    length: 3,  // Three tabs for different user statuses
                    child: Column(
                      children: [
                        TabBar(
                          controller: _tabController,
                          tabs: [
                            Tab(text: 'ACCEPTED'),
                            Tab(text: 'INVITATION'),
                            Tab(text: 'REQUEST'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              // Show Accepted Users
                              UsersListTab(status: 'ACCEPTED', groupId: group!.id,currentTheme: currentTheme,downloadReportController: downloadReportController,),
                              // Show Invitation Users
                              UsersListTab(status: 'INVITATION', groupId: group!.id,currentTheme: currentTheme,downloadReportController: downloadReportController,),
                              // Show Request Users
                              UsersListTab(status: 'REQUEST', groupId: group!.id,currentTheme: currentTheme,downloadReportController: downloadReportController,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
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

class UsersListTab extends StatelessWidget {
  final String status;
  final int groupId;
  final String currentTheme;
  final DownloadUserReportController downloadReportController;


  const UsersListTab({required this.status, required this.groupId, required this.currentTheme, required this.downloadReportController});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GroupsAdminController>();

    List<UserInFolder> filteredUsers = [];
    if (status == 'ACCEPTED') {
      filteredUsers = controller.acceptedList;
    } else if (status == 'INVITATION') {
      filteredUsers = controller.invitationList;
    } else if (status == 'REQUEST') {
      filteredUsers = controller.requestList;
    }

    return ListView.builder(
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        final user = filteredUsers[index];
        return ListTile(
          title: Text(user.user.fullname),
          subtitle: Text(user.user.email),
          trailing: IconButton(
            icon: Icon(
              Icons.report_problem,
              color: AppColors.primary(context, currentTheme),
            ),
            onPressed: () {
              downloadReportController.downloadReport(groupId, user.user.id);
            },
          ),
        );
      },
    );
  }
}
