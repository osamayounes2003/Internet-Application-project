import 'dart:convert';
import 'package:file_manager_internet_applications_project/Auth/ResetPassword/NewPassword_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'OTP_Model.dart';

class OtpController extends GetxController {
  var isLoading = false.obs;

  List<TextEditingController> otpControllers = List.generate(6, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  String nextRoute;
  String emailAddress;

  OtpController({required this.nextRoute, required this.emailAddress});

  Future<void> verifyOtp() async {
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

    OtpModel otpModel = OtpModel(email: emailAddress, verificationCode: otp);

    await _verifyOtpOnServer(otpModel);
  }

  Future<void> _verifyOtpOnServer(OtpModel otpModel) async {
    isLoading.value = true;
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('http://195.88.87.77:8888/api/v1/auth/verification'));

    request.body = json.encode(otpModel.toJson());
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      isLoading.value = false;

      if (response.statusCode == 200 || response.statusCode==201) {
        Get.snackbar(
          'Success',
          'OTP Verified Successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        if(nextRoute=='/newPassword'){
          Get.to(() => NewPassword_Screen(
            emailAddress: emailAddress,
          ));
        }else{
          Get.offAllNamed(nextRoute);
        }

      } else {
        Get.snackbar(
          'Error',
          'Failed to verify OTP: ${response.reasonPhrase}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("errooooooooor: $e");
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to verify OTP: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
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
