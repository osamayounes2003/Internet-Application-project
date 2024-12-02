import 'package:flutter/material.dart';

class CustomTooltip extends StatelessWidget {
  final String message;
  final Widget child;

  const CustomTooltip({
    Key? key,
    required this.message,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      padding: EdgeInsets.all(8),
      verticalOffset: 20,
      preferBelow: true,
      child: child,
    );
  }
}
