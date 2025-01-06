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
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Define responsive font sizes
    double labelFontSize = screenWidth < 600 ? 16 : 20; // Smaller font for small screens
    double valueFontSize = screenWidth < 600 ? 14 : 15;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.01), // Responsive vertical padding
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: labelFontSize),
                ),
                Spacer(),
                Text(
                  value,
                  style: TextStyle(fontSize: valueFontSize),
                ),
              ],
            ),
            SizedBox(
              height: 10,
              child: Divider(
                thickness: 3,
                color: color_.greydark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}