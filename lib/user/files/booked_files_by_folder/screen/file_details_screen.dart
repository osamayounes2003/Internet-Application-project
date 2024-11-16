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
                    DetailRow(label: 'Name:', value: file.name ?? 'Unknown'),
                    DetailRow(label: 'URL:', value: file.url ?? 'No URL'),
                    DetailRow(
                        label: 'Status:',
                        value: file.status == 'UNAVAILABLE'
                            ? '!${file.status}'
                            : 'AVAILABLE'),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomElevatedButton(
                            title: 'Check Out', onPressed: () {
                        }),
                        CustomElevatedButton(
                          title: 'Report',
                          onPressed: () {
                          },
                        ),
                        CustomElevatedButton(
                          title: 'Edit',
                          onPressed: () {
                          },
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
