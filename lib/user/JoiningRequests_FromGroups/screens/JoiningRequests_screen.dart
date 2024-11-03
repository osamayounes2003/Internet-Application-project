import 'package:file_manager_internet_applications_project/CustomComponent/BaseScreen.dart';
import 'package:file_manager_internet_applications_project/user/JoiningRequests_FromGroups/controllers/InvitationController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../color_.dart';
import '../widgets/JoiningRequests_widgets.dart';

class JoiningRequests_screen extends StatelessWidget {
  JoiningRequests_screen({Key? key}) : super(key: key);

  final InvitationController _controller = Get.put(InvitationController());

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          JoiningRequests_widgets.titleText("Joining Requests"),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              if (_controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (_controller.invitations.isEmpty) {
                return Center(
                  child: Text(
                    "No Joining Requests Available",
                    style: TextStyle(color: color_.gray),
                  ),
                );
              }
              return ListView.builder(
                itemCount: _controller.invitations.length,
                itemBuilder: (context, index) {
                  final invitation = _controller.invitations[index];
                  return JoiningRequests_widgets.invitationCard(invitation, _controller);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
