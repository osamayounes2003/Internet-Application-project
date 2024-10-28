import 'package:file_manager_internet_applications_project/color_.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeAdmin_Screen extends StatelessWidget {
  const HomeAdmin_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_.background,
      body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Image.asset(
                  "assets/file.png",
                  height: 125,
                  width: 125,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "File Manager",
                  style: TextStyle(color: Colors.white70, fontSize: 30),
                ),
              ),
            ],
          ),
      ),
    );
  }
}
