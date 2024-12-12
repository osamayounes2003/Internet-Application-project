import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../Theme/ThemeController.dart';
import '../../../color_.dart';
import '../controllers/JoinRequestToMyGroups_Controller.dart';

class Requestscard extends StatefulWidget {
  final int groupId;
  final String groupName;

  Requestscard({required this.groupId, required this.groupName, Key? key}) : super(key: key);

  @override
  _RequestscardState createState() => _RequestscardState();
}

class _RequestscardState extends State<Requestscard> {
  final JoinRequestToMyGroupsController _joinRequestController = Get.put(JoinRequestToMyGroupsController());

  @override
  void initState() {
    super.initState();
    _joinRequestController.fetchJoinRequests(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final String currentTheme = themeController.currentTheme.value;

    return Scaffold(
      backgroundColor: AppColors.background(context, currentTheme),
      appBar: AppBar(
        title: Text(
          "requests_for_group".tr + " ${widget.groupName}",
          style: TextStyle(
            color: AppColors.textPrimary(context, currentTheme),
          ),
        ),
        backgroundColor: AppColors.background2(context, currentTheme),
      ),
      body: Obx(() {
        if (_joinRequestController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (_joinRequestController.joinRequests.isEmpty) {
          return Center(
            child: Text(
              "no_join_requests_available".tr,
              style: TextStyle(
                color: AppColors.font(context, currentTheme),
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: _joinRequestController.joinRequests.length,
          itemBuilder: (context, index) {
            final request = _joinRequestController.joinRequests[index];
            return Card(
              color: currentTheme == 'dark' ? AppColors.background2(context, currentTheme) : AppColors.background(context, currentTheme),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(request.nameUser, style: TextStyle(color: AppColors.textPrimary(context, currentTheme))),
                subtitle: Text(
                  "requested_on".tr + " ${DateFormat('dd-MM-yyyy HH:mm').format(request.sendAt)}",
                  style: TextStyle(color: AppColors.textSecondary(context, currentTheme)),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Tooltip(
                      message: "Reject Request",
                      child: CircleAvatar(
                        backgroundColor: AppColors.background2(context, currentTheme),
                        child: IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () async {
                            await _joinRequestController.rejectInvitation(request.joinRequestId, widget.groupId);
                            await _joinRequestController.fetchJoinRequests(widget.groupId);
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Tooltip(
                      message: "Accept Request",
                      child: CircleAvatar(
                        backgroundColor: AppColors.background2(context, currentTheme),
                        child: IconButton(
                          icon: Icon(Icons.check, color: Colors.green),
                          onPressed: () async {
                            await _joinRequestController.acceptInvitation(request.joinRequestId, widget.groupId);
                            await _joinRequestController.fetchJoinRequests(widget.groupId);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}