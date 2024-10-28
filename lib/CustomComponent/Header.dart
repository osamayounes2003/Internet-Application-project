import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const Header({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (MediaQuery.of(context).size.width <= 600)
            IconButton(
              icon: Icon(Icons.menu, color: Colors.white70),
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ),
          Text(
            "File Manager",
            style: TextStyle(
              color: Colors.white70,
              fontSize: MediaQuery.of(context).size.width > 600 ? 24 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white70),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
