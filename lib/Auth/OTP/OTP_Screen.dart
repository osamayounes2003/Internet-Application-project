import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../CustomComponent/CustomButton.dart';
import '../../CustomComponent/customOTP.dart';
import 'OTP_Controller.dart';

class OTP_Screen extends StatefulWidget {
  final String nextRoute;
  final String emailAddress;

  OTP_Screen({required this.nextRoute, required this.emailAddress});

  @override
  State<OTP_Screen> createState() => _OTP_ScreenState();
}

class _OTP_ScreenState extends State<OTP_Screen> {
  @override
  Widget build(BuildContext context) {
    final OtpController controller = Get.put(OtpController(
      nextRoute: widget.nextRoute,
      emailAddress: widget.emailAddress,
    ));

    double screenWidth = MediaQuery.of(context).size.width;
    bool isWeb = screenWidth > 600;

    return Scaffold(
      body: Container(
        decoration: isWeb
            ? BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade800,Colors.black, ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        )
            : BoxDecoration(color: Colors.white),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: isWeb ? 400 : double.infinity,
              padding: EdgeInsets.all(20),
              decoration: isWeb
                  ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(4, 4),
                  ),
                ],
              )
                  : null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/OTP.png",
                    height: 150,
                    width: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      "Verification",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Text(
                    'Please enter the code sent to your email',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return buildOtpField(index, controller, context);
                    }),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomElevatedButton(
                          title: 'Verify',
                          onPressed: () {
                            controller.verifyOtp();
                          },
                          isLoading: controller.isLoading.value,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Obx(() => controller.isLoading.value
                      ? CircularProgressIndicator()
                      : Container()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
