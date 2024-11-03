import 'package:flutter/material.dart';
import '../../../color_.dart';
import '../screens/RequestsCard_screen.dart';

class JoinRequestsUsers_widgets {
  static Widget header() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Joining Requests to My Groups",
        style: TextStyle(
          color: color_.gray,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget list(List<dynamic> groups) {
    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        return Center(
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    content: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Requestscard(
                          groupId: group.id,
                          groupName: group.name,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Card(
                color: color_.gray,
                child: ListTile(
                  title: Text(
                    group.name,
                    style: TextStyle(color: color_.white),
                  ),
                  trailing: Icon(Icons.group_add_rounded, color: color_.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}