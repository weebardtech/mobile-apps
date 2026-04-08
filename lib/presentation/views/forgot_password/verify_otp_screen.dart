import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/internet_cubit.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;
  VerifyOtpScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState(email);
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  bool _emptyFieldSnackbarShown = false;
  bool isVerifyButtonClicked = false;

  bool isLoading = false;

  String email;
  _VerifyOtpScreenState(this.email);
  bool isResendButtonEnabled = false;
  int countdownSeconds = 60;

  List<String> enteredOtp = List.filled(4, '');

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        countdownSeconds -= 1;
        if (countdownSeconds == 0) {
          timer.cancel();
          isResendButtonEnabled = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<InternetCubit, InternetState>(
            listener: (context, state) {
              if (state is InternetDisconnected) {
                String errorMessage = "No Internet Connection!";
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(errorMessage),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
          ),
         
        ], child: Text('data'),
    );
  }

  void onOtpVerifiedButtonPressed() {
    isVerifyButtonClicked = true;
    // Check if all fields are filled before making the API call
    if (validateForm()) {
      final String otp = enteredOtp.join().toString();

      // BlocProvider.of<ResetPasswordBloc>(context).add(
      //   VerifyOtpButtonPressed(email: email, otp: otp),
      // );
    } else {
      // Display a snackbar indicating that all OTP fields need to be filled
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all OTP fields"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  bool validateForm() {
    // Check if any field is empty
    if (enteredOtp.any((element) => element.isEmpty)) {
      // Display a SnackBar indicating that all OTP fields need to be filled,
      // only if it hasn't been shown before
      if (!_emptyFieldSnackbarShown) {
        _emptyFieldSnackbarShown = true;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please fill all OTP fields"),
            backgroundColor: Colors.red,
          ),
        );
      }
      return false;
    }

    // Reset the flag if all fields are filled
    if (enteredOtp.length == 4) {
      _emptyFieldSnackbarShown = false;
      return true;
    }

    return false;
  }

  void onResetPasswordButtonPressed() {
    isVerifyButtonClicked = false;

    // BlocProvider.of<ResetPasswordBloc>(context).add(
    //   ResetPasswordButtonPressed(email: email),
    // );
  }
}
