import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordOtpScreen extends StatelessWidget {
  const ForgotPasswordOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "You've got the\nsecret code!",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Enter the confirmation code we just send you in your email.",
              ),

              const SizedBox(height: 30),

              TextField(
                decoration: InputDecoration(
                  hintText: "Enter OTP here",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  const Text("Don't receive a code? "),
                  TextButton(onPressed: () {}, child: const Text("resend")),
                ],
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF041C3F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Confirm OTP",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const Spacer(),

              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'By clicking "Register now/Login" you agree to our ',
                    ),
                    TextSpan(
                      text: "Terms.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: " Learn how we process your data in our "),
                    TextSpan(
                      text: "privacy policy.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
