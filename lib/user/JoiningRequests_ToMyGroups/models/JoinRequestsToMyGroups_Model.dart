class JoinRequestToMyGroups {
  final int userId;
  final String nameUser;
  final DateTime sendAt;
  final int joinRequestId;

  JoinRequestToMyGroups({
    required this.userId,
    required this.nameUser,
    required this.sendAt,
    required this.joinRequestId,
  });

  factory JoinRequestToMyGroups.fromJson(Map<String, dynamic> json) {
    return JoinRequestToMyGroups(
      userId: json['userId'],
      nameUser: json['nameUser'],
      sendAt: DateTime.parse(json['sendAt']),
      joinRequestId: json['joinRequestId'],
    );
  }
}
