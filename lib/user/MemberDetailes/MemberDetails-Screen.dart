import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CustomComponent/BaseScreen.dart';
import '../Groups/models/Groups_Model.dart';
import '../../Theme/ThemeController.dart';
import 'package:file_manager_internet_applications_project/color_.dart';

import '../Reports/UserReports_Controller.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>?;

    if (arguments == null || arguments['user'] == null || arguments['member'] == null) {
      return BaseScreen(
        child: Center(
          child: Text(
            'No data available',
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
        ),
      );
    }

    final User user = arguments['user'];
    final UserInFolder member = arguments['member'];
    final int groupId = arguments['groupId']; // استلام groupId


    final themeController = Get.find<ThemeController>();
    String currentTheme = themeController.currentTheme.value;

    final downloadReportController = Get.put(DownloadUserReportController());

    final bool isWeb = MediaQuery.of(context).size.width > 600;

    return BaseScreen(
      child: Align(
        alignment: Alignment.topLeft,
        child: Card(
          margin: const EdgeInsets.all(20),
          elevation: 10,
          color: AppColors.background2(context, currentTheme),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: isWeb ? 600 : double.infinity,
            height: 400,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.report_problem,
                      color: AppColors.primary(context, currentTheme),
                    ),
                    onPressed: () {
                      downloadReportController.downloadReport(groupId, user.id);
                    },
                  ),
                ),
                isWeb
                    ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.primary(context, currentTheme),
                        child: Text(
                          user.fullname[0].toUpperCase(),
                          style: TextStyle(
                            color: AppColors.white(context, currentTheme),
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name: ${user.fullname}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.font(context, currentTheme),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Email: ${user.email}",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.gray(context, currentTheme),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Role: ${user.role}",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.gray(context, currentTheme),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Status: ${member.status}",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.gray(context, currentTheme),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primary(context, currentTheme),
                      child: Text(
                        user.fullname[0].toUpperCase(),
                        style: TextStyle(
                          color: AppColors.white(context, currentTheme),
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Name: ${user.fullname}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.font(context, currentTheme),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Email: ${user.email}",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.gray(context, currentTheme),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Role: ${user.role}",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.gray(context, currentTheme),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Status: ${member.status}",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.gray(context, currentTheme),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
