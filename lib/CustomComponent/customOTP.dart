import 'package:flutter/material.dart';

import '../Auth/OTP/OTP_Controller.dart';

Widget buildOtpField(int index, OtpController controller, BuildContext context) {
  return SizedBox(
    width: 40,
    child: TextField(
      controller: controller.otpControllers[index],
      focusNode: controller.focusNodes[index],
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      maxLength: 1,
      decoration: InputDecoration(
        counterText: '',
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.black, width: 2.0),
        ),
      ),
      onChanged: (value) {
        if (value.length == 1) {
          if (index < 5) {
            FocusScope.of(context).requestFocus(controller.focusNodes[index + 1]);
          } else {
            controller.focusNodes[index].unfocus();
          }
        }
      },
    ),
  );
}
