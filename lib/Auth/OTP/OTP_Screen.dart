import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'OTP_Controller.dart';

class OTP_Screen extends StatefulWidget {
  final String nextRoute;

  OTP_Screen({required this.nextRoute});

  @override
  State<OTP_Screen> createState() => _OTP_ScreenState();
}

class _OTP_ScreenState extends State<OTP_Screen> {
  @override
  Widget build(BuildContext context) {

    final OtpController controller = Get.put(OtpController(nextRoute: widget.nextRoute));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
                style: TextStyle(
                  fontSize: 30,
                ),
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
                return _buildOtpField(index, controller);
              }),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller.verifyOtp();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black45,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)))),
                    child: Text('Verify ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Obx(() => controller.isLoading.value
                ? CircularProgressIndicator()
                : Container()), // Indicator for loading
          ],
        ),
      ),
    );
  }

  Widget _buildOtpField(int index, OtpController controller) {
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
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
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
}
