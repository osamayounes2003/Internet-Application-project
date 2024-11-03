import 'package:file_manager_internet_applications_project/color_.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/InvitationController.dart';

class JoiningRequests_widgets {
  static Widget titleText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          color: color_.gray,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget invitationCard(
      dynamic invitation,
      InvitationController controller,
      ) {
    return Card(
      color: color_.gray,
      child: ListTile(
        title: Text(
          invitation.folderName,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          "Owner: ${invitation.ownerName} \n Sent At: ${DateFormat('yyyy-MM-dd HH:mm').format(invitation.sendAt)}",
          style: TextStyle(color: Colors.white70),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _acceptButton(() => controller.acceptInvitation(invitation.invitationId)),
            const SizedBox(width: 8),
            _rejectButton(() => controller.rejectInvitation(invitation.invitationId)),
          ],
        ),
      ),
    );
  }

  static Widget _acceptButton(VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: color_.white,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(Icons.check, color: Colors.green),
        onPressed: onPressed,
      ),
    );
  }

  static Widget _rejectButton(VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: color_.white,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(Icons.close, color: Colors.red),
        onPressed: onPressed,
      ),
    );
  }
}
