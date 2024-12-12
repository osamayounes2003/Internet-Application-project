import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../CustomComponent/CustomButton.dart';
import '../../../UploadFile/UploadFile_Model.dart';
import '../controller/booked_files_controller.dart';
import '../widgets/detail_row.dart';

class FileDetailScreen extends StatelessWidget {
  final FileModel file;

  FileDetailScreen({required this.file});

  @override
  Widget build(BuildContext context) {
    final MyBookedFilesController myBookedFilesController =
    Get.put(MyBookedFilesController());

    return Scaffold(
      appBar: AppBar(
        title: Text(file.name ?? 'File Details'), // Fallback title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailRow(label: 'Name:', value: file.name ?? 'Unknown'),
                    DetailRow(label: 'URL:', value: file.url ?? 'No URL'),
                    DetailRow(
                      label: 'Status:',
                      value: file.status == 'UNAVAILABLE'
                          ? '!${file.status}'
                          : 'AVAILABLE',
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Tooltip(
                          message: 'Click Check Out File', // Tooltip for Check Out button
                          child: CustomElevatedButton(
                            title: 'Check Out',
                            onPressed: () {
                              // Handle Check Out action
                            },
                          ),
                        ),
                        Tooltip(
                          message: 'Click Report File', // Tooltip for Report button
                          child: CustomElevatedButton(
                            title: 'Report',
                            onPressed: () {
                              // Handle Report action
                            },
                          ),
                        ),
                        Tooltip(
                          message: 'Click Edit File', // Tooltip for Edit button
                          child: CustomElevatedButton(
                            title: 'Edit',
                            onPressed: () {
                              // Handle Edit action
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          text: '$label ',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          children: <TextSpan>[
            TextSpan(
              text: value,
              style: TextStyle(
                  fontWeight: FontWeight.normal, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
