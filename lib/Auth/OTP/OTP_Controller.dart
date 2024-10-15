import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  var isLoading = false.obs;

  List<TextEditingController> otpControllers = List.generate(6, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  String nextRoute;

  OtpController({required this.nextRoute});

  void verifyOtp() {
    String otp = otpControllers.map((controller) => controller.text).join();

    if (otp.length != 6) {
      Get.snackbar(
        'Error',
        'OTP must be 6 digits',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // محاكاة  الـ OTP
    isLoading.value = true;
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;

      if (otp == "123456") {
        Get.snackbar(
          'Success',
          'OTP Verified',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed(nextRoute);
      } else {
        Get.snackbar(
          'Error',
          'Invalid OTP',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    });
  }

  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.onClose();
  }
}
