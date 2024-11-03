import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../color_.dart';
import '../controllers/JoinRequestToMyGroups_Controller.dart';
import '../models/JoinRequestsToMyGroups_Model.dart';

class RequestCardWidget extends StatelessWidget {
  final JoinRequestToMyGroups request;
  final int groupId;
  final JoinRequestToMyGroupsController joinRequestController;

  RequestCardWidget({
    required this.request,
    required this.groupId,
    required this.joinRequestController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color_.gray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(request.nameUser, style: TextStyle(color: color_.white)),
        subtitle: Text(
          "Requested on: ${DateFormat('dd-MM-yyyy HH:mm').format(request.sendAt)}",
          style: TextStyle(color: color_.font),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: color_.font,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: () async {
                  await joinRequestController.rejectInvitation(request.joinRequestId, groupId);
                  await joinRequestController.fetchJoinRequests(groupId);
                },
              ),
            ),
            SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: color_.font,
              child: IconButton(
                icon: Icon(Icons.check, color: Colors.green),
                onPressed: () async {
                  await joinRequestController.acceptInvitation(request.joinRequestId, groupId);
                  await joinRequestController.fetchJoinRequests(groupId);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
