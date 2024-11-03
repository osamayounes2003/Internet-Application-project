class Invitation {
  final int folderId;
  final String ownerName;
  final String folderName;
  final DateTime sendAt;
  final int invitationId;

  Invitation({
    required this.folderId,
    required this.ownerName,
    required this.folderName,
    required this.sendAt,
    required this.invitationId,
  });

  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      folderId: json['folderId'],
      ownerName: json['ownerName'],
      folderName: json['folderName'],
      sendAt: DateTime.parse(json['sendAt']),
      invitationId: json['invitationId'],
    );
  }
}
