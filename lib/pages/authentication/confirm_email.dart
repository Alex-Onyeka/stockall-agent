import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stockallagent/classes/action_result.dart';
import 'package:stockallagent/classes/user_class.dart';
import 'package:stockallagent/components/buttons/primary_button.dart';
import 'package:stockallagent/components/pin_code_widget.dart';
import 'package:stockallagent/constants/comp_constants.dart';
import 'package:stockallagent/constants/media_links.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/authentication/base_page.dart';
import 'package:stockallagent/service/auth_service.dart';

class ConfirmEmail extends StatefulWidget {
  final UserClass user;
  const ConfirmEmail({super.key, required this.user});

  @override
  State<ConfirmEmail> createState() => ConfirmEmailState();
}

class ConfirmEmailState extends State<ConfirmEmail> {
  int time = 0;
  Timer? _timer;

  void startCountDownTimer() {
    setState(() {
      time = 120;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (
      timer,
    ) async {
      if (time > 0) {
        setState(() {
          time--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String formatTime(int time) {
    if (time < 60) {
      return '${time.toString()} secs';
    } else if (time >= 60 && time < 120) {
      return '1:${time - 60} secs';
    } else if (time >= 120 && time < 180) {
      return '2:${time - 120} secs';
    } else {
      return '3:${time - 180} secs';
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startCountDownTimer();
  }

  final pinC = TextEditingController();
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return SafeArea(
      child: GestureDetector(
        onTap: () =>
            FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            Image.asset(
                              verifyAccountIcon,
                              height: 180,
                            ),
                            SizedBox(height: 10),
                            Text(
                              style: TextStyle(
                                fontSize: theme
                                    .mobileTexts
                                    .h3
                                    .fontSize,
                                fontWeight: FontWeight.bold,
                              ),
                              'OTP Sent to your Email',
                            ),
                            SizedBox(height: 10),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 250,
                              ),
                              child: Text(
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: theme
                                      .mobileTexts
                                      .b2
                                      .fontSize,
                                  fontWeight:
                                      FontWeight.normal,
                                ),
                                'A confirmation OTP has been sent to your email: ${widget.user.email}, enter the PIN below to verify your account.',
                              ),
                            ),
                            SizedBox(height: 20),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 280,
                              ),
                              child: PinCodeWidget(
                                controller: pinC,
                                length: 6,
                                hideText: false,
                                action: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  var res =
                                      await AuthService()
                                          .verifyOtp(
                                            user:
                                                widget.user,
                                            userId: widget
                                                .user
                                                .userId!,
                                            otp: pinC.text,
                                          );
                                  if (res == 0 &&
                                      context.mounted) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    showSnackbar(
                                      actionResult:
                                          ActionResult()
                                              .error,
                                      title:
                                          'An Error Occoured',
                                      message:
                                          'It seems the OTP is Expired. Please request for a new PIN, or check your internet Connection and try again.',
                                      context: context,
                                    );
                                    pinC.clear();
                                  } else {
                                    if (context.mounted) {
                                      showSnackbar(
                                        actionResult:
                                            ActionResult()
                                                .success,
                                        title:
                                            'Account Verified Success!',
                                        message:
                                            'Congratulations, Your Account has been verified successfully',
                                        context: context,
                                      );
                                      await Future.delayed(
                                        Duration(
                                          seconds: 2,
                                        ),
                                        () {},
                                      );
                                      if (context.mounted) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return BasePage();
                                            },
                                          ),
                                        );
                                      }
                                    }
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Text(
                                  style: TextStyle(
                                    fontSize: theme
                                        .mobileTexts
                                        .b2
                                        .fontSize,
                                  ),
                                  'Remaining Time: ',
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (time > 0) {
                                      {}
                                    } else {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await AuthService()
                                          .resendVerificationLink(
                                            widget
                                                .user
                                                .email,
                                          );
                                      setState(() {
                                        time = 120;
                                      });
                                      startCountDownTimer();
                                      if (context.mounted) {
                                        showSnackbar(
                                          actionResult:
                                              ActionResult()
                                                  .success,
                                          title:
                                              'PIN Sent Success',
                                          message:
                                              'Another OTP has been sent to your email, please proceed to verify your account.',
                                          context: context,
                                        );
                                      }
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(
                                          5.0,
                                        ),
                                    child: Text(
                                      style: TextStyle(
                                        fontSize: theme
                                            .mobileTexts
                                            .b1
                                            .fontSize,
                                        fontWeight:
                                            FontWeight.bold,
                                        color: time > 0
                                            ? theme
                                                  .lightModeColor
                                                  .secColor200
                                            : theme
                                                  .lightModeColor
                                                  .secColor100,
                                      ),
                                      time > 0
                                          ? formatTime(time)
                                          : 'Resend PIN',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  PrimaryButton(
                    isLoading: isLoading,
                    title: 'Cancel',
                    action: () async {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
