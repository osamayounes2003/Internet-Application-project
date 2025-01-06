import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../CustomComponent/CustomButton.dart';
import '../../../UploadFile/UploadFile_Model.dart';
import '../../check_out_file/controller/check_out_controller.dart';
import '../controller/booked_files_controller.dart';
import '../widgets/detail_row.dart';

class FileDetailScreen extends StatelessWidget {
  final FileModel file;

  FileDetailScreen({Key? key, required this.file}) : super(key: key);
  final CheckoutController checkoutController = Get.put(CheckoutController());
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(file.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
        child: ListView(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailRow(label: 'Name:', value: file.name ?? 'Unknown'),
                    DetailRow(
                      label: 'Status:',
                      value: file.status == 'UNAVAILABLE'
                          ? '!${file.status}'
                          : 'AVAILABLE',
                    ),
                    SizedBox(height: screenWidth * 0.04), // Responsive spacing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Tooltip(
                          message: 'Click Check Out File',
                          child: CustomElevatedButton(
                            title: 'Check Out',
                            onPressed: () {
                              checkoutController.showCheckoutDialog(file.id);
                            },
                          ),
                        ),

                        Tooltip(
                          message: 'Click Download File',
                          child: CustomElevatedButton(
                            title: 'Download',
                            onPressed: () async {
                              final url = file.url;
                              if (url != null && await canLaunch(url)) {
                                await launch(url, forceSafariVC: false, forceWebView: false);
                              } else {
                                // Handle the error if the URL can't be launched
                                Get.snackbar('Error', 'Could not launch $url');
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}