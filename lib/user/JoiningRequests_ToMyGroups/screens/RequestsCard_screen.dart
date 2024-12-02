import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Theme/ThemeController.dart';
import '../../../color_.dart';
import '../controllers/JoinRequestToMyGroups_Controller.dart';
import '../widgets/RequestCardWidget.dart';

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
          "requests_for_group".tr+"${widget.groupName}",
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
            return RequestCardWidget(
              request: request,
              groupId: widget.groupId,
              joinRequestController: _joinRequestController,
            );
          },
        );
      }),
    );
  }
}
