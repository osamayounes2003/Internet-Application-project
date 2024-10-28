import 'package:file_manager_internet_applications_project/color_.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'header.dart';
import '../../CustomComponent/SideBar.dart';

class BaseScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Widget child;

  BaseScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: color_.background,
      drawer: MediaQuery.of(context).size.width > 600
          ? null
          : Drawer(
        backgroundColor: Colors.black87,
        child: SidebarContent(),
      ),
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width > 600)
            Container(
              width: 250,
              color: Colors.black87,
              child: SidebarContent(),
            ),
          Expanded(
            child: Column(
              children: [
                Header(scaffoldKey: scaffoldKey),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
