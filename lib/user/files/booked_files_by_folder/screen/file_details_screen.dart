import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../CustomComponent/CustomButton.dart';
import '../../../UploadFile/UploadFile_Model.dart';
import '../../my_booked_files/widgets/detail_row.dart';

class FileDetailScreen extends StatelessWidget {
  final FileModel file;

  const FileDetailScreen({required this.file});

  @override
  Widget build(BuildContext context) {

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
                    Tooltip(
                      message: 'File Name', // Tooltip for the file name
                      child: DetailRow(label: 'Name:', value: file.name ?? 'Unknown'),
                    ),
                    Tooltip(
                      message: 'File URL', // Tooltip for the URL
                      child: DetailRow(label: 'URL:', value: file.url ?? 'No URL'),
                    ),
                    Tooltip(
                      message: 'File Status', // Tooltip for the file status
                      child: DetailRow(
                          label: 'Status:',
                          value: file.status == 'UNAVAILABLE'
                              ? '!${file.status}'
                              : 'AVAILABLE'),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Tooltip(
                          message: 'Click to Check Out', // Tooltip for the Check Out button
                          child: CustomElevatedButton(
                              title: 'Check Out', onPressed: () {}),
                        ),
                        Tooltip(
                          message: 'Report the file', // Tooltip for the Report button
                          child: CustomElevatedButton(
                            title: 'Report',
                            onPressed: () {},
                          ),
                        ),
                        Tooltip(
                          message: 'Edit file details', // Tooltip for the Edit button
                          child: CustomElevatedButton(
                            title: 'Edit',
                            onPressed: () {},
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
