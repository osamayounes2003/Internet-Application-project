import 'package:flutter/material.dart';

import '../../../../color_.dart';

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({
    required this.label,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
            child: Divider(
              thickness: 3,
              color:color_.greydark ,
            ),
          ),
        ],
      ),
    );
  }
}